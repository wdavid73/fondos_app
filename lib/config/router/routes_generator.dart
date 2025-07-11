import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_starter_kit/ui/screens/screens.dart';
import 'routes_constants.dart';
import 'routes_transitions.dart';

/// A utility class that defines the application's route paths and generates the
/// [GoRouter] route configuration.
///
/// This class provides constants for each route path and a method to generate
/// the list of [RouteBase] objects used by [GoRouter].
class AppRoutes {
  /// Generates the list of [RouteBase] objects for the application.
  ///
  /// This method defines the route hierarchy and associates each route path
  /// with its corresponding screen or view. It also defines nested routes
  /// for the widgets screen.
  ///
  /// Returns:
  ///   - A [List] of [RouteBase] objects representing the application's routes.
  static List<RouteBase> getAppRoutes() {
    return [
      ///* SPLASH SCREEN
      GoRoute(
        path: RouteConstants.splash,
        name: "splash",
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* HOME ROUTE
      GoRoute(
        path: RouteConstants.home,
        name: "home",
        builder: (context, state) => const HomeScreen(),
      ),

      /// SETTINGS ROUTE
      GoRoute(
        path: RouteConstants.settingsScreen,
        name: "settings",
        /*builder: (context, state) => const SettingsScreen(),*/
        pageBuilder: (_, __) => _transitionPage(
          child: const SettingsScreen(),
          transitionType: TransitionType.slideRight,
        ),
      ),

      /// ONBOARDING ROUTE
      GoRoute(
        path: RouteConstants.onboardingScreen,
        name: "onboarding",
        pageBuilder: (_, __) => _transitionPage(
          child: const OnBoardingScreen(),
          transitionType: TransitionType.fade,
        ),
      ),

      ///* AUTH ROUTES
      GoRoute(
        path: RouteConstants.loginScreen,
        name: "login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.registerScreen,
        name: "register",
        builder: (context, state) => const RegisterScreen(),
      ),
    ];
  }
}

CustomTransitionPage<void> _transitionPage({
  required Widget child,
  TransitionType? transitionType,
}) =>
    TransitionManager.buildCustomTransitionPage(
      child,
      transitionType,
    );
