import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/api/api.dart';
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
  final ApiClient _client;

  /// Creates an [ApiAuthDataSource] instance.
  ///
  /// Parameters:
  ///   - [_client]: The [ApiClient] used to make HTTP requests.
  ApiAuthDataSource(this._client);

  @override
  Future<ResponseState> checkAuthStatus(String token) async {
    try {
      final response = await _client.get(ApiEndpoint.authCheckStatus);
      final AuthResponseModel user = AuthResponseModel.fromJson(response.data);
      return ResponseSuccess(user, 200);
    } on DioException catch (e) {
      return ResponseFailed(e);
    } catch (e) {
      return ResponseFailed(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoint.authLogin),
          error: e,
          message: e.toString(),
        ),
      );
    }
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
  Future<ResponseState> login(String email, String password) async {
    try {
      final response = await _client.post(ApiEndpoint.authLogin, {
        'email': email,
        'password': password,
      });
      final AuthResponseModel user = AuthResponseModel.fromJson(response.data);
      return ResponseSuccess(user, 200);
    } on DioException catch (e) {
      return ResponseFailed(e);
    } catch (e) {
      return ResponseFailed(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoint.authLogin),
          error: e,
          message: e.toString(),
        ),
      );
    }
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
  Future<ResponseState> register(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final response = await _client.post(ApiEndpoint.authRegister, {
        'email': email,
        'password': password,
        'fullName': fullName,
      });

      final AuthResponseModel user = AuthResponseModel.fromJson(response.data);
      return ResponseSuccess(user, 200);
    } on DioException catch (e) {
      return ResponseFailed(e);
    } catch (e) {
      return ResponseFailed(
        DioException(
          requestOptions: RequestOptions(path: ApiEndpoint.authLogin),
          error: e,
          message: e.toString(),
        ),
      );
    }
  }
}
