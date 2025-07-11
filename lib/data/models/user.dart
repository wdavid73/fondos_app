import 'package:flutter_starter_kit/domain/entities/user.dart';
import 'package:flutter_starter_kit/data/data.dart';
import 'json_serializable.dart';

/// A concrete implementation of the [User] entity that can be serialized to JSON.
///
/// This class extends the [User] entity and implements the [JsonSerializable]
/// interface, allowing it to be easily converted to and from JSON format.
class UserModel extends User implements JsonSerializable {
  /// Creates a [UserModel] instance.
  ///
  /// Parameters:
  ///   - [id]: The unique identifier of the user.
  ///   - [email]: The email address of the user.
  ///   - [fullName]: The full name of the user.
  UserModel({
    required super.id,
    required super.email,
    required super.fullName,
  });

  /// Creates a [UserModel] instance from a JSON map.
  ///
  /// This factory constructor uses the [UserMapper] to convert a JSON map
  /// into a [UserModel] object.
  ///
  /// Parameters:
  ///   - [json]: The JSON map to convert.
  ///
  /// Returns:
  ///   - A [UserModel] instance created from the JSON data.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserMapper.userJsonToModel(json);
  }

  /// Converts the [UserModel] to a JSON map.
  ///
  /// This method uses the [UserMapper] to convert the [UserModel] object
  /// into a JSON map.
  ///
  /// Returns:
  ///   - A JSON map representing the [UserModel].
  @override
  Map<String, dynamic> toJson() {
    return UserMapper.toJson(this);
  }
}
