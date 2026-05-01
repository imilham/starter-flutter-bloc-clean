# ⚡ Quick Guide: Adding Features

Follow these steps to add a new feature to the `feature/starter-clean-bloc` branch.

## 1. Domain Layer (The Contract)

Start by defining what the feature does, without worrying about data sources or UI.

- **Entity**: Create the core data model in `domain/entities/`.
- **Repository Interface**: Define the abstract repository in `domain/repositories/`.
- **UseCase**: Create small, specific use case classes in `domain/usecases/`.

## 2. Data Layer (The Implementation)

Implement the contracts defined in the domain layer.

- **Model**: Create data models (JSON serialization) in `data/models/`.
- **DataSource**: Create remote/local data sources in `data/datasources/`.
- **Repository Implementation**: Implement the repository interface in `data/repositories/`.

## 3. Presentation Layer (The UI)

Connect the logic to the user interface.

- **BLoC**: Generate or create the BLoC (State, Event, Bloc) in `presentation/bloc/`.
- **Pages/Widgets**: Implement the UI using `BlocBuilder`, `BlocListener`, or `BlocConsumer`.

---

## 🔧 Dependency Injection

Register your new classes in the feature's injection file (e.g., `lib/features/auth/auth_injection.dart`) or the main injection file if needed.

```dart
// Example registration
sl.registerLazySingleton<MyRepository>(() => MyRepositoryImpl(dataSource: sl()));
sl.registerFactory(() => MyBloc(useCase: sl()));
```

## 🛠 Useful Commands

- **Build Runner**: `flutter pub run build_runner build --delete-conflicting-outputs`
- **Linting**: `flutter analyze`
- **Testing**: `flutter test`

## 🎯 Flavors (sandbox / live)

Two flavors separate sandbox (dev/staging) from production (live):

| Flavor    | Bundle ID                  | App Name      | Usage                          |
|-----------|----------------------------|---------------|--------------------------------|
| `sandbox` | `em.starter.app.sandbox`   | App Sandbox   | Development & Staging          |
| `live`    | `em.starter.app`           | App           | Production                     |

### Run commands

```bash
# Development on sandbox
flutter run --flavor sandbox -t lib/main_development.dart

# Staging on sandbox
flutter run --flavor sandbox -t lib/main_staging.dart

# Production on live
flutter run --flavor live -t lib/main_production.dart
```

### Build commands

```bash
# Android APK (sandbox)
flutter build apk --flavor sandbox -t lib/main_development.dart

# Android App Bundle (live, release)
flutter build appbundle --flavor live -t lib/main_production.dart --obfuscate --split-debug-info=build/symbols

# iOS (live, release)
flutter build ipa --flavor live -t lib/main_production.dart --obfuscate --split-debug-info=build/symbols
```

### Firebase setup

1. Create two Firebase projects (or two apps in one project)
2. **Android**: Replace placeholder `google-services.json` in:
   - `android/app/src/sandbox/google-services.json`
   - `android/app/src/live/google-services.json`
3. **iOS**: Replace placeholder `GoogleService-Info.plist` in:
   - `ios/config/sandbox/GoogleService-Info.plist`
   - `ios/config/live/GoogleService-Info.plist`
4. **Android**: Uncomment the `google-services` plugin lines in:
   - `android/settings.gradle.kts`
   - `android/app/build.gradle.kts`

### iOS flavor setup

Before building for iOS, set the active flavor:

```bash
# Set sandbox flavor
bash ios/scripts/set_flavor.sh sandbox

# Set live flavor
bash ios/scripts/set_flavor.sh live
```

Add `ios/scripts/copy_firebase_config.sh` as a Run Script build phase in Xcode
(Runner target, before "Copy Bundle Resources") to auto-copy the correct
GoogleService-Info.plist at build time.

## 🔒 Release Build (Obfuscated)

Always use obfuscation + flavor for release builds:

```bash
# Android
flutter build apk --flavor live -t lib/main_production.dart --obfuscate --split-debug-info=build/symbols
flutter build appbundle --flavor live -t lib/main_production.dart --obfuscate --split-debug-info=build/symbols

# iOS
flutter build ipa --flavor live -t lib/main_production.dart --obfuscate --split-debug-info=build/symbols
```

Keep the `build/symbols/` folder — you need it to symbolicate crash reports.

## 🔑 Release Signing (Android)

1. Copy `android/keystore.properties.example` → `android/keystore.properties`
2. Fill in your keystore credentials
3. Uncomment the signing config block in `android/app/build.gradle.kts`
4. **Never commit** `keystore.properties` or `.jks` files to version control

---

## 🚀 Renaming for a New Project

When moving this boilerplate to a new project (e.g., `com.client.newapp`), follow these steps rather than using automated renaming tools, as they may miss flavor configurations.

### 1. Global Search & Replace
Search for `em.starter.app` and replace it everywhere with your new base bundle ID (e.g., `com.client.newapp`). This covers:
- `android/app/build.gradle.kts`
- `ios/Flutter/live.xcconfig`
- `ios/Flutter/sandbox.xcconfig` (will become `com.client.newapp.sandbox`)

### 2. Update Android Namespace
In `android/app/build.gradle.kts`, ensure the `namespace` matches your new package name:
```kotlin
android {
    namespace = "com.client.newapp"
    ...
}
```

### 3. Update Directory Structure (Android)
Move your `MainActivity.kt` to the new package directory:
- Old: `android/app/src/main/kotlin/em/starter/app/MainActivity.kt`
- New: `android/app/src/main/kotlin/com/client/newapp/MainActivity.kt`
*(Ensure the `package` line inside the file is updated too)*

### 4. App Names
Update the `BUNDLE_DISPLAY_NAME` in:
- `ios/Flutter/sandbox.xcconfig`
- `ios/Flutter/live.xcconfig`
- And `resValue("string", "app_name", "...")` in `android/app/build.gradle.kts`

### 5. Firebase
Regenerate your `google-services.json` and `GoogleService-Info.plist` files for the new bundle IDs and update the placeholder files in:
- `android/app/src/sandbox/`
- `android/app/src/live/`
- `ios/config/sandbox/`
- `ios/config/live/`

