import 'package:dio/dio.dart';

/// Creates an [ErrorHandler] from a [DioException].
///
/// Parameters:
///   - [err]: The [DioException].
///   - [message]: An optional custom error message.
///
/// Returns:
///   - An [ErrorHandler] instance.
ErrorHandler handlerErrorResponse(
  DioException err,
  String? message,
) {
  return ErrorHandler(
    requestOptions: err.requestOptions,
    message: message ?? err.message,
    error: err.error,
  );
}

/// Represents an error handler with detailed information.
class ErrorHandler {
  /// The error message.
  final String? message;

  /// The underlying error object.
  final Object? error;

  /// The request options associated with the error.
  final RequestOptions requestOptions;

  /// Creates an [ErrorHandler].
  ///
  /// Requires [requestOptions].
  ErrorHandler({
    this.message,
    this.error,
    required this.requestOptions,
  });
}