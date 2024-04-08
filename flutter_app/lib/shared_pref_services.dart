import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/models/auth/auth_response.dart';
import 'package:flutter_app/models/user/user_model.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String languageCd = 'languageCd';
  static const String themeFlag = 'themeFlag';
  static const String userId = 'userId';
  static const String authResponse = 'authResponse';
  static const String userProfile = 'userProfile';
  static const String token = 'token';
  static const String password = 'password';
  static const String isLoginBySocial = 'isLoginBySocial';
  static const String isLimited = 'isLimited';
}

class SharedPreferencesService {
  static late SharedPreferencesService _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    _instance = SharedPreferencesService._internal();

    _preferences = await SharedPreferences.getInstance();

    return _instance;
  }

  // Set token
  Future<void> setToken(String token) async =>
      await _preferences.setString(SharedPrefKeys.token, token);

  // Get token
  String get token => _preferences.getString(SharedPrefKeys.token) ?? '';

  // Set login by social
  Future<void> setIsLoginBySocial(bool bySocial) async =>
      await _preferences.setBool(SharedPrefKeys.isLoginBySocial, bySocial);

  // Get login by social
  bool get isLoginBySocial =>
      _preferences.getBool(SharedPrefKeys.isLoginBySocial) ?? false;

  // Set access image limited
  Future<void> setIsAccessLimited(bool isLimited) async =>
      await _preferences.setBool(SharedPrefKeys.isLimited, isLimited);

  // Get access image flag
  bool get isAccessLimited =>
      _preferences.getBool(SharedPrefKeys.isLimited) ?? false;

  // Set language local
  Future<void> setLanguage(String langCode) async =>
      await _preferences.setString(SharedPrefKeys.languageCd, langCode);

  // Get language local
  String get languageCode =>
      _preferences.getString(SharedPrefKeys.languageCd) ?? '';

  // Set userId
  Future<void> setUserId(int id) async =>
      await _preferences.setInt(SharedPrefKeys.userId, id);

  // Get userId
  int get userId => _preferences.getInt(SharedPrefKeys.userId) ?? -1;

  // Set theme local
  Future<void> setTheme(bool isDarkMode) async =>
      await _preferences.setBool(SharedPrefKeys.themeFlag, isDarkMode);

  // Get theme local
  bool get isDarkMode =>
      _preferences.getBool(SharedPrefKeys.themeFlag) ?? false;

  // Set auth response
  Future<void> setAuthResponse(AuthResponse authResponse) async {
    final modelToString = jsonEncode(authResponse.toJson());
    await setToken(authResponse.token ?? '');
    await setUserId(authResponse.data?.id ?? -1);
    await _preferences.setString(SharedPrefKeys.authResponse, modelToString);
  }

  // Get auth response
  AuthResponse? get authResponse {
    final modelString = _preferences.getString(SharedPrefKeys.authResponse);
    if (modelString != null && modelString.isNotEmpty) {
      return AuthResponse.fromJson(jsonDecode(modelString));
    }
    return null;
  }

  // Set user profile
  Future<void> setUserProfile(UserModel userModel) async {
    final modelToString = jsonEncode(userModel.toJson());
    await _preferences.setString(SharedPrefKeys.userProfile, modelToString);
  }

  // Get user profile
  UserModel? get userProfile {
    final modelString = _preferences.getString(SharedPrefKeys.userProfile);
    if (modelString != null && modelString.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(modelString));
    }
    return null;
  }

  // Set user profile
  Future<void> setPassword(String encrypted) async {
    await _preferences.setString(SharedPrefKeys.password, encrypted);
  }

  // Get user profile
  get getPassword {
    return _preferences.getString(SharedPrefKeys.password) ?? Constant.empty;
  }

  Future<void> logOut() async {
    await Future.wait([
      _preferences.remove(SharedPrefKeys.authResponse),
      _preferences.remove(SharedPrefKeys.token)
    ]);
  }
}
