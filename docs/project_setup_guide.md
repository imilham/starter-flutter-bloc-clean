# ⏱️ Starter BLoC Clean — Quick Setup Guide

Simple guide to securely clone and set up a new Flutter project using the **starter-flutter-bloc-clean** boilerplate, preserving pre-configured platforms and flavors.

---

# ✅ Prerequisites

Make sure you have:
* **Flutter SDK** installed
* **Git** installed and configured  
* **VS Code** or Android Studio

---

# 🏗️ Step 1 — Clone the Repository

Instead of `flutter create`, clone this boilerplate directly to preserve the custom `android` and `ios` flavor setups.

```bash
git clone -b main https://github.com/imilham/starter-flutter-bloc-clean.git <your_app_name>
cd <your_app_name>
```

---

# 🧹 Step 2 — Reset Git History

Remove the starter's git history so you can start fresh for your own project.

```bash
rm -rf .git
git init
git add .
git commit -m "Initial commit from starter boilerplate"
```

---

# 📛 Step 3 — Rename App & Bundle ID

Because the native apps have pre-configured environments (Live, Sandbox) and flavors, doing this manually is dangerous. Use the Dart `rename` tool.

1. Install the tool globally (if you haven't):
```bash
dart pub global activate rename
```

2. Rename the App Name (The name shown on the phone's home screen):
```bash
rename setAppName --targets ios,android --value "Your App Name"
```

3. Rename the Bundle ID (e.g., `com.yourcompany.app`):
```bash
rename setBundleId --targets ios,android --value "com.yourcompany.yourapp"
```

---

# 🏷️ Step 4 — Update Dart Code

## 4.1 Update pubspec.yaml

Change the internal dart package name in `pubspec.yaml`:
```yaml
name: <your_app_name> # e.g. name: my_cool_app
```

## 4.2 Update Package Imports

Use VS Code's global search and replace (`Cmd + Shift + H` on Mac / `Ctrl + Shift + H` on Windows):

**Replace:** `package:starter/`  
**With:** `package:<your_app_name>/`

## 4.3 Rename App Class

In `lib/app/view/app.dart`, rename `StarterApp` to `<YourAppName>` using:
- Right click → **Rename Symbol**
- Or press `F2`

---

# 📦 Step 5 — Finalize & Build

Get dependencies and re-generate localization and runner files.

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

# 🌐 Step 6 — Connect to Your Remote

Add your new remote repository URL:

```bash
git remote add origin <your_repo_url>
git push -u origin main
```

---

# 🎉 You're Ready!

Your Flutter project is set up with all flavors and configurations fully intact. Happy coding! 🚀
