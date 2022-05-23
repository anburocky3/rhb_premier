import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rhb_premier/models/LoginResponse.dart';
import 'package:rhb_premier/services/api.dart';
import 'package:rhb_premier/sharedPreferences/Const.dart';
import 'package:rhb_premier/sharedPreferences/Prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;
  late String _token;
  late String _userData;
  ApiService apiService = ApiService();

  AuthProvider() {
    init();
    syncPrefs();
  }

  Future<void> init() async {
    this._token = await Prefs.token;
    if (this._token.isNotEmpty) {
      this.isAuthenticated = true;
    }
    // this.apiService = new ApiService(this._token);
    notifyListeners();
  }

  String get getToken => _token;

  String get getUserData => _userData;

  Future<void> login(String email, String password, String deviceName) async {
    await apiService.login(email, password, deviceName);
  }

  Future<void> validateSecurityCode(
      String email, String securityCode, String deviceName) async {
    LoginResponse loginResponse =
        await apiService.validateSecurityCode(email, securityCode, deviceName);

    String tokenData = loginResponse.token!;
    String userDetailData = jsonEncode(loginResponse.user);
    // print('loginResponse:    ' + loginResponse.user!.toJson().toString());
    // print('loginResponse:    ' + userDetail);

    _token = tokenData;
    _userData = userDetailData;
    await Prefs.setToken(_token);
    await Prefs.setUserData(_userData);
    this.isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await apiService.logout();

    this._token = '';
    this.isAuthenticated = false;
    Prefs.setToken(this._token);

    notifyListeners();
  }

  void syncPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Const.TOKEN) ?? '';
    String userData = prefs.getString(Const.USER_DATA) ?? '';

    _token = token;
    _userData = userData;
    notifyListeners();
  }

// Future<void> setToken(String token) async {
//   final pref = await SharedPreferences.getInstance();
//   pref.setString('token', token);
// }
//
// Future<String> getToken() async {
//   final pref = await SharedPreferences.getInstance();
//   return pref.getString('token') ?? '';
// }

}
