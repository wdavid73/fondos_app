import 'package:shared_preferences/shared_preferences.dart';
import 'key_value_storage_service.dart';

/// Concrete implementation of [KeyValueStorageService] using [SharedPreferences].
///
/// Provides methods to store, retrieve, and remove key-value pairs
/// using the `shared_preferences` package.
class KeyValueStorageServiceImpl extends KeyValueStorageService {
  /// Gets an instance of [SharedPreferences].
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  /// Retrieves a value associated with a key.
  ///
  /// Uses [SharedPreferences] to get the value.
  ///
  /// Parameters:
  ///   - [key]: The key to retrieve the value for.
  ///
  /// Returns:
  ///   - A [Future] that completes with the value associated with the key,
  ///     or `null` if the key is not found.
  ///
  /// Throws:
  ///   - [UnimplementedError]: If the type `T` is not supported.
  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else {
      throw UnimplementedError(
        "Get not implemented for type ${T.runtimeType}",
      );
    }
  }

  /// Removes a key-value pair.
  ///
  /// Uses [SharedPreferences] to remove the key.
  ///
  /// Parameters:
  ///   - [key]: The key to remove.
  ///
  /// Returns:
  ///   - A [Future] that completes with `true` if the key was removed,
  ///     `false` otherwise.
  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  /// Stores a key-value pair.
  ///
  /// Uses [SharedPreferences] to store the value.
  ///
  /// Parameters:
  ///   - [key]: The key to store the value under.
  ///   - [value]: The value to be stored.
  ///
  /// Returns:
  ///   - A [Future] that completes when the value is stored.
  ///
  /// Throws:
  ///   - [UnimplementedError]: If the type `T` is not supported.
  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    if (T == int) {
      prefs.setInt(key, value as int);
      return;
    } else if (T == String) {
      prefs.setString(key, value as String);
      return;
    } else if (T == bool) {
      prefs.setBool(key, value as bool);
      return;
    } else if (T == double) {
      prefs.setDouble(key, value as double);
      return;
    } else {
      throw UnimplementedError(
        "Get not implemented for type ${T.runtimeType}",
      );
    }
  }
}