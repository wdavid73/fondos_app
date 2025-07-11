part of 'auth_bloc.dart';

mixin AuthBlocHandler on Bloc<AuthEvent, AuthState> {
  Future<void> handlerLogin(LoginEvent event, Emitter<AuthState> emit) async {
    throw UnimplementedError();
  }

  Future<void> handlerCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    return emit(state);
  }

  Future<void> handlerLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await (this as AuthBloc).keyValueStorageService.removeKey('token');
    emit(state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: '',
      user: null,
    ));
  }

  Future<void> handlerRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    throw UnimplementedError();
  }
}
