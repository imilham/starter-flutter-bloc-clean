import 'package:firebase_core/firebase_core.dart';
import 'package:starter/firebase_options_production.dart' as production;
import 'package:starter/firebase_options_sandbox.dart' as sandbox;
import 'package:starter/utils/utils.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions currentPlatform(AppEnvironment environment) {
    switch (environment) {
      case AppEnvironment.development:
      case AppEnvironment.staging:
        return sandbox.DefaultFirebaseOptions.currentPlatform;
      case AppEnvironment.production:
        return production.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
