import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/api/api.dart';

/// Interceptor for handling API errors.
///
/// Intercepts `DioException`s and converts them into specific exceptions
/// based on the status code or the type of the error.
class ApiErrorsInterceptor extends Interceptor {
  /// Creates an [ApiErrorsInterceptor].
  ApiErrorsInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response == null) {
      return handler.reject(_getExceptionForDioType(err));
    }

    int statusCode = err.response!.statusCode!;
    String? errorMessage;
    if (err.response?.data != null && err.response?.data is Map) {
      //? Adjust the key if needed
      errorMessage = err.response!.data['message']?.toString();
    }
    ErrorHandler errorHandler = handlerErrorResponse(err, errorMessage);

    if (statusCode == 401) {
      await _handlerUnauthorizedError(errorHandler);
    }

    return handler.reject(
      _getExceptionForStatusCode(statusCode, errorHandler),
    );
  }

  /// Handles unauthorized errors (401).
  ///
  /// TODO: Clear shared preferences.
  /// TODO: Navigate back to login screen.
  Future<void> _handlerUnauthorizedError(ErrorHandler errorHandler) async {
    // TODO: Clear shared preferences
    // TODO: navigate back to login screen if the screen is not the login screen
    // TODO: Add return no finish the request
  }

  /// Converts a status code into a specific `DioException`.
  ///
  /// Parameters:
  ///   - [statusCode]: The HTTP status code.
  ///   - [errorHandler]: The error handler containing additional information.
  ///
  /// Returns:
  ///   - A specific `DioException` based on the status code.
  DioException _getExceptionForStatusCode(
    int statusCode,
    ErrorHandler errorHandler,
  ) {
    switch (statusCode) {
      case 400:
        return BadRequestException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 401:
        return UnauthorizedException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 404:
        return NotFoundException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 422:
        return ConflictException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 500:
        return InternalServerErrorException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      default:
        return UnknownException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
    }
  }

  /// Converts a `DioExceptionType` into a specific `DioException`.
  ///
  /// Parameters:
  ///   - [err]: The `DioException`.
  ///
  /// Returns:
  ///   - A specific `DioException` based on the type.
  DioException _getExceptionForDioType(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeout(
          err.requestOptions,
          error: err,
          message: 'connection_time_out',
        );
      case DioExceptionType.sendTimeout:
        return SendTimeout(
          err.requestOptions,
          error: err,
          message: 'send_time_out',
        );
      case DioExceptionType.receiveTimeout:
        return DeadlineExceeded(
          err.requestOptions,
          error: err,
          message: 'receive_time_out',
        );
      case DioExceptionType.connectionError:
        return NoInternetConnection(
          err.requestOptions,
          error: err,
          message: 'connection_error',
        );
      case DioExceptionType.badCertificate:
        return BadCertificate(
          err.requestOptions,
          error: err,
          message: 'bad_certificate',
        );
      case DioExceptionType.badResponse:
        return BadResponse(
          err.requestOptions,
          error: err,
          message: 'bad_response',
        );
      case DioExceptionType.unknown:
        return Unknown(
          err.requestOptions,
          error: err,
          message: 'unknown',
        );
      case DioExceptionType.cancel:
        return ApiException(
          err.requestOptions,
          error: err,
          message: 'unknown',
        );
    }
  }
}
