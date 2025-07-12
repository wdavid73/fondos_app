import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/ui/widgets/shared_app_bar.dart';
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

      if (kIsWeb)
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              appBar: WebAppBar(),
              body: child,
            );
          },
          routes: routes,
        )
      else
        ...routes
    ];
  }
}

List<GoRoute> routes = [
  ///* HOME ROUTE
  GoRoute(
    path: RouteConstants.home,
    name: "home",
    builder: (context, state) => const HomeScreen(),
  ),

  GoRoute(
    path: RouteConstants.myInvestmentsScreen,
    name: 'my_investment',
    builder: (_, __) => const MyInvestmentsScreen(),
  ),

  GoRoute(
    path: RouteConstants.transactionsScreen,
    name: 'transactions',
    builder: (_, __) => const TransactionsScreen(),
  ),
];

/* CustomTransitionPage<void> _transitionPage({
  required Widget child,
  TransitionType? transitionType,
}) =>
    TransitionManager.buildCustomTransitionPage(
      child,
      transitionType,
    );
 */
