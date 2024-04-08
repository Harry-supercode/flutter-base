import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constants/message_constants.dart';
import 'package:flutter_app/models/auth/check_existing_req.dart';
import 'package:flutter_app/models/auth/setup_first_account_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/blocs/auth/auth_events.dart';
import 'package:flutter_app/blocs/auth/auth_states.dart';
import 'package:flutter_app/blocs/base_bloc.dart';
import 'package:flutter_app/components/dialogs/alert_dialog.dart';
// import 'package:flutter_app/components/social_button.dart';
// import 'package:flutter_app/constants/message_constants.dart';
// import 'package:flutter_app/models/auth/check_existing_req.dart';
// import 'package:flutter_app/models/auth/setup_first_account_model.dart';
// import 'package:flutter_app/models/common/sport_model.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/services/app_exceptions.dart';
import 'package:flutter_app/services/auth/auth_repository.dart';
import 'package:flutter_app/services/common/common_interface.dart';
import 'package:flutter_app/services/common/common_repository.dart';
// import 'package:flutter_app/services/social_services.dart';
// import 'package:flutter_app/services/team/team_repository.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/utils/validate_utils.dart';

class AuthBloc extends BaseBlocCustom<AuthEvents, AuthStates> {
  // Define all field from UI
  SetupAccountModel setupAccountModel = SetupAccountModel();

  // Social? social;
  Map<String, dynamic>? userInfoLoginSocial;
  Map<String, dynamic>? args;

  AuthBloc() : super(const LoginInitial()) {
    // Request sign-in
    // on<RequestLoginSocial>(_handleSocialSignIn);
    // on<InitialModel>(_initModel);
    // on<CheckValidFieldSetupAccount>(_checkValidFieldSetupAccount);
    // on<ChangeListSports>(_changeListSports);
    // on<CheckPhoneExisting>(_checkPhoneExisting);
    // on<CreateAccount>(_createAccount);
    on<ReLogin>(_reLogin);
    on<CheckEmailIsExist>(_checkEmailExist);
    on<ForgotPasswordEvent>(_forgotPassword);
    on<ResetPasswordEvent>(_resetPassword);
  }

  _resetPassword(ResetPasswordEvent event, Emitter emit) async {
    showLoading();
    try {
      final body = {
        'token': event.token,
        'email': event.email,
        'password': event.password,
        'password_confirmation': event.passwordConfirmation,
        'device_name': 'macbook',
      };
      final result = await AuthRepository.instance.resetPassword(body: body);

      if (result) {
        emit(ResetPasswordSuccess());
      }
    } on NotFoundException catch (error) {
      AlertPopup(title: 'Error', msg: '${error.message}')
          .showAlertPopup(navigatorKey.currentState!.overlay!.context);
    }
    hideLoading();
  }

  _forgotPassword(ForgotPasswordEvent event, Emitter emit) async {
    showLoading();
    try {
      final result =
          await AuthRepository.instance.forgotPassword(email: event.email);

      if (result) {
        emit(ForgotPasswordSuccess());
      }
    } on NotFoundException catch (error) {
      AlertPopup(title: 'Error', msg: '${error.message}')
          .showAlertPopup(navigatorKey.currentState!.overlay!.context);
    }
    hideLoading();
  }

  _checkEmailExist(CheckEmailIsExist event, Emitter emit) async {
    showLoading();
    try {
      final listCheck = [
        CheckExistingReq(
          field: 'email',
          value: event.email,
        ).toJson(),
      ];

      final exists =
          await AuthRepository.instance.checkExisting(body: listCheck);

      if (exists) {
        emit(EmailIsExist(time: DateTime.now().millisecondsSinceEpoch));
      } else {
        emit(MoveToSetupAcc(time: DateTime.now().millisecondsSinceEpoch));
      }
    } catch (e) {}
    // Reset social variable from cache to avoid signup with email but still social
    // social = null;
    hideLoading();
  }

