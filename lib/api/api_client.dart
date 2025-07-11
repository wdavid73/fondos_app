import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/api/api.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/shared/service/service.dart';

/// Handles HTTP requests to the API.
///
/// Uses `Dio` for making requests and includes interceptors for token
/// management and error handling.
class ApiClient {
  /// The `Dio` client used for making requests.
  final Dio _client;

  /// Private constructor for the singleton pattern.
  ApiClient._internal() : _client = createDio();

  /// The singleton instance of [ApiClient].
  static final _singleton = ApiClient._internal();

  /// Factory constructor to return the singleton instance.
  factory ApiClient() => _singleton;

  /// Creates the base options for the `Dio` client.
  ///
  /// Sets the base URL, timeouts, response type, and default headers.
  static BaseOptions createBaseOptions() => BaseOptions(
        baseUrl: Environment.apiUrl,
        receiveTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: {'Content-Type': 'application/json'},
      );

  /// Creates a `Dio` instance with interceptors.
  ///
  /// Adds [ApiTokenInterceptor] and [ApiErrorsInterceptor].
  static Dio createDio() {
    final storageDevice = KeyValueStorageServiceImpl();
    final dio = Dio(createBaseOptions());
    dio.interceptors.add(ApiTokenInterceptor(
      storageDevice,
    ));
    dio.interceptors.add(ApiErrorsInterceptor());
    return dio;
  }

  /// Performs a GET request.
  ///
  /// Parameters:
  ///   - [url]: The URL to request.
  ///   - [queryParams]: Optional query parameters.
  ///
  /// Returns:
  ///   - A [Future] that completes with the [Response].
  Future<Response> get(String url, {Map<String, dynamic>? queryParams}) =>
      _client.get(url, queryParameters: serializerQueryParams(queryParams));

  /// Performs a POST request.
  ///
  /// Parameters:
  ///   - [url]: The URL to request.
  ///   - [body]: The request body.
  ///
  /// Returns:
  ///   - A [Future] that completes with the [Response].
  Future<Response> post(String url, dynamic body) =>
      _client.post(url, data: body);

  /// Performs a PUT request.
  ///
  /// Parameters:
  ///   - [url]: The URL to request.
  ///   - [body]: The request body.
  ///
  /// Returns:
  ///   - A [Future] that completes with the [Response].
  Future<Response> put(String url, dynamic body) =>
      _client.put(url, data: body);

  /// Performs a PATCH request.
  ///
  /// Parameters:
  ///   - [url]: The URL to request.
  ///   - [body]: The request body.
  ///
  /// Returns:
  ///   - A [Future] that completes with the [Response].
  Future<Response> patch(String url, dynamic body) =>
      _client.patch(url, data: body);

  /// Performs a DELETE request.
  ///
  /// Parameters:
  ///   - [url]: The URL to request.
  ///
  /// Returns:
  ///   - A [Future] that completes with the [Response].
  Future<Response> delete(String url) => _client.delete(url);

  /// Returns the default [ApiClient] instance.
  static ApiClient get instance {
    ApiClient defaultAppClientInstance = ApiClient();
    return defaultAppClientInstance;
  }
}
