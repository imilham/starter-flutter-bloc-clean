# 🚀 Flutter Project Setup & Branding SOP

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-Proprietary-red?style=for-the-badge)](LICENSE)


> *Transforming the complexity of setup into the simplicity of art. This guide is your brush, the codebase your canvas.*

---

### 📘 Starter App Cloning Guide

For detailed instructions on cloning, branch selection, and project setup, please refer to the official documentation:

👉 **[View Cloning Guide & SOP](https://docs.google.com/document/d/1C1Bp0MGl6SzpteSpHiG3OEZL_h7firR_a-HA8s8godM/edit?usp=sharing)**

---

### 🌿 Available Branches

| Branch Name | Features & Description |
|:---|:---|
| `main` | **Standard Base.** The clean, lightweight core with essential structure and standard auth. |
| `feature/biometric-auth-im` | **Biometric Security.** Includes FaceID/TouchID integration. |
| `feature/dual-user-flow-im` | **Dual Persona.** Separate flows for two distinct user types with isolated stacks. |
| `feature/localization-imilham` | **Localization Ready.** Pre-configured i18n setup. |
| `feature/modular-di-im` | **Clean DI.** Refactored modular dependency injection structure. |

---

### 📦 Build & Deployment

#### 1. Internal Testing (Universal APK)
For sharing the app manually (Slack/Drive) for testing, use the Universal APK. It is slightly larger but works on all device architectures.
```bash
flutter build apk
```

#### 2. Production (Google Play Store)
**Always** use App Bundles for production. Google Play will automatically optimize the download size (~15-20MB) for each specific device.
```bash
flutter build appbundle
```

#### 3. Size Analysis
To investigate the app's binary size and identify heavy assets:
```bash
flutter build apk --analyze-size
```

#### 📋 Optimization Notes
- **Minification**: Enabled R8 code shrinking and resource shrinking in `build.gradle.kts` for release builds.
- **Tree Shaking**: Flutter automatically removes unused icons and fonts during the build process.
