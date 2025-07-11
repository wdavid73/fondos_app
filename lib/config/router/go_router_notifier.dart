import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';

/// A [ChangeNotifier] that listens to changes in the authentication state and
/// notifies its listeners when the state changes.
///
/// This class is used to provide a reactive way for the [GoRouter] to be
/// notified of changes in the authentication status, allowing it to redirect
/// the user to the appropriate screen based on their authentication state.
class GoRouterNotifier extends ChangeNotifier {
  /// The [AuthBloc] instance used to listen for changes in the authentication state.
  final AuthBloc authBloc;

  /// A subscription to the [AuthBloc]'s stream of authentication states.
  late final StreamSubscription _subscription;

  /// The current authentication status.
  AuthStatus _authStatus = AuthStatus.checking;

  /// Creates a [GoRouterNotifier] instance.
  ///
  /// This constructor initializes the [_authStatus] with the current
  /// authentication status from the [authBloc] and sets up a listener to the
  /// [authBloc]'s stream to update the [_authStatus] and notify listeners
  /// whenever the authentication status changes.
  ///
  /// Parameters:
  ///   - [authBloc]: The [AuthBloc] instance to listen to.
  GoRouterNotifier(this.authBloc) {
    _authStatus = authBloc.state.authStatus;

    _subscription = authBloc.stream.listen((state) {
      if (state.authStatus != _authStatus) {
        _authStatus = state.authStatus;
        notifyListeners();
      }
    });
  }

  /// Gets the current authentication status.
  ///
  /// Returns:
  ///   - The current [AuthStatus].
  AuthStatus get authStatus => _authStatus;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
