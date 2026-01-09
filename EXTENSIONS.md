# Extensions Reference

Quick reference for all available extensions in the StarterIM project.

> **Live Demo**: Navigate to **More → Design System → Extensions** tab in the app.

---

## Widget Layout Extensions

| Extension | Description | Example |
|-----------|-------------|---------|
| `.expanded` | Wrap in `Expanded` | `Text('Hi').expanded` |
| `.flexible` | Wrap in `Flexible` | `widget.flexible` |
| `.center` | Wrap in `Center` | `widget.center` |
| `.align()` | Wrap in `Align` | `widget.align(Alignment.topLeft)` |
| `.safeArea` | Wrap in `SafeArea` | `widget.safeArea` |
| `.sizedBox()` | Constrain size | `widget.sizedBox(width: 100)` |
| `.aspectRatio()` | Aspect ratio | `widget.aspectRatio(ratio: 16/9)` |

### Visibility & Opacity

| Extension | Description | Example |
|-----------|-------------|---------|
| `.visible()` | Show/hide | `widget.visible(isVisible: true)` |
| `.opacity()` | Apply opacity | `widget.opacity(value: 0.5)` |

### Transforms

| Extension | Description | Example |
|-----------|-------------|---------|
| `.scale()` | Scale | `widget.scale(factor: 1.5)` |
| `.rotate()` | Rotate (radians) | `widget.rotate(angle: pi/4)` |
| `.rotateDegrees()` | Rotate (degrees) | `widget.rotateDegrees(degrees: 45)` |

### Pointer Handling

| Extension | Description | Example |
|-----------|-------------|---------|
| `.ignore()` | `IgnorePointer` | `widget.ignore(isIgnoring: true)` |
| `.absorb()` | `AbsorbPointer` | `widget.absorb(isAbsorbing: true)` |

### Interaction

| Extension | Description | Example |
|-----------|-------------|---------|
| `.onTap()` | Tap callback | `widget.onTap(() => ...)` |
| `.onLongPress()` | Long press | `widget.onLongPress(() => ...)` |

### Accessibility & UX

| Extension | Description | Example |
|-----------|-------------|---------|
| `.tooltip()` | Add tooltip | `widget.tooltip(message: 'Info')` |
| `.hero()` | Hero animation | `widget.hero(tag: 'profile')` |
| `.semantics()` | A11y label | `widget.semantics(label: 'Button')` |

---

## Toast Extensions

Adaptive, overlay-based toast notifications (no external package).

```dart
// Basic
context.showToast('Hello World');

// Position & Duration
context.showToast(
  'Saved!',
  length: ToastLength.long,       // 3.5s
  gravity: ToastGravity.top,      // Top of screen
);

// Custom Colors
context.showToast(
  'Error',
  backgroundColor: Colors.red,
  textColor: Colors.white,
);
```

---

## Padding Extensions

```dart
// All sides
widget.paddingAll4    // 4px
widget.paddingAll8    // 8px
widget.paddingAll16   // 16px
widget.paddingAll24   // 24px

// Horizontal
widget.paddingHorizontal4
widget.paddingHorizontal16

// Vertical
widget.paddingVertical8
widget.paddingVertical16

// Custom
widget.paddingOnly(l: 8, t: 16, r: 8, b: 0)
widget.padding(EdgeInsets.only(left: 10))
```

---

## Border Radius Extensions

```dart
// All corners
widget.borderRadiusAll4
widget.borderRadiusAll8
widget.borderRadiusAll16
widget.borderRadiusAllPill    // 999px

// Top/Bottom
widget.borderRadiusTop8
widget.borderRadiusBottom16

// Custom
widget.borderRadiusOnly(tl: 8, br: 8)

// Shapes
widget.clipOval   // Circle/oval
widget.clipRRect(BorderRadius.circular(12))
```

---

## List<Widget> Extensions

```dart
// Convert to layout widgets
[w1, w2].toColumn()
[w1, w2].toRow()
[w1, w2].toStack()
[w1, w2].toWrap(spacing: 8)

// With parameters
[w1, w2].toColumn(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
)

// Insert separators
[w1, w2, w3].separatedBy(Gap.small8)
```

---

## BuildContext Extensions

### Theme Access

```dart
context.theme         // ThemeData
context.colorScheme   // ColorScheme
context.textTheme     // TextTheme
context.appColors     // Custom AppColors

// Colors
context.colorScheme.primary
context.colorScheme.secondary
context.colorScheme.error
```

### Text Styles

```dart
context.displayLarge
context.displayMedium
context.headlineLarge
context.headlineMedium
context.titleLarge
context.bodyLarge
context.bodyMedium
context.bodySmall
context.labelLarge
context.labelSmall

// With copyWith
Text('Hello', style: context.bodyMedium?.copyWith(
  color: context.colorScheme.error,
  fontWeight: FontWeight.bold,
))
```

### Screen Size

```dart
context.screenWidth
context.screenHeight
context.screenPadding   // SafeArea insets
context.isLandscape
context.isPortrait
```

---

## SnackBar Extensions

```dart
// Basic
context.showSnackBar('Message');

// With action
context.showSnackBar(
  'Deleted',
  action: SnackBarAction(label: 'Undo', onPressed: () => ...),
);

// Styled
context.showSuccessSnackBar('Saved!');
context.showErrorSnackBar('Something went wrong');

// Custom
context.showCustomSnackBar(
  content: Row(children: [Icon(...), Text(...)]),
  backgroundColor: Colors.blue,
);
```

---

## Core Extensions

### String

```dart
nullableString.orEmpty           // Returns '' if null
nullableString.orEmpty('Guest')  // Returns 'Guest' if null
string.isNullOrEmpty
string.isNotNullOrEmpty
string.capitalize                // 'hello' → 'Hello'
string.isValidEmail
```

### DateTime

```dart
date.format('dd MMM yyyy')    // '02 Jan 2026'
date.isToday
date.isYesterday
date.formatWithSuffix         // '1st January 2026'

// From string
'2026-01-06'.toDateTime
'2026-01-06'.formatDate('dd/MM/yyyy')
```

### List

```dart
list.safeElementAt(5)   // null if out of bounds
list.isNullOrEmpty
```

### Duration (on num)

```dart
500.milliseconds
2.seconds
5.minutes
24.hours
7.days

// Usage
await Future.delayed(2.seconds);
await apiCall().delay(500.milliseconds);
```

---

## TextStyle Extensions

Fluent API for styling:

```dart
style.bold
style.semiBold
style.medium
style.regular
style.light
style.italic
style.underline
style.lineThrough
style.setColor(Colors.red)

// Chain them
bodyRegular16().bold.italic.setColor(Colors.blue)
```

---

## Constants

### Spacing (`Gap` and `AppSpacing`)

```dart
// Gap widgets (for Column/Row)
Gap.extraSmall4   // 4px
Gap.small8        // 8px
Gap.medium16      // 16px
Gap.large24       // 24px

// AppSpacing values
AppSpacing.xs4    // 4
AppSpacing.sm8    // 8
AppSpacing.md16   // 16
AppSpacing.lg24   // 24

// EdgeInsets
AppSpacing.horizontalMd16
AppSpacing.verticalSm8
AppSpacing.allMd16
```

### Radius (`AppRadius`)

```dart
AppRadius.extraSmall4   // BorderRadius 4px
AppRadius.small8        // BorderRadius 8px
AppRadius.medium12      // BorderRadius 12px
AppRadius.large16       // BorderRadius 16px
AppRadius.pill999       // BorderRadius 999px
```
