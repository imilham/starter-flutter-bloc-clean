plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// ─── Release Signing (uncomment when ready) ───
// To enable release signing:
// 1. Copy keystore.properties.example → keystore.properties
// 2. Fill in your keystore credentials
// 3. Uncomment the signingConfigs block below
// 4. In buildTypes.release, change signingConfig to signingConfigs.getByName("release")
//
// val keystorePropertiesFile = rootProject.file("keystore.properties")
// val keystoreProperties = java.util.Properties()
// if (keystorePropertiesFile.exists()) {
//     keystoreProperties.load(java.io.FileInputStream(keystorePropertiesFile))
// }

android {
    namespace = "em.starter.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "em.starter.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // ─── Flavors ───
    // Two flavors: sandbox (dev/staging) and live (production).
    // Each gets its own applicationId suffix, app name, and Firebase config.
    //
    // Usage:
    //   flutter run --flavor sandbox -t lib/main_development.dart
    //   flutter run --flavor live    -t lib/main_production.dart
    flavorDimensions += "environment"
    productFlavors {
        create("sandbox") {
            dimension = "environment"
            applicationIdSuffix = ".sandbox"
            resValue("string", "app_name", "App Sandbox")
        }
        create("live") {
            dimension = "environment"
            resValue("string", "app_name", "App")
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")

            // Enable code shrinking for release builds
            isMinifyEnabled = true
            isShrinkResources = true

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }
}

flutter {
    source = "../.."
}
