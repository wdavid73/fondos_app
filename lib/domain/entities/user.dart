import 'base_entity.dart';

/// Represents a user entity in the application.
///
/// This class extends [BaseEntity] and includes properties specific to a
/// user, such as their email and full name.
class User extends BaseEntity {
  /// The unique identifier of the user.
  @override
  final String id;

  /// The email address of the user.
  final String email;

  /// The full name of the user.
  final String fullName;

  /// Creates a [User] instance.
  ///
  /// Parameters:
  ///   - [id]: The unique identifier of the user.
  ///   - [email]: The email address of the user.
  ///   - [fullName]: The full name of the user.
  User({
    required this.id,
    required this.email,
    required this.fullName,
  }) : super();
}