part of 'auth_bloc.dart';

mixin AuthBlocHandler on Bloc<AuthEvent, AuthState> {
  Future<void> handlerLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.checking));

    final response = await (this as AuthBloc).useCase.login(
          event.email,
          event.password,
        );

    if (response is ResponseFailed) {
      emit(state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: response.error!.message.toString(),
      ));
      return;
    }

    AuthResponseModel authResponse = response.data;

    await (this as AuthBloc).keyValueStorageService.setKeyValue(
          'token',
          authResponse.token,
        );
    emit(state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: authResponse.user,
      errorMessage: '',
    ));
  }

  Future<void> handlerCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final String? token =
        await (this as AuthBloc).keyValueStorageService.getValue('token');

    if (token == null) {
      await _clearTokenAndEmitNotAuthenticated(emit);
      return;
    }

    try {
      final response = await (this as AuthBloc).useCase.checkAuthStatus(token);
      if (response is ResponseFailed) {
        await _clearTokenAndEmitNotAuthenticated(emit);
        return;
      }

      // * this is part is particular of api service used
      final authResponse = response.data as AuthResponseModel;
      await (this as AuthBloc)
          .keyValueStorageService
          .setKeyValue('token', authResponse.token);

      emit(state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: authResponse.user,
        errorMessage: '',
      ));
    } catch (e) {
      await _clearTokenAndEmitNotAuthenticated(emit);
    }
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
    emit(state.copyWith(isCreating: true));

    final response = await (this as AuthBloc)
        .useCase
        .register(event.email, event.password, event.fullName);

    if (response is ResponseFailed) {
      emit(state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: response.error!.message.toString(),
      ));
      return;
    }

    AuthResponseModel authResponse = response.data;

    await (this as AuthBloc)
        .keyValueStorageService
        .setKeyValue("token", authResponse.token);

    emit(state.copyWith(
      isCreating: false,
      authStatus: AuthStatus.authenticated,
      user: authResponse.user,
      errorMessage: '',
    ));
  }

  Future<void> _clearTokenAndEmitNotAuthenticated(
      Emitter<AuthState> emit) async {
    await (this as AuthBloc).keyValueStorageService.removeKey('token');
    emit(
      state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          errorMessage: '',
          user: null),
    );
  }
}
