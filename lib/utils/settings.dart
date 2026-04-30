import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';

/// This file contains the [AppSettings] class, which represents the application settings.
/// It provides methods and properties to access various settings based on the current environment.
/// Values such as `baseUrl`, `apiKey`, `sessionSecretKey`, and `countryCodes` are loaded from
/// the `.env` file matching the current [AppEnvironment] (see `env/.env.*` files).
///
/// Example usage:
///
/// ```dart
/// final settings = AppSettings(AppEnvironment.development);
///
/// print(settings.isDevelopment);
/// print(settings.baseUrl);
/// print(await settings.getDeviceId());
/// ```
class AppSettings {
  AppSettings(this._environment);

  final AppEnvironment _environment;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final Uuid uuid = const Uuid();

  bool get isDevelopment => _environment == AppEnvironment.development;
  bool get isProduction => _environment == AppEnvironment.production;
  bool get isStaging => _environment == AppEnvironment.staging;

  String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  String get apiKey => dotenv.env['API_KEY'] ?? '';

  String get sessionSecretKey => dotenv.env['SESSION_KEY'] ?? 'auth_session_box';

  List<String> get countryCodes {
    final raw = dotenv.env['COUNTRY_CODES'];
    if (raw == null || raw.isEmpty) return const [];
    return raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  /// Returns the device platform as a string.
  /// If the platform is Android, it returns 'ANDROID'.
  /// If the platform is iOS, it returns 'IOS'.
  /// If the platform is unknown or an error occurs, it returns 'UNKNOWN'.
  String getDevicePlatform() {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return 'ANDROID';
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        return 'IOS';
      } else {
        return 'UNKNOWN';
      }
    } catch (e) {
      log('Error getting device Platform: $e');
      return 'UNKNOWN';
    }
  }

  /// Retrieves the device ID asynchronously.
  ///
  /// This method checks the default target platform and retrieves the device ID accordingly.
  /// If the default target platform is Android, it uses the `deviceInfoPlugin` to get the Android device ID.
  /// If the default target platform is iOS, it uses the `DeviceInfoPlugin` to get the iOS device ID.
  /// If the default target platform is neither Android nor iOS, it returns a default device ID of 'UNKNOWN'.
  ///
  /// If an error occurs while retrieving the device ID, it logs the error and returns a default device ID of 'UNKNOWN'.
  ///
  /// Returns the device ID as a `String`.
  Future<String> getDeviceId() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return uuid.v5(Namespace.dns.value, androidInfo.id);
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await DeviceInfoPlugin().iosInfo;
        return uuid.v5(Namespace.dns.value, iosInfo.identifierForVendor);
      } else {
        return uuid.v5(Namespace.dns.value, 'UNKNOWN');
      }
    } catch (e) {
      log('Error getting device ID: $e');
      return uuid.v5(Namespace.dns.value, 'UNKNOWN');
    }
  }
}

/// Enum representing different environments for the application.
///
/// The [AppEnvironment] enum defines three different environments:
/// - development: Used for local development and testing.
/// - production: Used for the live production environment.
/// - staging: Used for staging or pre-production environment.
enum AppEnvironment {
  development,
  production,
  staging,
}
