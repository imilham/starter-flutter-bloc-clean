# Adding New Strings

Follow these 3 simple steps to add a new string to the application.

## 1. Add to ARB File
Open `lib/l10n/arb/app_en.arb` and add your new key-value pair.
**Tip**: Use camelCase for keys.

```json
{
    ...
    "myNewButton": "Click Me",
    "@myNewButton": {
        "description": "Label for the new click me button"
    }
}
```

## 2. Generate Code
- **VS Code**: Just save the file (Cmd+S). The extension handles generation automatically.
- **Terminal**: Run `flutter gen-l10n` manually if needed.

## 3. Use in Code
Use the `context.l10n` extension to access your new string.

```dart
Text(context.l10n.myNewButton),
```
