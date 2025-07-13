part of 'auth_bloc.dart';

/// Mixin that provides handler methods for authentication-related events in [AuthBloc].
///
/// This mixin defines the logic for handling login, authentication status check,
/// logout, and registration events, updating the [AuthState] accordingly.
mixin AuthBlocHandler on Bloc<AuthEvent, AuthState> {
  /// Handles the login event.
  ///
  /// Throws [UnimplementedError] by default. Should be implemented in [AuthBloc].
  Future<void> handlerLogin(LoginEvent event, Emitter<AuthState> emit) async {
    throw UnimplementedError();
  }

  /// Handles the check authentication status event.
  ///
  /// Emits the current state by default.
  Future<void> handlerCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    return emit(state);
  }

  /// Handles the logout event.
  ///
  /// Removes the stored token and updates the authentication status to not authenticated.
  Future<void> handlerLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await (this as AuthBloc).keyValueStorageService.removeKey('token');
    emit(state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: '',
      user: null,
    ));
  }

  /// Handles the register event.
  ///
  /// Throws [UnimplementedError] by default. Should be implemented in [AuthBloc].
  Future<void> handlerRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    throw UnimplementedError();
  }
}
