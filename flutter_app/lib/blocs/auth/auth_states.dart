import 'package:flutter_app/models/auth/auth_response.dart';

abstract class AuthStates {
  const AuthStates();
}

/// ================================================
/// ================== [LOGIN] =================
/// ================================================

class LoginInitial extends AuthStates {
  const LoginInitial();
}

class LoginLoading extends AuthStates {
  const LoginLoading();
}

class LoginSuccess extends AuthStates {
  // Token
  final AuthResponse authResponse;
  final int time;

  // Constructor
  const LoginSuccess({required this.authResponse, required this.time});
}

class LoginFailed extends AuthStates {
  // Error message
  final String message;

  // Constructor
  const LoginFailed({required this.message});
}

/// ================================================
/// ================== [REGISTRATION] =================
/// ================================================

class RedirectSetupAccount extends AuthStates {
  final Map<String, dynamic>? userInfo;

  const RedirectSetupAccount({this.userInfo});
}

class ValidNextStep extends AuthStates {
  final bool isValid;
  final int time;

  const ValidNextStep({required this.isValid, required this.time});
}

class SetupModelSuccess extends AuthStates {
  final int time;

  const SetupModelSuccess({required this.time});
}

class RegisterAccountSuccess extends AuthStates {
  const RegisterAccountSuccess();
}

class NextPageAuth extends AuthStates {
  final int time;

  const NextPageAuth({required this.time});
}

class MoveToSetupAcc extends AuthStates {
  final int time;

  const MoveToSetupAcc({required this.time});
}

class EmailIsExist extends AuthStates {
  final int time;

  const EmailIsExist({required this.time});
}

class ForgotPasswordSuccess extends AuthStates {}

class ResetPasswordSuccess extends AuthStates {}
