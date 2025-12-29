# Flutter Project Setup & Branding SOP

**Organization:** emedia (em.ilham) | **Project Engine:** Flutter 3.x

---

## 1. Core Project Creation

We start by generating a fresh Flutter project. This ensures the `android/` and `ios/` directories use the most recent Gradle, Kotlin, and Swift configurations provided by your current SDK.

```bash
# Define your organization and internal project name
flutter create --org em.ilham --project-name app ilham_app

# Enter the project directory
cd ilham_app
```

---

## 2. Starter Kit "Surgical" Injection

Instead of a simple clone, we "pluck" the professional logic from the corporate starter. This prevents inheriting old native configuration bugs while keeping the shared business logic.

```bash
# Initialize the local repository
git init

# Link the Starter (Boilerplate) Repo
git remote add starter git@bitbucket.org:abcim/ilham-starter.git

# Em repo (alternative)
# git remote add starter git@bitbucket.org:elegantmedia/starter-app.git

git fetch starter

# Inject the logic, dependencies, and linting rules
git checkout starter/main -- lib/ pubspec.yaml analysis_options.yaml

flutter pub get
```

> **Lead Note:** If the starter uses `master`, replace `starter/main` with `starter/master`.

---

## 3. Branding & Namespace Synchronization

Since the starter code likely references a different internal package name (e.g., `starter_app`), we must sync all references to our new name: `app`.

### A. Update `pubspec.yaml`

Ensure the identity in your config matches your creation command:

```yaml
name: app
description: "Professional Flutter project branded for emedia."
```

### B. Global Namespace Update

In VS Code, use `Cmd + Shift + H`:

| Field   | Value                  |
|---------|------------------------|
| Search  | `package:starter_app/` |
| Replace | `package:app/`         |

**Action:** Click "Replace All".

### C. Dependency Sync

```bash
flutter pub get
```

---

## 4. Personal Repository Configuration

We now disconnect from the "Starter" source and link to the project's permanent home.

```bash
# Remove the source link
git remote remove starter

# Link to your personal/project-specific repository (Bitbucket)
git remote add origin git@bitbucket.org:abcim/ilham-starter-test.git

# Verify the connection
git remote -v
```

---

## 5. Establishing the "Source of Truth" (Push)

To finalize the setup and ensure the remote repository reflects your new branded engine, we perform an upstream force-push.

```bash
# Snapshot the branded setup
git add .
git commit -m "Initial: Fresh Engine + emedia Branding + Starter Logic"

# Set upstream and force-sync (Overwrites remote default files)
git push -u origin main --force
```

---

## 📝 Quality Assurance Checklist

Ensure every project passes these checks before development begins:

| Check | Command / Action |
|-------|------------------|
| **Package Verification** | Run `grep -r "em.ilham.app" .` to ensure the branding exists in Android/iOS. |
| **Linting Check** | Ensure `analysis_options.yaml` is active (no blue squiggly lines in `lib/` for standard rules). |
| **Clean Build** | Run `flutter run` on a simulator to confirm the renaming didn't break the native `MainActivity` or `AppDelegate`. |
