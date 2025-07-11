import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/ui/shared/service/service.dart';

/// Interceptor for adding and managing API tokens.
///
/// Adds the token to the request header and handles token expiration.
class ApiTokenInterceptor extends Interceptor {
  /// The key-value storage service for managing the token.
  final KeyValueStorageService _keyValueStorageService;

  /// Creates an [ApiTokenInterceptor].
  ///
  /// Requires a [KeyValueStorageService].
  ApiTokenInterceptor(this._keyValueStorageService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await getToken();

    if (token == null) {
      return handler.next(options);
    }

    if (isExpired(token)) {
      await _handleExpiredToken();
      return handler.next(options);
    }

    _addTokenToHeader(token, options);
    return handler.next(options);
  }

  /// Checks if the token is expired.
  ///
  ///
  /// Parameters:
  ///   - [token]: The token to check.
  ///
  /// Returns:
  ///   - `true` if the token is expired, `false` otherwise.
  bool isExpired(String token) {
    //? Add logic to check if token is expired
    return false;
  }

  /// Adds the token to the request header.
  ///
  /// Parameters:
  ///   - [token]: The token to add.
  ///   - [options]: The request options.
  void _addTokenToHeader(String token, RequestOptions options) {
    options.headers.addAll({
      'Authorization': 'Bearer $token',
    });
  }

  /// Handles an expired token.
  ///
  /// TODO: Add logic to handle an expired token.
  Future<void> _handleExpiredToken() async {
    // TODO: Add logic to handle an expired token
  }

  /// Retrieves the token from the key-value storage.
  ///
  /// Returns:
  ///   - The token, or `null` if not found.
  Future<String?> getToken() async {
    String? token = await _keyValueStorageService.getValue<String>('token');
    return token;
  }
}
