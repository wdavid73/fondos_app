/// Defines the contract for a key-value storage service.
///
/// Implementations provide methods to store, retrieve, and remove
/// key-value pairs.
abstract class KeyValueStorageService {
  /// Stores a key-value pair.
  ///
  /// Parameters:
  ///   - [key]: The key to store the value under.
  ///   - [value]: The value to be stored.
  ///
  /// Returns:
  ///   - A [Future] that completes when the value is stored.
  Future<void> setKeyValue<T>(String key, T value);

  /// Retrieves a value associated with a key.
  ///
  /// Parameters:
  ///   - [key]: The key to retrieve the value for.
  ///
  /// Returns:
  ///   - A [Future] that completes with the value associated with the key,
  ///     or `null` if the key is not found.
  Future<T?> getValue<T>(String key);

  /// Removes a key-value pair.
  ///
  /// Parameters:
  ///   - [key]: The key to remove.
  ///
  /// Returns:
  ///   - A [Future] that completes with `true` if the key was removed,
  ///     `false` otherwise.
  Future<bool> removeKey(String key);
}