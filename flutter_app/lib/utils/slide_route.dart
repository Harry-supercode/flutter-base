import 'package:flutter/material.dart';

class RouteTransition extends PageRouteBuilder {
  // Screen widget
  final Widget widget;

  // Enable fade animation
  final bool fade;

  // Transition duration
  final Duration? duration;

// Constructor
  RouteTransition({
    required this.widget,
    this.fade = false,
    this.duration,
  }) : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: duration ?? const Duration(milliseconds: 200),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              if (fade) {
                return FadeTransition(opacity: animation, child: child);
              }
              {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              }
            });
}
