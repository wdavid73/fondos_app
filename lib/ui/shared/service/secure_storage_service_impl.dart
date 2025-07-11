import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage_service.dart';

/// Implementation of the [SecureStorageService] using the [FlutterSecureStorage] package.
///
/// This class provides concrete methods to securely save, retrieve,
/// and delete tokens using the underlying secure storage capabilities
/// provided by the `flutter_secure_storage` library.
class SecureStorageServiceImpl extends SecureStorageService {
  final _storage = const FlutterSecureStorage();

  /// Clears all data stored in the secure storage.
  ///
  /// This will permanently delete all key-value pairs managed by
  /// the [FlutterSecureStorage] instance. Use with caution.
  ///
  /// Overrides:
  ///   - [SecureStorageService.clearAll]
  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Deletes a specific token associated with the given key from secure storage.
  ///
  /// Parameters:
  ///   - [key]: The key of the token to be deleted.
  ///
  /// Overrides:
  ///   - [SecureStorageService.deleteToken]
  @override
  Future<void> deleteToken(String key) async {
    await _storage.delete(key: key);
  }

  /// Retrieves a token associated with the given key from secure storage.
  ///
  /// Parameters:
  ///   - [key]: The key to retrieve the associated token.
  ///
  /// Returns:
  ///   - A [Future] that completes with the token as a [String],
  ///     or `null` if no token is found for the given key.
  ///
  /// Overrides:
  ///   - [SecureStorageService.getToken]
  @override
  Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  /// Saves a token securely associated with the given key in secure storage.
  ///
  /// Parameters:
  ///   - [key]: The key under which the token will be stored.
  ///   - [token]: The token (or sensitive string) to be saved.
  ///
  /// Overrides:
  ///   - [SecureStorageService.saveToken]
  @override
  Future<void> saveToken(String key, String token) async {
    await _storage.write(key: key, value: token);
  }
}
