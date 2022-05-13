import 'dart:convert';
import 'dart:io';

import 'package:rhb_premier/models/LoginResponse.dart';
import 'package:rhb_premier/models/Transaction.dart';
import 'package:http/http.dart' as http;
import 'package:rhb_premier/providers/AuthProvider.dart';

class ApiService {
  late String token;

  ApiService(String token) {
    this.token = token;
  }

  // static const String BASE_URL = 'http://192.168.0.106/rhbpb-bank/api/v1/';
  static const String BASE_URL = 'https://www.rhbpb.com/web/api/v1/';

  Future<String> login(String email, String password, String deviceName) async {
    String uri = BASE_URL + "auth/login";
    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode(
          {'email': email, 'password': password, 'device_name': deviceName}),
    );

    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

    return email;
  }

  Future<LoginResponse> validateSecurityCode(
      String email, String securityCode, String deviceName) async {
    String uri = BASE_URL + "auth/verify";
    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'security_code': securityCode,
        'device_name': deviceName
      }),
    );

    String errorMessage = '';

    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];

      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

    return LoginResponse.fromJson(json.decode(response.body));
  }

  Future<List<Transaction>> fetchTransactions() async {
    String uri = BASE_URL + "transactions";
    http.Response response = await http.post(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    if (response.statusCode == 401) {
      Map<String, dynamic> body = jsonDecode(response.body);

      await Future.delayed(Duration(milliseconds: 150));
      // context.showToast('Unauthenticated, so logging out!');
      AuthProvider().logout();
      // throw Exception(body);
    }

    List transactions = jsonDecode(response.body);
    return transactions
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
  }

  Future<http.Response> logout() async {
    String uri = BASE_URL + "auth/logout";
    http.Response response = await http.post(Uri.parse(uri), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    http.Response resObj = jsonDecode(response.body);
    return resObj;
  }
}
