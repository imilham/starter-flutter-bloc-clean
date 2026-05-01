import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:starter/core/di/injection_container.dart';
import 'package:starter/utils/utils.dart';

// Re-export getIt for convenient access throughout the app
export 'package:starter/core/di/injection_container.dart' show getIt;

/// Boots up the application by initializing necessary components and running the provided builder function.
///
/// The [builder] function is responsible for creating the root widget of the application.
/// The [environment] parameter specifies the environment in which the application is running.
/// This function sets up error handling, initializes Flutter bindings, and registers singletons for various services.
Future<void> bootstrap(FutureOr<Widget> Function() builder, {required AppEnvironment environment}) async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Builder(
          builder: (context) {
            return Text(
              context.l10n.genericError,
              style: context.bodyRegular16(color: Colors.red),
            );
          },
        ),
      ),
    );
  };

  FlutterError.onError = (details) {
    debugPrintStack(stackTrace: details.stack, label: details.exceptionAsString(), maxFrames: 10);
  };
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await loadEnvFile(environment);
  /// todo - uncomment if using Firebase services
  // await Firebase.initializeApp();
  final hiveCipher = await hiveInit();
  await setup(environment: environment, hiveCipher: hiveCipher);
  runApp(await builder());
}

/// Loads the `.env` file that matches the current [environment].
Future<void> loadEnvFile(AppEnvironment environment) async {
  final envFile = switch (environment) {
    AppEnvironment.development => 'env/.env.development',
    AppEnvironment.production => 'env/.env.production',
    AppEnvironment.staging => 'env/.env.staging',
  };

  await dotenv.load(fileName: envFile);
}
