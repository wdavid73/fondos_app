/// An abstract class representing a base entity with a unique identifier.
///
/// This class serves as a foundation for other entities in the application,
/// ensuring that they all have a unique `id` property.
///
/// Implementing classes are expected to provide a concrete implementation for
/// the `id` getter.
abstract class BaseEntity {
  /// The unique identifier of the entity.
  ///
  /// This getter must be implemented by concrete subclasses.
  String get id;
}