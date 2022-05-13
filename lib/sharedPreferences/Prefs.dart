import 'dart:convert';

import 'package:rhb_premier/models/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Const.dart';
import 'PreferencesHelper.dart';

class Prefs {
  static Future<String> get token => PreferencesHelper.getString(Const.TOKEN);

  static Future setToken(String value) =>
      PreferencesHelper.setString(Const.TOKEN, value);

  static Future<User?> get userData async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    String? userData = sharedPrefs.getString(Const.USER_DATA);

    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      var user = User.fromJson(userMap);
      // print('userDataFromPrefs: ${user.toString()}');
      return user;
    } else {
      print('Data not found');
    }
    return null;
  }

  static Future<void> setUserData(String value) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString(Const.USER_DATA, value);
  }

  // static Future<bool> get authenticated => PreferencesHelper.getBool(Const.AUTHENTICATED);
  //
  // static Future setAuthenticated(bool value) => PreferencesHelper.setBool(Const.AUTHENTICATED, value);
  //
  // static Future<String> get passcode => PreferencesHelper.getString(Const.PASSCODE);
  //
  // static Future setPasscode(String value) => PreferencesHelper.setString(Const.PASSCODE, value);

  Future<void> clear() async {
    await Future.wait(<Future>[
      // setAuthenticated(false),
      // setPasscode(''),
    ]);
  }
}
