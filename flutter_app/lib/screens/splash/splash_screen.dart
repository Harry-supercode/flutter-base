import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/blocs/common/common_bloc.dart';
import 'package:flutter_app/blocs/common/common_event.dart';
import 'package:flutter_app/extensions/context_ext.dart';
import 'package:flutter_app/screens/auth/auth_page.dart';
import 'package:flutter_app/screens/home/main_page.dart';
import 'package:flutter_app/services/deep_links_service.dart';
import 'package:flutter_app/shared_pref_services.dart';

class SplashScreen extends StatefulWidget {
  // Constructor
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// ================================================
  /// ================== [FUNCTIONS] =================
  /// ================================================

  // Get data common from BE
  _getDataCommon() {
    context.read<CommonBloc>().add(GetListDataCommonEvent());
  }

  // Redirect screen function
  _checkIfLogin() async {
    var duration = const Duration(seconds: 2);

    final sPref = await SharedPreferencesService.instance;
    final token = sPref.token;

    return Future.delayed(duration, () {
      if (token.isNotEmpty) {
        _moveToHome();
      } else {
        _moveToSignIn();
      }
      DeepLinksService.instance.handleDeepLink();
    });
  }

  // Redirect to Sign-In screen
  _moveToSignIn() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthPage()),
        (Route<dynamic> route) => false);
  }

  // Redirect to home screen
  _moveToHome() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => const MainPage(),
            settings: const RouteSettings(name: MainPage.routeName)),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // Get data common from BE
    _getDataCommon();

    // Redirect to sign-in/sign-up/main screen
    _checkIfLogin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: context.width,
          height: context.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/icons/ic_background_splash.png'),
                  fit: BoxFit.fill)),
          child: Image.asset(
            'assets/icons/ic_logo.png',
          )),
    );
  }
}
