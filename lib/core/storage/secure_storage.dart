import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wrapper around [FlutterSecureStorage] to provide a clean interface
/// for secure data persistence.
///
/// Used for storing sensitive data like auth tokens and session keys.
abstract class SecureStorage {
  /// Reads a value from secure storage.
  Future<String?> read(String key);

  /// Writes a value to secure storage.
  Future<void> write(String key, String value);

  /// Deletes a value from secure storage.
  Future<void> delete(String key);

  /// Deletes all values from secure storage.
  Future<void> deleteAll();
}

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      // If reading fails (e.g. key changed), return null
      return null;
    }
  }

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
