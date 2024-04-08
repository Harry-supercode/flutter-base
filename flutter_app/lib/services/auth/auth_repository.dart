import 'package:flutter_app/models/auth/auth_response.dart';
import 'package:flutter_app/services/api_constant.dart';
import 'package:flutter_app/services/app_exceptions.dart';
import 'package:flutter_app/services/auth/auth_interface.dart';
import 'package:flutter_app/services/dio_client.dart';

class AuthRepository implements AuthInterface {
  static late AuthRepository _instance;

  AuthRepository._internal();

  static AuthRepository get instance {
    _instance = AuthRepository._internal();
    return _instance;
  }

  @override
  Future<AuthResponse> login(
      {required String email, required String password}) async {
    final result = await DioClient().post(ApiConstant.login,
        {"email": email, "password": password, "device_name": "macbook"});

    if (result['token'] != null) {
      return AuthResponse.fromJson(result);
    }
    throw NotFoundException('Invalid username or password');
  }

  @override
  Future<AuthResponse> loginWithSocial({
    required String token,
    required String providerName,
    Map<String, dynamic>? userInfo,
  }) async {
    final body = {
      "access_token": token,
      "provider_name": providerName,
      "email": userInfo?['email']
    };

    if (userInfo?['access_token_secret'] != null) {
      body['access_token_secret'] = userInfo?['access_token_secret'];
    }

    final result = await DioClient().post(ApiConstant.loginSocial, body);

    if (result['success'] == false) {
      throw SocialNotRegisterException(token: token, userInfo: userInfo);
    }
    return AuthResponse.fromJson(result);
  }

  @override
  Future<AuthResponse> registerUserSocial(Map body) async {
    final result =
        await DioClient().postFormData(ApiConstant.registerSocial, body);
    return AuthResponse.fromJson(result);
  }

  @override
  Future<bool> checkExisting({required dynamic body}) async {
    final result = await DioClient().post(ApiConstant.checkExisting, body);

    return result['exists'];
  }

  @override
  Future<String> registerUser(Map body) async {
    final result =
        await DioClient().postFormData(ApiConstant.registerUser, body);

    return result['token'];
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    final result =
        await DioClient().post(ApiConstant.forgotPassword, {'email': email});

    if (result['message'] != null) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> resetPassword({required Map body}) async {
    final result = await DioClient().post(ApiConstant.resetPassword, body);
    return true;
  }

  @override
  Future<bool> updateEmailByToken({required String token}) async {
    final result = await DioClient()
        .post(ApiConstant.updateEmailByToken, {'token': token});

    if (result['message'] != null) {
      return true;
    }
    return false;
  }
}
