import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:starter/core/storage/secure_storage.dart';

/// Key under which the Hive AES encryption key is persisted in [SecureStorage].
const String _hiveEncryptionKeyName = 'hive_encryption_key';

/// Returns a [HiveAesCipher] backed by a key persisted in [SecureStorage].
///
/// On first use, generates a fresh 256-bit AES key with `Hive.generateSecureKey`,
/// base64-encodes it, and writes it to secure storage. Subsequent calls reuse
/// the stored key so existing encrypted boxes remain readable.
Future<HiveAesCipher> getOrCreateHiveCipher(SecureStorage storage) async {
  var encodedKey = await storage.read(_hiveEncryptionKeyName);

  if (encodedKey == null) {
    final key = Hive.generateSecureKey();
    encodedKey = base64UrlEncode(key);
    await storage.write(_hiveEncryptionKeyName, encodedKey);
  }

  return HiveAesCipher(base64Url.decode(encodedKey));
}
