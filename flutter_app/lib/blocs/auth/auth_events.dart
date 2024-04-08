// import 'package:flutter_app/components/social_button.dart';
// import 'package:flutter_app/models/common/sport_model.dart';

abstract class AuthEvents {
  const AuthEvents();
}

class InitialModel extends AuthEvents {}

/// ================================================
/// ================== [LOGIN] =================
/// ================================================

class RequestLoginSocial extends AuthEvents {
  // Social type
  // final Social social;
  // final String? email;
  // final String? password;

  // Constructor
  // const RequestLoginSocial({required this.social, this.email, this.password});
}

/// ================================================
/// ================== [REGISTRATION] =================
/// ================================================

class CheckValidFieldSetupAccount extends AuthEvents {
  const CheckValidFieldSetupAccount();
}

class ChangeListSports extends AuthEvents {
  // final SportModel sportModel;
  // final int time;

  // const ChangeListSports({required this.sportModel, required this.time});
}

class CheckPhoneExisting extends AuthEvents {
  final int time;

  const CheckPhoneExisting({required this.time});
}

class CreateAccount extends AuthEvents {
  const CreateAccount();
}

class ReLogin extends AuthEvents {
  const ReLogin();
}

class CheckEmailIsExist extends AuthEvents {
  final String email;

  CheckEmailIsExist({required this.email});
}

class ForgotPasswordEvent extends AuthEvents {
  final String email;

  ForgotPasswordEvent({required this.email});
}

class ResetPasswordEvent extends AuthEvents {
  final String email;
  final String token;
  final String password;
  final String passwordConfirmation;

  ResetPasswordEvent(
      {required this.email,
      required this.token,
      required this.password,
      required this.passwordConfirmation});
}
