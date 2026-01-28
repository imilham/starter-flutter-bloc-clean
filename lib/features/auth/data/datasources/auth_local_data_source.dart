import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:starter/features/auth/data/models/models.dart';
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

/// Implementation of [AuthLocalDataSource] using Hive.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl() : box = Hive.box<String>(GetIt.instance<AppSettings>().sessionSecretKey);

  final Box<String> box;
  static const _sessionKey = 'session';

  @override
  Future<AuthSessionModel?> getSession() async {
    final sessionJson = box.get(_sessionKey);
    if (sessionJson == null) return null;
    return AuthSessionModel.fromJson(
      jsonDecode(sessionJson) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    await box.put(_sessionKey, jsonEncode(session.toJson()));
  }

  @override
  Future<void> deleteSession() async {
    await box.delete(_sessionKey);
  }
}
