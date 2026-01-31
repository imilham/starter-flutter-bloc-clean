import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:starter/features/auth/auth.dart';

/// A class that represents the application states.
/// It provides getters and setters for various state variables.
class AppStates with ChangeNotifier {
  AppStates();

  final Box<bool> _storage = Hive.box<bool>('states'); // Need to open first before using, see bootstrap.dart

  /// The prefix for the home route.
  final String homePrefix = '/shell';

  AuthSession? _currentSession;

  /// Returns true if the user is logged in, false otherwise.
  bool get isLogin => _currentSession != null;
  AuthSession? get currentSession => _currentSession;

  set currentSession(AuthSession? value) {
    _currentSession = value;
    notifyListeners();
  }

  /// Represents the state of initialization.
  /// This class provides a boolean value indicating whether the object is initialized or not.
  bool _isInitialized = false;

  /// Returns the current initialization state.
  bool get isInitialized => _isInitialized;

  /// Sets the initialization state.
  /// Notifies the listeners after setting the value.
  set isInitialized(bool value) {
    _isInitialized = value;
    notifyListeners();
  }

  /// Returns a boolean value indicating whether the code is verified.
  ///
  /// If the current session is not null, it checks if the email is verified.
  /// If the email is verified, it returns true; otherwise, it returns false.
  bool get isCodeVerified => _currentSession?.isEmailVerified ?? false;

  /// Returns whether the account is completed or not.
  bool get isAccountCompleted => _currentSession?.isProfileCompleted ?? false;

  /// Represents the state of the tutorial page.
  bool _isTutorialShown = false;

  /// Returns whether the tutorial page is shown or not.
  bool get isTutorialShown => _isTutorialShown;

  /// Sets the state of the tutorial page.
  set isTutorialShown(bool value) {
    _isTutorialShown = value;
    _storage.put('isTutorialShown', value);
    notifyListeners();
  }

  /// This method is called when the app starts.
  /// It retrieves the value of 'isTutorialShown' from storage and assigns it to the '_isTutorialShown' variable.
  /// If the value is null, it assigns 'false' as the default value.
  /// Finally, it notifies the listeners about the changes.
  Future<void> onAppStart() async {
    _isTutorialShown = _storage.get('isTutorialShown') ?? false;
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////////
  /// [Global Loading Overlay]
  //////////////////////////////////////////////////////////////////////////////

  bool _isLoaderVisible = false;

  /// Returns true if the global loading overlay is visible.
  bool get isLoaderVisible => _isLoaderVisible;

  /// Shows the global loading overlay.
  /// Call this before async operations to block user interaction.
  void showLoader() {
    if (!_isLoaderVisible) {
      _isLoaderVisible = true;
      notifyListeners();
    }
  }

  /// Hides the global loading overlay.
  /// Always call this in a finally block to ensure the loader is hidden.
  void hideLoader() {
    if (_isLoaderVisible) {
      _isLoaderVisible = false;
      notifyListeners();
    }
  }
}
