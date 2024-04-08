import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/auth/auth_bloc.dart';
import 'package:flutter_app/blocs/auth/auth_states.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/extensions/style_ext.dart';
import 'package:flutter_app/screens/auth/signup/setup_first_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:techedge_sport/blocs/auth/auth_bloc.dart';
// import 'package:techedge_sport/blocs/auth/auth_events.dart';
// import 'package:techedge_sport/blocs/auth/auth_states.dart';
// import 'package:techedge_sport/components/footer_social_login.dart';
// import 'package:techedge_sport/components/logo_component.dart';
// import 'package:techedge_sport/components/social_button.dart';
// import 'package:techedge_sport/constants/global_constant.dart';
// import 'package:techedge_sport/extensions/context_ext.dart';
// import 'package:techedge_sport/extensions/style_ext.dart';
// import 'package:techedge_sport/screens/auth/signup/setup_first_screen.dart';
import 'package:flutter_app/screens/home/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  /// ================================================
  /// ================== [FUNCTIONS] =================
  /// ================================================

  // Handle login normal
  _moveToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => const MainPage(),
            settings: const RouteSettings(name: MainPage.routeName)),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/icons/ic_background_splash.png'),
                fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            // const Expanded(
            //     flex: 2,
            //     child: Align(alignment: Alignment.center, child: LogoText())),
            Expanded(flex: 5, child: _buildContentUI(context)),
            Expanded(flex: 2, child: _socialLogin(context)),
          ],
        ),
      ),
    );
  }

  // Content UI
  Widget _buildContentUI(BuildContext context) {
    return BlocListener<AuthBloc, AuthStates>(
      listener: (context, state) {
        if (state is RedirectSetupAccount) {
          kOpenPage(
              context,
              SetUpFirstScreen(
                userInfo: state.userInfo,
                email: state.userInfo?['email'],
              ));
        } else if (state is LoginSuccess) {
          if (kDebugMode) {
            print(state.authResponse.token);
          }
          if (state.authResponse.token!.isNotEmpty) _moveToHome(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   context.translate('get_in_a').toUpperCase(),
              //   style: context.headerText.copyWith(fontSize: 45),
              // ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 16),
                // child: Text(
                //   context.translate('game').toUpperCase(),
                //   style: context.headerText,
                //   textAlign: TextAlign.center,
                // ),
              ),
              Platform.isIOS
                  ? InkWell(
                      // onTap: () {
                      //   context.read<AuthBloc>().add(
                      //       const RequestLoginSocial(social: Social.apple));
                      // },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/ic_apple.png',
                              width: 29,
                              height: 29,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sign in with Apple',
                              style: context.size14Black600,
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              // _itemSocial(context,
              //     title: 'continue_google',
              //     icon: 'assets/icons/ic_google.png', onTap: () {
              //   context
              //       .read<AuthBloc>()
              //       .add(const RequestLoginSocial(social: Social.google));
              // }),
              // _itemSocial(context,
              //     title: 'continue_twitter',
              //     icon: 'assets/icons/ic_twitter.png', onTap: () {
              //   context
              //       .read<AuthBloc>()
              //       .add(const RequestLoginSocial(social: Social.twitter));
              // }),
              // _itemSocial(context,
              //     title: 'continue_facebook',
              //     icon: 'assets/icons/ic_facebook.png', onTap: () {
              //   context
              //       .read<AuthBloc>()
              //       .add(const RequestLoginSocial(social: Social.facebook));
              // }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemSocial(BuildContext context,
      {required String title, required String icon, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 29,
              height: 29,
            ),
            const SizedBox(
              width: 10,
            ),
            // Text(
            //   context.translate(title),
            //   style: context.size14Black600,
            // )
          ],
        ),
      ),
    );
  }

  // Build footer socials login
  Widget _socialLogin(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/icons/ic_white_bg.png'),
              fit: BoxFit.fill)),
      // child: const FooterSocialLogin(),
    );
  }
}
