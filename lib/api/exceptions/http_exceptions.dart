import 'package:dio/dio.dart';

/// Represents a bad request error (HTTP 400).
class BadRequestException extends DioException {
  /// Creates a [BadRequestException].
  BadRequestException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [BadRequest]: $message';
  }
}

/// Represents an unauthorized error (HTTP 401).
class UnauthorizedException extends DioException {
  /// Creates an [UnauthorizedException].
  UnauthorizedException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [Unauthorized]: $message';
  }
}

/// Represents a not found error (HTTP 404).
class NotFoundException extends DioException {
  /// Creates a [NotFoundException].
  NotFoundException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [NotFound]: $message';
  }
}

/// Represents a conflict error (HTTP 409).
class ConflictException extends DioException {
  /// Creates a [ConflictException].
  ConflictException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [Conflict]: $message';
  }
}

/// Represents an internal server error (HTTP 500).
class InternalServerErrorException extends DioException {
  /// Creates an [InternalServerErrorException].
  InternalServerErrorException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [InternalServerError]: $message';
  }
}

/// Represents an unknown error.
class UnknownException extends DioException {
  /// Creates an [UnknownException].
  UnknownException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [UnknownException]: $message';
  }
}

/// Represents a no internet connection error.
class NoInternetConnection extends DioException {
  /// Creates a [NoInternetConnection].
  NoInternetConnection(RequestOptions r, {super.error, super.message})
      : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

/// Represents a deadline exceeded error.
class DeadlineExceeded extends DioException {
  /// Creates a [DeadlineExceeded].
  DeadlineExceeded(RequestOptions r, {super.error, super.message})
      : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

/// Represents a bad certificate error.
class BadCertificate extends DioException {
  /// Creates a [BadCertificate].
  BadCertificate(RequestOptions r, {super.error, super.message})
      : super(requestOptions: r);

  @override
  String toString() {
    return 'The certificate is not reliable.';
  }
}

/// Represents a bad response error.
class BadResponse extends DioException {
  /// Creates a [BadResponse].
  BadResponse(RequestOptions r, {super.error, super.message})
      : super(requestOptions: r);

  @override
  String toString() {
    return 'Error processing the response';
  }
}

/// Represents an unknown server error.
class Unknown extends DioException {
  /// Creates an [Unknown].
  Unknown(RequestOptions r, {super.error, super.message})
      : super(requestOptions: r);

  @override
  String toString() {
    return 'unknown server error';
  }
}

/// Represents a connection timeout error.
class ConnectionTimeout extends DioException {
  /// Creates a [ConnectionTimeout].
  ConnectionTimeout(RequestOptions r, {super.error, super.message})
      : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection timeout has been exceeded';
  }
}

/// Represents a send timeout error.
class SendTimeout extends DioException {
  /// Creates a [SendTimeout].
  SendTimeout(RequestOptions r, {super.error, super.message})
      : super(requestOptions: r);

  @override
  String toString() {
    return 'Send lead time has been exceeded';
  }
}

/// Represents a generic API exception.
class ApiException extends DioException {
  /// Creates an [ApiException].
  ApiException(RequestOptions r, {super.error, super.message})
      : super(requestOptions: r);

  @override
  String toString() {
    return 'An unknown error occurred processing the request.';
  }
}

/// Represents a Google Sign In error.
class GoogleSignInError {
  /// The error message.
  final String message;

  /// Creates a [GoogleSignInError].
  GoogleSignInError(this.message);

  @override
  String toString() => "GoogleSignInError: $message";
}