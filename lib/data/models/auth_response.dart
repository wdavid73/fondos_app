import 'user.dart';

/// Represents the response model for authentication-related operations.
///
/// This class encapsulates the user information ([UserModel]) and the
/// authentication token ([String]) received from the API after a successful
/// authentication attempt.
class AuthResponseModel {
  /// The authenticated user's information.
  final UserModel user;

  /// The authentication token.
  final String token;

  /// Creates an [AuthResponseModel] instance.
  ///
  /// Parameters:
  ///   - [user]: The authenticated user's information.
  ///   - [token]: The authentication token.
  AuthResponseModel({
    required this.user,
    required this.token,
  });

  /// Creates an [AuthResponseModel] instance from a JSON map.
  ///
  /// This factory constructor is used to convert a JSON map received from the
  /// API into an [AuthResponseModel] object. It extracts the user information
  /// and the token from the JSON data.
  ///
  /// Parameters:
  ///   - [json]: The JSON map to convert.
  ///
  /// Returns:
  ///   - An [AuthResponseModel] instance created from the JSON data.
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json),
      token: json['token'],
    );
  }
}