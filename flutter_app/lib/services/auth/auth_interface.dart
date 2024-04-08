import 'package:flutter_app/models/auth/auth_response.dart';

abstract class AuthInterface {
  Future<AuthResponse> login({required String email, required String password});

  Future<AuthResponse> loginWithSocial(
      {required String token, required String providerName});

  Future<AuthResponse> registerUserSocial(Map body);

  Future<String> registerUser(Map body);

  Future<bool> checkExisting({required dynamic body});

  Future<bool> forgotPassword({required String email});

  Future<bool> resetPassword({required Map body});

  Future<bool> updateEmailByToken({required String token});
}
