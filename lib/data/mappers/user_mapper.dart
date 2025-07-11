import 'package:flutter_starter_kit/data/models/user.dart';

/// A utility class for mapping between JSON data and [UserModel] objects.
///
/// This class provides static methods to convert a JSON map into a [UserModel]
/// and to convert a [UserModel] into a JSON map.
class UserMapper {
  /// Converts a JSON map into a [UserModel].
  ///
  /// This method takes a JSON map as input and extracts the 'id', 'email', and
  /// 'fullName' fields to create a new [UserModel] instance.
  ///
  /// Parameters:
  ///   - [json]: The JSON map to convert.
  ///
  /// Returns:
  ///   - A [UserModel] instance created from the JSON data.
  static UserModel userJsonToModel(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'],
        fullName: json['fullName'],
      );

  /// Converts a [UserModel] into a JSON map.
  ///
  /// This method takes a [UserModel] instance as input and extracts the 'id',
  /// 'email', and 'fullName' properties to create a JSON map.
  ///
  /// Parameters:
  ///   - [user]: The [UserModel] to convert.
  ///
  /// Returns:
  ///   - A JSON map representing the [UserModel].
  static Map<String, dynamic> toJson(UserModel user) => {
        'id': user.id,
        'email': user.email,
        'fullName': user.fullName,
      };
}
