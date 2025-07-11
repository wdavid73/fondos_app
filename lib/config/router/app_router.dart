import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/cubits/introduction_cubit/introduction_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'go_router_notifier.dart';
import 'redirect_handler.dart';
import 'routes_generator.dart';

String? _handleOnboardingRedirect(BuildContext context, GoRouterState state) {
  if (Environment.showOnboarding == true) {
    final introductionCubit = getIt.get<IntroductionCubit>();

    if (introductionCubit.state.isLoading) {
      return null;
    }

    final isOnboardingCompleted = introductionCubit.state.hasSeen;
    final currentPath = state.uri.path;

    if (!isOnboardingCompleted &&
        currentPath != RouteConstants.onboardingScreen) {
      return RouteConstants.onboardingScreen;
    }
  }
  return null;
}

/// Creates and configures the application's [GoRouter] instance.
///
/// This function initializes the [GoRouter] with the application's routes,
/// initial location, refresh listener, and redirection logic. It uses a
/// [GoRouterNotifier] to listen for changes in the authentication state and
/// the [appRedirect] function to handle redirection based on the current
/// authentication status and route.
///
/// Parameters:
///   - [authBloc]: The [AuthBloc] instance used to manage the authentication state.
///
/// Returns:
///   - A configured [GoRouter] instance ready to be used in the application.
GoRouter createAppRouter(AuthBloc authBloc) {
  final goRouterNotifier = GoRouterNotifier(authBloc);

  return GoRouter(
    initialLocation: Environment.showOnboarding
        ? RouteConstants.onboardingScreen
        : RouteConstants.splash,
    refreshListenable: goRouterNotifier,
    routes: AppRoutes.getAppRoutes(),
    redirect: (context, state) {
      final onboardingRedirect = _handleOnboardingRedirect(context, state);

      if (onboardingRedirect != null) {
        return onboardingRedirect;
      }

      final isOnboardingCompleted =
          getIt.get<IntroductionCubit>().state.hasSeen;

      return appRedirect(
        goRouterNotifier,
        state,
        Environment.showOnboarding == true ? isOnboardingCompleted : true,
      );
    },
  );
}
