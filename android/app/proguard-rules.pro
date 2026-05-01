# Flutter / Dart
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# Keep Hive type adapters
-keep class * extends com.google.crypto.tink.** { *; }

# Keep JSON model classes (freezed / json_serializable)
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# OkHttp (used by some plugins)
-dontwarn okhttp3.**
-dontwarn okio.**

# Prevent R8 from stripping interfaces used via reflection
-keepattributes Signature
-keepattributes *Annotation*
