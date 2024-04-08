import 'package:flutter/material.dart';
import 'package:flutter_app/utils/slide_route.dart';

/// [Redirect] screen with default OS animation
/// *
/// * @param context - [BuildContext]
/// * @param page - [Widget] screen
/// * @param routeNm - [String] routeName to handle popUntil

String myTeamScreen = "";
kOpenPage(BuildContext context, Widget page, {String? routeNm}) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(name: routeNm),
      builder: (BuildContext context) => page,
    ),
  );
}

kOpenPageReplacement(BuildContext context, Widget page, {String? routeNm}) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      settings: RouteSettings(name: routeNm),
      builder: (BuildContext context) => page,
    ),
  );
}

kOpenPageAndRemove(BuildContext context, Widget page, {String? routeNm}) {
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: routeNm),
        builder: (BuildContext context) => page,
      ),
      (Route<dynamic> route) => false);
}

/// [Redirect] screen with animation
/// *
/// * @param context - [BuildContext]
/// * @param page - [Widget] screen
/// * @param duration - [Duration] animation's duration
kOpenPageSlide(BuildContext context, Widget page, {Duration? duration}) {
  return Navigator.push(
    context,
    RouteTransition(
        // fade: false,
        widget: page,
        duration: duration),
  );
}

/// [Pop] screen
/// *
/// * @param context - [BuildContext]
kBackBtn(BuildContext context) {
  Navigator.pop(context);
}

/// [Pop] until screen
/// *
/// * @param context - [BuildContext]
/// * @param context - [String] routeName
kPopUntil(BuildContext context, String routeNm) {
  Navigator.of(context).popUntil(ModalRoute.withName(routeNm));
}

/// [Pop] dispose screen
/// *
/// * @param context - [BuildContext]
kPop(BuildContext context, {dynamic arg}) {
  Navigator.pop(context, arg);
}
