/// An abstract class that indicates a class can be serialized to JSON.
///
/// Classes that implement this interface are expected to provide a `toJson()`
/// method that returns a `Map<String, dynamic>` representation of the object's
/// data. This map can then be easily serialized to a JSON string using
/// `json.encode()`.
///
/// This interface is useful for ensuring that classes that need to be
/// serialized to JSON have a consistent way of doing so.
abstract class JsonSerializable {
  /// Converts the object to a JSON map.
  ///
  /// This method should return a `Map<String, dynamic>` where the keys are
  /// strings representing the object's properties, and the values are the
  /// corresponding property values.
  ///
  /// Returns:
  ///   - A `Map<String, dynamic>` representing the object's data.
  Map<String, dynamic> toJson();
}