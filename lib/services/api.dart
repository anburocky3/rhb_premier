import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rhb_premier/models/LoginResponse.dart';
import 'package:rhb_premier/models/Transaction.dart';
import 'package:rhb_premier/sharedPreferences/Prefs.dart';

import 'dio_interceptor.dart';

class ApiService {
  final Dio dio = Dio();

  // static const String BASE_URL = 'http://192.168.0.106/rhbpb-bank/api/v1/';
  static const String BASE_URL = 'https://www.rhbpb.com/web/api/v1/';

  ApiService() {
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(AppInterceptors());
  }

  Future<String> login(String email, String password, String deviceName) async {
    String uri = BASE_URL + "auth/login";

    try {
      final response = await dio.post(
        uri,
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/json',
          Headers.acceptHeader: 'application/json',
        }),
        data: jsonEncode(
            {'email': email, 'password': password, 'device_name': deviceName}),
      );

      debugPrint(response.toString());

      return email;
    } on DioError catch (e) {
      String errorMessage = '';

      if (e.response?.statusCode == 422) {
        Map<String, dynamic> body = e.response?.data;
        Map<String, dynamic> errors = body['errors'];
        errors.forEach((key, value) {
          value.forEach((element) {
            errorMessage += element + '\n';
          });
        });
      }
      throw Exception(errorMessage);
    }
  }

  Future<LoginResponse> validateSecurityCode(
      String email, String securityCode, String deviceName) async {
    String uri = BASE_URL + "auth/verify";

    try {
      final response = await dio.post(
        uri,
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/json',
          Headers.acceptHeader: 'application/json',
        }),
        data: {
          'email': email,
          'security_code': securityCode,
          'device_name': deviceName
        },
      );

      return LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      String errorMessage = '';

      if (e.response?.statusCode == 422) {
        Map<String, dynamic> body = e.response?.data;
        Map<String, dynamic> errors = body['errors'];

        errors.forEach((key, value) {
          value.forEach((element) {
            errorMessage += element + '\n';
          });
        });
      }
      throw Exception(errorMessage);
    }
  }

  Future<User> getCurrentUser() async {
    String uri = BASE_URL + "auth/details";

    final response = await dio.post(
      uri,
      options: Options(headers: {
        Headers.contentTypeHeader: 'application/json',
        Headers.acceptHeader: 'application/json',
        "requiresToken": true
      }),
    );

    return User.fromJson(response.data);
  }

  Future<List<Transaction>> fetchTransactions() async {
    String uri = BASE_URL + "transactions";

    final response = await dio.post(
      uri,
      options: Options(headers: {
        Headers.contentTypeHeader: 'application/json',
        Headers.acceptHeader: 'application/json',
        // HttpHeaders.authorizationHeader: 'Bearer $token',
        // Headers.wwwAuthenticateHeader: 'Bearer $token',
        "requiresToken": true
      }),
    );

    List transactions = response.data;
    return transactions
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
  }

  Future<void> logout() async {
    String uri = BASE_URL + "auth/logout";
    User? user = await Prefs.userData;

    await dio.post(
      uri,
      data: {'user_id': user?.id},
      options: Options(headers: {
        Headers.contentTypeHeader: 'application/json',
        Headers.acceptHeader: 'application/json',
        // HttpHeaders.authorizationHeader: 'Bearer $token',
        // Headers.wwwAuthenticateHeader: 'Bearer $token'
        "requiresToken": true
      }),
    );
  }
}
