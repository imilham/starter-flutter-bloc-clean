# Firebase Setup Guide

This guide explains how to connect **starter-flutter-bloc-clean** to two Firebase environments:
- **sandbox** for development and staging
- **live** for production

The project already includes flavor support for both platforms. Firebase is selected at runtime from the active `AppEnvironment`.

---

## 1. Firebase project mapping

Use one of these setups:

- **Option A: two separate Firebase projects**
  - one project for sandbox
  - one project for live
- **Option B: one Firebase project with two apps**
  - one Android app and one iOS app for sandbox
  - one Android app and one iOS app for live

Both approaches work. Separate projects are usually simpler to reason about in CI, testing, and release management.

---

## 2. Project flavor mapping

| Flavor | Environment | Purpose |
|---|---|---|
| `sandbox` | `development` and `staging` | Non-production testing |
| `live` | `production` | Production release |

Use these bundle IDs and package names when registering apps in Firebase:

- Android sandbox: `em.starter.app.sandbox`
- Android live: `em.starter.app`
- iOS sandbox: `em.starter.app.sandbox`
- iOS live: `em.starter.app`

---

## 3. Files already prepared in the project

The following files are already set up and should be replaced with real Firebase values:

- `android/app/src/sandbox/google-services.json`
- `android/app/src/live/google-services.json`
- `ios/config/sandbox/GoogleService-Info.plist`
- `ios/config/live/GoogleService-Info.plist`
- `lib/firebase_options_sandbox.dart`
- `lib/firebase_options_production.dart`

The app initialization already routes Firebase by environment in:

- `lib/firebase_options.dart`
- `lib/bootstrap.dart`

---

## 4. Create Firebase apps

### Android

Create two Android apps in Firebase Console:

- Sandbox app with package name `em.starter.app.sandbox`
- Live app with package name `em.starter.app`

Download the generated `google-services.json` files and replace the placeholders in:

- `android/app/src/sandbox/google-services.json`
- `android/app/src/live/google-services.json`

### iOS

Create two iOS apps in Firebase Console:

- Sandbox app with bundle ID `em.starter.app.sandbox`
- Live app with bundle ID `em.starter.app`

Download the generated `GoogleService-Info.plist` files and replace the placeholders in:

- `ios/config/sandbox/GoogleService-Info.plist`
- `ios/config/live/GoogleService-Info.plist`

---

## 5. Update FlutterFire options

The project uses generated-style Firebase options files for runtime initialization.

Update these files with the real values from Firebase:

- `lib/firebase_options_sandbox.dart`
- `lib/firebase_options_production.dart`

Each file should contain the correct `apiKey`, `appId`, `messagingSenderId`, `projectId`, and platform-specific IDs.

---

## 6. Android Firebase plugin

The Android Firebase Gradle plugin is already enabled in the project.

If you ever need to verify it, confirm these lines are present:

- `android/settings.gradle.kts`
- `android/app/build.gradle.kts`

---

## 7. iOS Firebase config copy

The project includes scripts to select the active iOS flavor and copy the matching Firebase plist.

### Set the flavor manually

```bash
bash ios/scripts/set_flavor.sh sandbox
bash ios/scripts/set_flavor.sh live
```

### Add the copy script in Xcode

Add this script as a **Run Script** build phase in the Runner target, before **Copy Bundle Resources**:

```bash
/bin/bash "$SRCROOT/scripts/copy_firebase_config.sh"
```

This copies the correct plist into the Runner target during the build.

---

## 8. Run the app

### Development

```bash
flutter run --flavor sandbox -t lib/main_development.dart
```

### Staging

```bash
flutter run --flavor sandbox -t lib/main_staging.dart
```

### Production

```bash
flutter run --flavor live -t lib/main_production.dart
```

---

## 9. Verify Firebase is connected

A successful setup should satisfy all of the following:

- the app launches without Firebase initialization errors
- the sandbox flavor uses sandbox Firebase credentials
- the live flavor uses live Firebase credentials
- `firebase_messaging` initializes correctly for each flavor

If the app fails at startup, double-check:

- the bundle ID or package name in Firebase Console
- the contents of the `google-services.json` file for the selected flavor
- the contents of the `GoogleService-Info.plist` file for the selected flavor
- the values in `lib/firebase_options_*.dart`

---

## 10. Recommended setup order

1. Create the Firebase Android and iOS apps
2. Replace the Android and iOS config files
3. Fill in the Dart Firebase options files
4. Add the iOS copy script in Xcode
5. Run the app using the correct flavor

---

## 11. Notes

- `development` and `staging` both map to sandbox Firebase
- `production` maps to live Firebase
- Keep sandbox and live credentials separate
- Do not commit real Firebase secrets outside the project’s intended config files
