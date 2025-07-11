import 'package:flutter_starter_kit/api/api.dart';
import '../repositories/auth_repository.dart';

/// A use case class for handling authentication-related operations.
///
/// This class provides methods for logging in, checking the authentication
/// status, and registering a new user. It interacts with an [AuthRepository]
/// to perform these operations.
class AuthUseCase {
  /// The [AuthRepository] used to perform authentication operations.
  final AuthRepository repository;

  /// Creates an [AuthUseCase] instance.
  ///
  /// Parameters:
  ///   - [repository]: The [AuthRepository] used to perform authentication operations.
  AuthUseCase(this.repository);

  /// Attempts to log in a user with the given [email] and [password].
  ///
  /// This method delegates the login operation to the [AuthRepository].
  ///
  /// Parameters:
  ///   - [email]: The user's email address.
  ///   - [password]: The user's password.
  ///
  /// Returns:
  ///   - A [Future] that resolves to a [ResponseState] representing the result of the login attempt.
  Future<ResponseState> login(String email, String password) {
    return repository.login(email, password);
  }

  /// Checks the authentication status using the given [token].
  ///
  /// This method delegates the check authentication status operation to the [AuthRepository].
  ///
  /// Parameters:
  ///   - [token]: The authentication token.
  ///
  /// Returns:
  ///   - A [Future] that resolves to a [ResponseState] representing the result of the authentication status check.
  Future<ResponseState> checkAuthStatus(String token) {
    return repository.checkAuthStatus(token);
  }

  /// Attempts to register a new user with the given [email], [password], and [fullName].
  ///
  /// This method delegates the register operation to the [AuthRepository].
  ///
  /// Parameters:
  ///   - [email]: The user's email address.
  ///   - [password]: The user's password.
  ///   - [fullName]: The user's full name.
  ///
  /// Returns:
  ///   - A [Future] that resolves to a [ResponseState] representing the result of the registration attempt.
  Future<ResponseState> register(
      String email, String password, String fullName) {
    return repository.register(email, password, fullName);
  }
}
