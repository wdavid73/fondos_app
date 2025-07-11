import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TransitionType { slideRight, slideLeft, fade }

class TransitionManager {
  static CustomTransitionPage<void> buildCustomTransitionPage(
    Widget child,
    TransitionType? transitionType,
  ) {
    Duration transitionDuration = Duration(milliseconds: 300);

    return CustomTransitionPage(
      child: child,
      transitionDuration: transitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case TransitionType.slideRight:
            return _slideTransition(animation, child, Offset(1.0, 0.0));
          case TransitionType.slideLeft:
            return _slideTransition(animation, child, Offset(-1.0, 0.0));
          case TransitionType.fade:
            return _fadeTransition(animation, child);
          default:
            return child;
        }
      },
    );
  }

  static SlideTransition _slideTransition(
    Animation<double> animation,
    Widget child,
    Offset begin,
  ) {
    const curve = Curves.easeInOut;
    var tween = Tween(
      begin: begin,
      end: Offset.zero,
    ).chain(
      CurveTween(curve: curve),
    );
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  static FadeTransition _fadeTransition(
    Animation<double> animation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}