  _reLogin(ReLogin event, Emitter emit) async {
    showLoading();

    checkPhoneExisting(CheckPhoneExisting event, Emitter emit) async {
      if (setupAccountModel.phoneController!.text.isNotEmpty) {
        showLoading();
        final listCheck = [
          CheckExistingReq(
            field: 'phone',
            value: setupAccountModel.phoneController!.text.trim(),
          ).toJson(),
          CheckExistingReq(
            field: 'phone_code',
            value: '+${setupAccountModel.phoneCode}',
          ).toJson(),
        ];

        try {
          final exists =
              await AuthRepository.instance.checkExisting(body: listCheck);
          if (exists) {
            Fluttertoast.showToast(
              msg: MessageConstants.mgs4,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 18.0,
            );
            emit(ValidNextStep(
                isValid: false, time: DateTime.now().millisecondsSinceEpoch));
          } else {
            emit(NextPageAuth(time: DateTime.now().millisecondsSinceEpoch));
          }
        } catch (e) {
          print(e);
        }
        hideLoading();
      } else {
        emit(NextPageAuth(time: DateTime.now().millisecondsSinceEpoch));
      }
    }

    createAccount(CreateAccount event, Emitter emit) async {
      showLoading();
      try {
        if (setupAccountModel.avatar != null &&
            setupAccountModel.avatar?.file != null) {
          final uploadModel = await CommonRepository.instance.uploadFile(
              type: UploadType.avatar, file: setupAccountModel.avatar!.file!);

          // if (social == null || social == Social.normal) {
          //   final body = {
          //     'email': setupAccountModel.emailController!.text.trim(),
          //     'password': setupAccountModel.passwordController!.text,
          //     'first_name': setupAccountModel.firstNameController!.text.trim(),
          //     'last_name': setupAccountModel.lastNameController!.text.trim(),
          //     'gender': setupAccountModel.gender?.id,
          //     'birth_date': setupAccountModel.birthDay,
          //     'country_id': setupAccountModel.country?.id,
          //     'phone': setupAccountModel.phoneController!.text.trim(),
          //     'phone_code': '+${setupAccountModel.phoneCode}',
          //     'avatar_id': uploadModel.id,
          //   };
          //   setupAccountModel.listSports?.forEach((element) {
          //     body['sport_ids[${setupAccountModel.listSports!.indexOf(element)}]'] =
          //         element.id;
          //   });
          //   debugPrint(body.toString());
          //   final token = await AuthRepository.instance.registerUser(body);
          //   if (token.isNotEmpty) {
          //     final sPref = await SharedPreferencesService.instance;
          //     sPref.setToken(token);
          //     if (setupAccountModel.passwordController != null) {
          //       final prefs = await SharedPreferencesService.instance;
          //       prefs.setPassword(Crypt.instance
          //           .encrypt(setupAccountModel.passwordController!.text));
          //     }
          //     emit(const RegisterAccountSuccess());
          //   }
          // } else {
          //   String providerName = '';
          //   switch (social) {
          //     case Social.facebook:
          //       providerName = 'facebook';
          //       break;
          //     case Social.google:
          //       providerName = 'google';
          //       break;
          //     case Social.apple:
          //       providerName = 'apple';
          //       break;
          //     case Social.twitter:
          //       providerName = 'twitter';
          //       break;
          //     default:
          //   }

          //   final body = {
          //     'first_name': setupAccountModel.firstNameController!.text.trim(),
          //     'last_name': setupAccountModel.lastNameController!.text.trim(),
          //     'email': setupAccountModel.emailController != null
          //         ? setupAccountModel.emailController!.text.trim()
          //         : null,
          //     'gender': setupAccountModel.gender?.id,
          //     'birth_date': setupAccountModel.birthDay,
          //     'country_id': setupAccountModel.country?.id,
          //     'phone': setupAccountModel.phoneController!.text.trim(),
          //     'phone_code': '+${setupAccountModel.phoneCode}',
          //     'provider_name': providerName,
          //     'access_token': userInfoLoginSocial?['token'],
          //     'avatar_id': uploadModel.id,
          //   };
          //   setupAccountModel.listSports?.forEach((element) {
          //     body['sport_ids[${setupAccountModel.listSports!.indexOf(element)}]'] =
          //         element.id;
          //   });

          //   if (providerName == 'twitter') {
          //     body['access_token_secret'] =
          //         userInfoLoginSocial?['access_token_secret'];
          //   }

          //   // if (social == Social.apple) {
          //   //   body['email'] = setupAccountModel.emailController!.text.trim();
          //   // }

          //   final authResponse =
          //       await AuthRepository.instance.registerUserSocial(body);

          //   final sPref = await SharedPreferencesService.instance;
          //   await sPref.setAuthResponse(authResponse);
          //   DioClient.setToken(authResponse.token ?? '');
          //   sPref.setIsLoginBySocial(true);
          //   emit(const RegisterAccountSuccess());
          // }
        }
      } catch (e) {
        handleError(e);
        print(e.toString());
      }
      // Hide loading
      hideLoading();
    }

    changeListSports(ChangeListSports event, Emitter emit) {
      // setupAccountModel.listSports ??= <SportModel>[];

      // if (setupAccountModel.listSports!.contains(event.sportModel)) {
      //   setupAccountModel.listSports!.remove(event.sportModel);
      // } else {
      //   setupAccountModel.listSports!.add(event.sportModel);
      // }

      // emit(ValidNextStep(
      //     isValid: setupAccountModel.listSports!.isNotEmpty,
      //     time: DateTime.now().millisecondsSinceEpoch));
    }

    checkValidFieldSetupAccount(
        CheckValidFieldSetupAccount event, Emitter emit) {
      bool isValid =
          setupAccountModel.firstNameController!.text.trim().isNotEmpty &&
              setupAccountModel.lastNameController!.text.trim().isNotEmpty &&
              (setupAccountModel.phoneController!.text.isEmpty ||
                  (setupAccountModel.phoneController!.text.trim().length >= 8 &&
                      setupAccountModel.phoneController!.text.trim().length <=
                          13)) &&
              setupAccountModel.gender != null &&
              setupAccountModel.birthDay != null &&
              // setupAccountModel.country != null &&
              setupAccountModel.agree == true;

      if (setupAccountModel.emailController!.text.trim().isNotEmpty) {
        if ((setupAccountModel.isSocial && isValid) ||
            (ValidateUtils.isValidPassword(
                    setupAccountModel.passwordController!.text) &&
                isValid)) {
          isValid = true;
        } else {
          isValid = false;
        }
      }

      emit(ValidNextStep(
          isValid: isValid, time: DateTime.now().millisecondsSinceEpoch));
    }

    initModel(InitialModel event, Emitter emit) {
      setupAccountModel = SetupAccountModel();
      setupAccountModel
        ..firstNameController = TextEditingController()
        ..lastNameController = TextEditingController()
        ..phoneController = TextEditingController()
        ..emailController = TextEditingController()
        ..passwordController = TextEditingController()
        ..phoneCodeId = '163'
        ..phoneCode = '63';
      emit(SetupModelSuccess(time: DateTime.now().millisecondsSinceEpoch));
    }

    // Handle social sign-in
    handleSocialSignIn(RequestLoginSocial event, Emitter emit) async {
      showLoading();
      emit(const LoginLoading());
      try {
        // final result = await requestLogin(event);
        // if (result != null) {
        //   final sPref = await SharedPreferencesService.instance;
        //   await sPref.setAuthResponse(result);
        //   DioClient.setToken(result.token);
        //   if (event.password != null) {
        //     final prefs = await SharedPreferencesService.instance;
        //     prefs.setPassword(Crypt.instance.encrypt(event.password!));
        //   }
        //   sPref.setIsLoginBySocial(event.password == null);
        //   emit(LoginSuccess(
        //       authResponse: result, time: DateTime.now().millisecondsSinceEpoch));
        // } else {
        //   emit(LoginFailed(message: '${event.social} - Failed'));
        // }
      } on SocialNotRegisterException catch (e) {
        // TODO: Handle login social and send social token to BE
        emit(RedirectSetupAccount(userInfo: e.userInfo));
      } on NotFoundException catch (error) {
        AlertPopup(title: 'Error', msg: error.message ?? '')
            .showAlertPopup(navigatorKey.currentState!.overlay!.context);
      }
      hideLoading();
    }

    // Anonymous function to handle login by social type
    Future<dynamic> requestLogin(RequestLoginSocial event) async {
      // social = event.social;
      // switch (event.social) {
      //   case Social.google:
      //     final userInfo = await SocialServices().signInWithGPlus();
      //     userInfoLoginSocial = userInfo;
      //     return AuthRepository.instance.loginWithSocial(
      //       token: userInfo['token'],
      //       providerName: 'google',
      //       userInfo: userInfo,
      //     );
      //   case Social.facebook:
      //     final userInfo = await SocialServices().signInWithFacebook();
      //     userInfoLoginSocial = userInfo;
      //     return AuthRepository.instance.loginWithSocial(
      //       token: userInfo['token'],
      //       providerName: 'facebook',
      //       userInfo: userInfo,
      //     );
      //   case Social.apple:
      //     final userInfo = await SocialServices().signInAppleId();
      //     userInfoLoginSocial = userInfo;
      //     return AuthRepository.instance.loginWithSocial(
      //         token: userInfo['token'],
      //         providerName: 'apple',
      //         userInfo: userInfo);
      //   case Social.twitter:
      //     final userInfo = await SocialServices().signInWithTwitter();
      //     userInfoLoginSocial = userInfo;
      //     return AuthRepository.instance.loginWithSocial(
      //       token: userInfo['token'],
      //       providerName: 'twitter',
      //       userInfo: userInfo,
      //     );
      //   default:
      //     // Reset social variable from cache to avoid signup with email but still social
      //     social = null;
      //     return AuthRepository.instance
      //         .login(email: event.email!, password: event.password!);
      // }
    }
  }
}
