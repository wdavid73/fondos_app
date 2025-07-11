import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/api/api.dart';
import 'package:flutter_starter_kit/data/data.dart';
import 'package:flutter_starter_kit/domain/usecases/auth_usecase.dart';
import 'package:flutter_starter_kit/ui/shared/service/service.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc_handler.dart';

/// A BLoC (Business Logic Component) for managing authentication-related events and states.
///
/// This class handles events such as login, logout, checking authentication
/// status, and registration. It uses an [AuthUseCase] to interact with the
/// authentication logic and a [KeyValueStorageService] to manage persistent
/// data.
class AuthBloc extends Bloc<AuthEvent, AuthState> with AuthBlocHandler {
  /// The [AuthUseCase] used to perform authentication operations.
  final AuthUseCase useCase;

  /// The [KeyValueStorageService] used to manage persistent data.
  final KeyValueStorageService keyValueStorageService;

  /// Creates an [AuthBloc] instance.
  ///
  /// Parameters:
  ///   - [useCase]: The [AuthUseCase] used to perform authentication operations.
  ///   - [keyValueStorageService]: The [KeyValueStorageService] used to manage persistent data.
  AuthBloc(this.useCase, this.keyValueStorageService) : super(AuthState()) {
    on<LoginEvent>(handlerLogin);
    on<CheckAuthStatusEvent>(handlerCheckAuthStatus);
    on<LogoutEvent>(handlerLogout);
    on<RegisterEvent>(handlerRegister);

    Future.delayed(Duration.zero, () => checkAuthStatus());
  }

  /// Triggers the login process with the given [email] and [password].
  ///
  /// This method adds a [LoginEvent] to the BLoC.
  ///
  /// Parameters:
  ///   - [email]: The user's email address.
  ///   - [password]: The user's password.
  void login(String email, String password) {
    add(LoginEvent(email: email, password: password));
  }

  /// Triggers the registration process with the given [email], [password], and [fullName].
  ///
  /// This method adds a [RegisterEvent] to the BLoC.
  ///
  /// Parameters:
  ///   - [email]: The user's email address.
  ///   - [password]: The user's password.
  ///   - [fullName]: The user's full name.
  void register({
    required String email,
    required String password,
    required String fullName,
  }) {
    add(RegisterEvent(email: email, password: password, fullName: fullName));
  }

  /// Triggers the check authentication status process.
  ///
  /// This method adds a [CheckAuthStatusEvent] to the BLoC.
  void checkAuthStatus() {
    add(CheckAuthStatusEvent());
  }

  /// Triggers the logout process.
  ///
  /// This method adds a [LogoutEvent] to the BLoC.
  void logout() {
    add(LogoutEvent());
  }
}
