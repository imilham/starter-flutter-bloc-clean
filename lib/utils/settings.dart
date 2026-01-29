import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

/// This file contains the [AppSettings] class, which represents the application settings.
/// It provides methods and properties to access various settings based on the current environment.
/// The [AppSettings] class also includes methods to retrieve device information such as device ID and device name.
/// The [AppEnvironment] enum defines the possible environments: development, production, and staging.
/// The [AppSettingValue] class is a generic class that represents a setting value with different values for each environment.
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

  // TODO(api-implementation): Step 1: Setup Base URL and Keys
  final _baseUrl = const AppSettingValue<String>(
    developmentValue: 'https://xtracked.sandbox28.preview.cx/api/v1',
    productionValue: 'https://xtracked.sandbox28.preview.cx/api/v1',
    stagingValue: 'https://xtracked.sandbox28.preview.cx/api/v1',
  );

  final _apiKey = const AppSettingValue<String>(
    developmentValue: 'MUbOz3nSSQiwhaGOkGjoH13w8M27Yb62eJlK6il9IM0=',
    productionValue: 'MUbOz3nSSQiwhaGOkGjoH13w8M27Yb62eJlK6il9IM0=',
    stagingValue: 'MUbOz3nSSQiwhaGOkGjoH13w8M27Yb62eJlK6il9IM0=',
  );

  final _sessionSecretKey = const AppSettingValue<String>(
    developmentValue: 'auth_session_box',
    productionValue: 'auth_session_box',
    stagingValue: 'auth_session_box',
  );

  final _countryCodes = const AppSettingValue<List<String>>(
    developmentValue: ['+61', '+94'],
    productionValue: ['+61'],
    stagingValue: ['+61'],
  );

  String get baseUrl {
    switch (_environment) {
      case AppEnvironment.development:
        return _baseUrl.developmentValue;
      case AppEnvironment.production:
        return _baseUrl.productionValue ?? _baseUrl.developmentValue;
      case AppEnvironment.staging:
        return _baseUrl.stagingValue ?? _baseUrl.developmentValue;
    }
  }

  String get apiKey {
    switch (_environment) {
      case AppEnvironment.development:
        return _apiKey.developmentValue;
      case AppEnvironment.production:
        return _apiKey.productionValue ?? _apiKey.developmentValue;
      case AppEnvironment.staging:
        return _apiKey.stagingValue ?? _apiKey.developmentValue;
    }
  }

  String get sessionSecretKey {
    switch (_environment) {
      case AppEnvironment.development:
        return _sessionSecretKey.developmentValue;
      case AppEnvironment.production:
        return _sessionSecretKey.productionValue ?? _sessionSecretKey.developmentValue;
      case AppEnvironment.staging:
        return _sessionSecretKey.stagingValue ?? _sessionSecretKey.developmentValue;
    }
  }

  List<String> get countryCodes {
    switch (_environment) {
      case AppEnvironment.development:
        return _countryCodes.developmentValue;
      case AppEnvironment.production:
        return _countryCodes.productionValue ?? _countryCodes.developmentValue;
      case AppEnvironment.staging:
        return _countryCodes.stagingValue ?? _countryCodes.developmentValue;
    }
  }

  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;
  bool get isWeb => kIsWeb;

  /// Returns the device platform as a string.
  /// If the platform is Android, it returns 'ANDROID'.
  /// If the platform is iOS, it returns 'IOS'.
  /// If the platform is unknown or an error occurs, it returns 'UNKNOWN'.
  String getDevicePlatform() {
    if (isAndroid) return 'android';
    if (isIOS) return 'ios';
    if (isWeb) return 'web';
    return 'unknown';
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

/// A generic class representing the value of an application setting.
///
/// The [AppSettingValue] class is used to define the default value of a setting,
/// as well as optional values for different environments such as development,
/// production, and staging. The type parameter [T] represents the type of the value.
class AppSettingValue<T> {
  const AppSettingValue({
    required this.developmentValue,
    this.productionValue,
    this.stagingValue,
  });

  final T developmentValue;
  final T? productionValue;
  final T? stagingValue;
}
