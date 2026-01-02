# Helper Extensions Guide

This directory contains `BuildContext` and `Theme` extensions designed to simplify development, improve readability, and enforce consistency across the application.

## Table of Contents
- [ThemeExtension](#themeextension)
- [TextStyleExtension](#textstyleextension)
- [AppColorsExtension](#appcolorsextension)
- [SnackBarExtension](#snackbarextension)

---

## ThemeExtension

**File:** `theme_extension.dart`

Simplifies access to commonly used `ThemeData` properties. Instead of writing verbose `Theme.of(context)` calls, use these concise getters.

### Usage
```dart
// ❌ Old Way
final color = Theme.of(context).colorScheme.primary;
final style = Theme.of(context).textTheme.headlineLarge;

// ✅ New Way (Extension)
final color = context.colorScheme.primary;
final style = context.headlineLarge;
```

### Benefits
- **Readability**: Reduces boilerplate code by ~70%.
- **Safety**: Standardizes access patterns.
- **Velocity**: Faster to type and read.

---

## TextStyleExtension

**File:** `text_style_extension.dart`

Provides fluent getters for adjusting font weights without verbose `copyWith` calls.

### Usage
```dart
// ❌ Old Way
Text(
  'Hello',
  style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
);

// ✅ New Way (Extension)
Text(
  'Hello',
  style: context.bodyLarge?.bold,
);
```

### Available Getters
- `.bold` (w700)
- `.semiBold` (w600)
- `.medium` (w500)
- `.regular` (w400)
- `.light` (w300)

### Benefits
- **Clarity**: Explicit intent ("I want bold text") vs property configuration.
- **Consistency**: Prevents accidental usage of non-standard weights (e.g., manually setting `w800` instead of `bold`).

---

## AppColorsExtension

**File:** `app_colors_extension.dart`

Integrates custom colors (not found in Material `ColorScheme`) into the standard Flutter Theme system. This enables these colors to automatically switch between Light and Dark modes.

### Usage
```dart
// Accessing a custom color for shimmer effect
Container(
  color: context.appColors.shimmerBgColor,
);
```

### Benefits
- **Theme-Aware**: Custom colors adapt to user theme preferences automatically.
- **Interpolation**: Supports smooth transitions (lerping) when switching themes, unlike static color constants.

---

## SnackBarExtension

**File:** `snackbar_extension.dart`

Standardizes Snackbar display logic, ensuring consistent success/error states and automatic dismissal of previous toasts.

### Usage
```dart
// Show generic message
context.showSnackBar('Profile updated');

// Show error (Red background)
context.showErrorSnackBar('Network connection failed');

// Show success (Green background)
context.showSuccessSnackBar('Saved successfully!');
```

### Benefits
- **Consistency**: Enforces standard styling for Error and Success states globally.

---

## CoreExtensions

**File:** `core_extensions.dart`

Contains logical helpers for Strings, Lists, and Dates. These reduce null-safety boilerplate and provide consistent validation.

### 1. String Extensions

#### Null Safety
```dart
String? username;

print(username.orEmpty);          // ""
print(username.orEmpty('Guest')); // "Guest"
print(username.isNullOrEmpty);    // true
```

#### Validation & Formatting
```dart
// Validation
if (email.isValidEmail) {
  // Proceed with login
}

// Formatting
Text(name.capitalize); // "john" -> "John"
```

---

### 2. List Extensions

#### Safe Access
Default list access throws an error if index is invalid. Use `.safeElementAt` instead.
```dart
final List<String> items = ['A', 'B'];

// ❌ Old Way (Risk of RangeError)
final item = items[5]; // CRASH!

// ✅ New Way (Safe)
final item = items.safeElementAt(5); // Returns null
```

#### Checks
```dart
if (list.isNullOrEmpty) {
  return SizedBox();
}
```

---

### 3. Date Extensions

#### Formatting
Wraps `intl` package for cleaner syntax.
```dart
final date = DateTime.now();
Text(date.format('dd MMM yyyy')); // "02 Jan 2026"
```

#### Boolean Helpers
```dart
if (date.isToday) {
  return Text("Today");
}

if (date.isYesterday) {
  return Text("Yesterday");
}
```

### Benefits
- **Safety**: `.safeElementAt` and `.orEmpty` prevent `RangeError` and `null` display issues.
- **Velocity**: Provides one-line solutions for common tasks like Regex validation and Date formatting.
- **Readability**: Logic reads like English sentences (`date.isToday`, `email.isValidEmail`).

