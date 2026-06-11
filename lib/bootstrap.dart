import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starter/core/di/injection_container.dart';
import 'package:starter/firebase_options.dart';
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
    if (kReleaseMode) {
      return const SizedBox.shrink();
    }
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

  // ─── Crash Reporting ──────────────────────────────────────────────────────
  // Wire your crash reporter here before going to production.
  //
  // Option A — Firebase Crashlytics:
  //   1. Add `firebase_crashlytics` to pubspec.yaml
  //   2. Uncomment the blocks below
  //
  // Option B — Sentry:
  //   1. Add `sentry_flutter` to pubspec.yaml
  //   2. Wrap `runApp` in `SentryFlutter.init` and set `options.dsn`
  //   3. Replace the Crashlytics calls below with:
  //        Sentry.captureException(details.exception, stackTrace: details.stack)
  // ─────────────────────────────────────────────────────────────────────────
  FlutterError.onError = (details) {
    if (kReleaseMode) {
      // FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    } else {
      debugPrintStack(stackTrace: details.stack, label: details.exceptionAsString(), maxFrames: 10);
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kReleaseMode) {
      // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
    return true;
  };
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await loadEnvFile(environment);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(environment),
  );
  final hiveCipher = await hiveInit();
  
  // Use support directory — excluded from iCloud/GDrive auto-backup by default.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationSupportDirectory(),
  );

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
