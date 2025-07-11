import 'package:go_router/go_router.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'go_router_notifier.dart';
import 'routes_constants.dart';

// Defines a type for functions that handle redirection based on the current path.
///
/// A `RedirectHandler` takes a [currentPath] as input and returns a [String]
/// representing the path to redirect to, or `null` if no redirection is needed.
typedef RedirectHandler = String? Function(String currentPath);

/// A map that associates each [AuthStatus] with its corresponding [RedirectHandler].
///
/// This map is used to determine the appropriate redirection logic based on the
/// current authentication status.
Map<AuthStatus, RedirectHandler> redirectHandlers = {
  AuthStatus.checking: (currentPath) => _handleCheckingRedirect(currentPath),
  AuthStatus.notAuthenticated: (currentPath) =>
      _handleNotAuthenticatedRedirect(currentPath),
  AuthStatus.authenticated: (currentPath) =>
      _handleAuthenticatedRedirect(currentPath),
};

/// Handles redirection logic when the authentication status is [AuthStatus.checking].
///
/// If the [currentPath] is the splash screen, it returns the splash screen path.
/// Otherwise, it returns `null`, indicating no redirection is needed.
///
/// Parameters:
///   - [currentPath]: The current path in the application.
///
/// Returns:
///   - The splash screen path if the current path is the splash screen, otherwise `null`.
String? _handleCheckingRedirect(String currentPath) {
  return currentPath == RouteConstants.splash ? RouteConstants.splash : null;
}

/// Handles redirection logic when the authentication status is [AuthStatus.notAuthenticated].
///
/// If the [currentPath] is the login or register screen, it returns `null`,
/// indicating no redirection is needed. Otherwise, it returns the login screen path.
///
/// Parameters:
///   - [currentPath]: The current path in the application.
///
/// Returns:
///   - `null` if the current path is the login or register screen, otherwise the login screen path.
String? _handleNotAuthenticatedRedirect(String currentPath) {
  return (currentPath == RouteConstants.loginScreen ||
          currentPath == RouteConstants.registerScreen)
      ? null
      : RouteConstants.loginScreen;
}

/// Handles redirection logic when the authentication status is [AuthStatus.authenticated].
///
/// If the [currentPath] is the login, register, or splash screen, it returns the
/// home screen path. Otherwise, it returns `null`, indicating no redirection is needed.
///
/// Parameters:
///   - [currentPath]: The current path in the application.
///
/// Returns:
///   - The home screen path if the current path is the login, register, or splash screen, otherwise `null`.
String? _handleAuthenticatedRedirect(String currentPath) {
  return [
    RouteConstants.loginScreen,
    RouteConstants.registerScreen,
    RouteConstants.splash
  ].contains(currentPath)
      ? RouteConstants.home
      : null;
}

/// Determines the appropriate redirection path based on the authentication status.
///
/// This function uses the [redirectHandlers] map to select the correct redirection
/// logic based on the [authStatus]. It then executes the selected logic with the
/// [currentPath] to determine the redirection path.
///
/// Parameters:
///   - [goRouterNotifier]: The notifier that holds the current authentication status.
///   - [state]: The current GoRouter state.
///
/// Returns:
///   - A [String] representing the path to redirect to, or `null` if no redirection is needed.
String? appRedirect(
  GoRouterNotifier goRouterNotifier,
  GoRouterState state,
  bool isOnboardingCompleted,
) {
  final currentPath = state.uri.path;
  final authStatus = goRouterNotifier.authStatus;

  if (isOnboardingCompleted) {
    final handler = redirectHandlers[authStatus];
    return handler?.call(currentPath);
  }

  return null;
}
