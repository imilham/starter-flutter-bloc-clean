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

## 🔒 Release Build (Obfuscated)

Always use obfuscation for release builds to protect your Dart source:

```bash
# Android
flutter build apk --obfuscate --split-debug-info=build/symbols
flutter build appbundle --obfuscate --split-debug-info=build/symbols

# iOS
flutter build ipa --obfuscate --split-debug-info=build/symbols
```

Keep the `build/symbols/` folder — you need it to symbolicate crash reports.

## 🔑 Release Signing (Android)

1. Copy `android/keystore.properties.example` → `android/keystore.properties`
2. Fill in your keystore credentials
3. Uncomment the signing config block in `android/app/build.gradle.kts`
4. **Never commit** `keystore.properties` or `.jks` files to version control
