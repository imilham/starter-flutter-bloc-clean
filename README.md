# 🚀 Flutter Project Setup & Branding SOP

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-Proprietary-red?style=for-the-badge)](LICENSE)

**Organization:** `emedia (em.)` | **Project Engine:** `Flutter 3.x`

*A comprehensive guide to setting up and branding Flutter projects with professional standards*



---



## 📋 Table of Contents

| # | Section | Description |
|:-:|:--------|:------------|
| 1 | [🎯 Core Project Creation](#-core-project-creation) | Generate a fresh Flutter project |
| 2 | [💉 Starter Kit Injection](#-starter-kit-injection) | Inject professional logic from starter |
| 3 | [🎨 Branding & Namespace Sync](#-branding--namespace-synchronization) | Update package references |
| 4 | [🔗 Project Repository Setup](#-project-repository-configuration) | Link to project repository |
| 5 | [📤 Establishing Source of Truth](#-establishing-the-source-of-truth) | Push to remote |
| 6 | [✅ Quality Assurance](#-quality-assurance-checklist) | Final verification checks |



---
---



# 🎯 Core Project Creation

We start by generating a fresh Flutter project. This ensures the `android/` and `ios/` directories use the most recent Gradle, Kotlin, and Swift configurations provided by your current SDK.


## Commands

    flutter create --org em.[your_bundle_id] --project-name app [your_project_name]


**Example:**

    flutter create --org em.myapp --project-name app myapp

    cd [your_project_name]


### 💡 Why Create Fresh?

Creating a fresh project ensures you get:

- ✨ Latest Gradle configuration
- ✨ Updated Kotlin version
- ✨ Modern Swift setup
- ✨ No legacy configuration issues



---
---



# 💉 Starter Kit Injection

Instead of a simple clone, we "pluck" the professional logic from the corporate starter. This prevents inheriting old native configuration bugs while keeping the shared business logic.


## Step-by-Step Commands

**Step 1** — Initialize the local repository

    git init


**Step 2** — Link the Starter (Boilerplate) Repo

    git remote add starter git@bitbucket.org:abcim/ilham-starter.git


**Step 3** — Fetch the starter content

    git fetch starter


**Step 4** — Inject the logic, dependencies, and linting rules

    git checkout starter/main -- lib/ pubspec.yaml analysis_options.yaml


**Step 5** — Install dependencies

    flutter pub get


### 📝 Lead Note

If the starter uses `master`, replace `starter/main` with `starter/master`.



---
---



# 🎨 Branding & Namespace Synchronization

Since the starter code likely references a different internal package name (e.g., `starter_app`), we must sync all references to our new name: `app`.


## A. Update pubspec.yaml

Ensure the identity in your config matches your creation command:

    name: [your app name]
    description: "Professional Flutter project branded for emedia."


## B. Global Namespace Update

**Keyboard Shortcuts:**

| Platform | Shortcut |
|:--------:|:--------:|
| VS Code (Mac) | `Cmd + Shift + H` |
| VS Code (Windows) | `Ctrl + Shift + H` |


**Search & Replace:**

| Field | Value |
|:------|:------|
| 🔍 Search | `package:starter/` |
| 🔄 Replace | `package:[your app name]/` |


### ✅ Action

Click **"Replace All"** to update all references.


## C. Verify Application ID (Flutter 3.x)

Flutter 3.x moved the package name from `AndroidManifest.xml` to `build.gradle`. Verify the namespace matches your branding:

**File:** `android/app/build.gradle`

    android {
        namespace = "em.[your_bundle_id].app"
        ...
    }


## D. Clean Build & Dependency Sync

Renaming often leaves "ghost" files in the `build/` folder that cause crashes. Always clean before syncing:

    flutter clean
    flutter pub get



---
---



# 🔗 Project Repository Configuration

We now disconnect from the "Starter" source and link to the **project repository assigned by the PM**.


## Commands

**Step 1** — Remove the starter source link

    git remote remove starter


**Step 2** — Link to the project repository (provided by PM)

    git remote add origin [repository_url_from_pm]


**Example:**

    git remote add origin git@bitbucket.org:abcim/project-name.git


**Step 3** — Verify the connection

    git remote -v


### 💡 Tip

Ask your **Project Manager** for the correct repository URL before proceeding.


### 🔒 Security Note

Before pushing, check for sensitive files inherited from the starter:

- ❌ `.env` files with API keys
- ❌ `google-services.json` or `GoogleService-Info.plist`
- ❌ Any hardcoded secrets in `lib/`

**Ensure these are added to `.gitignore`:**

    # Add to .gitignore
    .env
    .env.*
    **/google-services.json
    **/GoogleService-Info.plist



---
---



# 📤 Establishing the Source of Truth

To finalize the setup and ensure the remote repository reflects your new branded engine, we perform an upstream force-push.


## Commands

**Step 1** — Snapshot the branded setup

    git add .
    git commit -m "Initial: Fresh Engine + emedia Branding + Starter Logic"


**Step 2** — Set upstream and force-sync

    git push -u origin main --force


### ⚠️ Caution

The `--force` flag will overwrite the remote repository. Use with caution!



---
---



# ✅ Quality Assurance Checklist

Ensure every project passes these checks before development begins:


| Status | Check | Command / Action |
|:------:|:------|:-----------------|
| ☐ | **Package Verification** | Run `grep -r "em.ilham.app" .` to ensure the branding exists in Android/iOS |
| ☐ | **Linting Check** | Ensure `analysis_options.yaml` is active (no blue squiggly lines in `lib/` for standard rules) |
| ☐ | **Clean Build** | Run `flutter run` on a simulator to confirm the renaming didn't break the native `MainActivity` or `AppDelegate` |



---



**🎉 Setup Complete!** You're now ready to start development.
