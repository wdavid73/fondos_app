/// Defines the contract for a service that handles secure storage of sensitive data.
///
/// Implementations should provide methods to securely save, retrieve,
/// and delete tokens or other sensitive information.
abstract class SecureStorageService {
  /// Saves a token securely associated with a given key.
  ///
  /// Parameters:
  ///   - [key]: The key under which the token will be stored.
  ///   - [token]: The token (or sensitive string) to be saved.
  ///
  /// Returns:
  ///   - A [Future] that completes when the token is successfully saved.
  Future<void> saveToken(String key, String token);

  /// Retrieves a token securely associated with a given key.
  ///
  /// Parameters:
  ///   - [key]: The key to retrieve the associated token.
  ///
  /// Returns:
  ///   - A [Future] that completes with the token as a [String],
  ///     or `null` if no token is found for the given key.
  Future<String?> getToken(String key);

  /// Deletes the token securely associated with a given key.
  ///
  /// Parameters:
  ///   - [key]: The key of the token to be deleted.
  ///
  /// Returns:
  ///   - A [Future] that completes when the token is successfully deleted.
  Future<void> deleteToken(String key);

  /// Clears all securely stored data.
  ///
  /// This operation should be used with caution as it will remove all
  /// stored sensitive information.
  ///
  /// Returns:
  ///   - A [Future] that completes when all data is cleared.
  Future<void> clearAll();
}
