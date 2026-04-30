import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:starter/core/storage/storage.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

/// Local data source for authentication operations.
///
/// This handles session persistence using Hive.
abstract interface class AuthLocalDataSource {
  /// Gets the stored session.
  Future<AuthSessionModel?> getSession();

  /// Saves the session.
  Future<void> saveSession(AuthSessionModel session);

  /// Deletes the session.
  Future<void> deleteSession();
}

/// Implementation of [AuthLocalDataSource] using SecureStorage.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl() : 
    _storage = GetIt.instance<SecureStorage>(),
    _hiveKey = GetIt.instance<AppSettings>().sessionSecretKey;

  final SecureStorage _storage;
  final String _hiveKey;

  static const _sessionKey = 'auth_session';
  static const _legacyHiveKey = 'session';

  @override
  Future<AuthSessionModel?> getSession() async {
    // 1. Try to read from Secure Storage (New Way)
    final sessionJson = await _storage.read(_sessionKey);
    
    // 2. If session exists, parse and return
    if (sessionJson != null) {
      try {
        return AuthSessionModel.fromJson(jsonDecode(sessionJson) as Map<String, dynamic>);
      } catch (_) {
        await _storage.delete(_sessionKey);
        return null;
      }
    }

    // 3. Fallback: Check for legacy Hive token (Migration)
    await _migrateFromHive();
    
    // 4. Check again after migration
    final migratedSession = await _storage.read(_sessionKey);
    if (migratedSession != null) {
      try {
        return AuthSessionModel.fromJson(jsonDecode(migratedSession) as Map<String, dynamic>);
      } catch (_) {
        await _storage.delete(_sessionKey);
      }
    }

    return null;
  }

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    await _storage.write(_sessionKey, jsonEncode(session.toJson()));
  }

  @override
  Future<void> deleteSession() async {
    await _storage.delete(_sessionKey);
  }

  /// Migrates legacy Hive session to Secure Storage one-time
  Future<void> _migrateFromHive() async {
    try {
      if (Hive.isBoxOpen(_hiveKey)) {
        final box = Hive.box<String>(_hiveKey);
        final sessionJson = box.get(_legacyHiveKey);
        
        if (sessionJson != null) {
          // Move to Secure Storage
          await _storage.write(_sessionKey, sessionJson);
          // Clear legacy data
          await box.delete(_legacyHiveKey);
        }
      } else {
        // Attempt to open if not open (best effort)
        if (await Hive.boxExists(_hiveKey)) {
           final box = await Hive.openBox<String>(
             _hiveKey,
             encryptionCipher: GetIt.instance<HiveAesCipher>(),
           );
           final sessionJson = box.get(_legacyHiveKey);
           if (sessionJson != null) {
             await _storage.write(_sessionKey, sessionJson);
             await box.delete(_legacyHiveKey);
           }
        }
      }
    } catch (_) {
      // Ignore migration errors - force re-login
    }
  }
}
