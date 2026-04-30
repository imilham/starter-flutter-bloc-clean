# Environment Configuration Files

This directory contains environment-specific configuration files for the application.

## Files

- **`.env.development`** - Development environment variables
- **`.env.staging`** - Staging environment variables
- **`.env.production`** - Production environment variables
- **`.env.example`** - Template file (safe to commit)

## Setup

1. Copy `.env.example` to create your environment files:
   ```bash
   cp .env.example .env.development
   cp .env.example .env.staging
   cp .env.example .env.production
   ```

2. Update each file with your actual values:
   ```
   BASE_URL=https://your-api-url.com
   API_KEY=your_actual_api_key
   SESSION_KEY=auth_session_box
   COUNTRY_CODES=+61,+94
   ```

## Security

> NEVER commit actual credentials.

- Only `.env.example` should be committed to version control
- All other `.env*` files are ignored by `.gitignore`
- Keep production credentials secure and separate

## Usage

The app loads the correct `.env` file based on the build target:

```bash
flutter run -t lib/main_development.dart
flutter run -t lib/main_staging.dart
flutter run -t lib/main_production.dart
```
