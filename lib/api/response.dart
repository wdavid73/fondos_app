import 'package:dio/dio.dart';

/// Represents the state of a response.
///
/// Can be either a success or a failure.
abstract class ResponseState<T> {
  /// The data returned in the response.
  final T? data;

  /// The HTTP status code of the response.
  final int? statusCode;

  /// The error that occurred, if any.
  final DioException? error;

  /// Creates a [ResponseState].
  const ResponseState({this.data, this.statusCode, this.error});
}

/// Represents a successful response.
class ResponseSuccess<T> extends ResponseState<T> {
  /// Creates a [ResponseSuccess].
  ///
  /// Requires the [data] and the [statusCode].
  const ResponseSuccess(T data, int statusCode)
      : super(data: data, statusCode: statusCode);
}

/// Represents a failed response.
class ResponseFailed<T> extends ResponseState<T> {
  /// Creates a [ResponseFailed].
  ///
  /// Requires the [error].
  const ResponseFailed(DioException error) : super(error: error);
}