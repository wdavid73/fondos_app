import 'package:flutter_starter_kit/data/data.dart';
import 'package:flutter_starter_kit/domain/datasources/auth_datasource.dart';

/// Example JSON response for login and checkAuthStatus:
///
/// ```json
/// {
///   "id": "fb0ae2b2-8bd3-448b-8c6b-044b0917db02",
///   "email": "test1@google.com",
///   "fullName": "Juan Carlos",
///   "isActive": true,
///   "roles": ["admin"],
///   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
/// }
/// ```
/// An implementation of [AuthDataSource] that interacts with a remote API
/// to perform authentication-related operations.
///
/// This class uses an [ApiClient] to make HTTP requests to the API endpoints
/// defined in [ApiEndpoint]. It handles the responses and converts them into
/// [ResponseState] objects, which can be either [ResponseSuccess] or
/// [ResponseFailed].
class ApiAuthDataSource implements AuthDataSource {
  /// The [ApiClient] used to make HTTP requests.

  /// Creates an [ApiAuthDataSource] instance.
  ///
  /// Parameters:
  ///   - [_client]: The [ApiClient] used to make HTTP requests.
  ApiAuthDataSource();

  @override
  Future<void> checkAuthStatus(String token) async {
    throw UnimplementedError();
  }

  /// Attempts to log in a user with the given [email] and [password].
  ///
  /// This method sends a POST request to the [ApiEndpoint.authLogin] endpoint
  /// with the provided credentials. If the request is successful, it returns
  /// a [ResponseSuccess] containing the [AuthResponseModel] from the response.
  /// If the request fails, it returns a [ResponseFailed] with the corresponding
  /// [DioException].
  ///
  /// Parameters:
  ///   - [email]: The user's email address.
  ///   - [password]: The user's password.
  ///
  /// Returns:
  ///   - A [Future] that resolves to a [ResponseState] representing the result of the login attempt.
  @override
  Future<void> login(String email, String password) async {
    throw UnimplementedError();
  }

  /// Attempts to register a new user with the given [email], [password], and [fullName].
  ///
  /// This method sends a request to the API to register a new user.
  /// If the request is successful, it returns a [ResponseSuccess].
  /// If the request fails, it returns a [ResponseFailed] with the corresponding
  /// [DioException].
  ///
  /// Parameters:
  ///   - [email]: The user's email address.
  ///   - [password]: The user's password.
  ///   - [fullName]: The user's full name.
  ///
  /// Returns:
  ///   - A [Future] that resolves to a [ResponseState] representing the result of the registration attempt.
  @override
  Future<void> register(
    String email,
    String password,
    String fullName,
  ) async {
    throw UnimplementedError();
  }
}
