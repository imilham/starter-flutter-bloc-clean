import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  PushNotificationService() {
    _firebaseMessaging = FirebaseMessaging.instance;
    _localNotifications = FlutterLocalNotificationsPlugin();
    _onMessageStreamController = StreamController<RemoteMessage>.broadcast();
    _onMessageOpenedAppStreamController = StreamController<RemoteMessage>.broadcast();
  }

  late final FirebaseMessaging _firebaseMessaging;
  late final FlutterLocalNotificationsPlugin _localNotifications;
  late final StreamController<RemoteMessage> _onMessageStreamController;
  late final StreamController<RemoteMessage> _onMessageOpenedAppStreamController;

  Stream<RemoteMessage> get onMessage => _onMessageStreamController.stream;

  Stream<RemoteMessage> get onMessageOpenedApp => _onMessageOpenedAppStreamController.stream;

  /// Initializes Firebase Messaging and Local Notifications
  /// Call this in your app's bootstrap or main.dart
  Future<void> initialize() async {
    try {
      // Request user permission
      final settings = await _firebaseMessaging.requestPermission(provisional: true);

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        log('User granted notification permission', name: 'PushNotificationService');
      } else {
        log('User denied notification permission', name: 'PushNotificationService');
        return;
      }

      // Configure foreground notification presentation
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Initialize local notifications
      _initializeLocalNotifications();

      // Setup message handlers
      await _setupMessageHandlers();

      // Get and log token in debug mode
      if (kDebugMode) {
        final token = await getToken();
        log('FCM Token: $token', name: 'PushNotificationService');
      }
    } catch (e) {
      log('Failed to initialize push notifications: $e', name: 'PushNotificationService', error: e);
    }
  }

  /// Gets the FCM token for this device
  Future<String?> getToken() async {
    try {
      String? fcmToken;

      if (Platform.isAndroid) {
        fcmToken = await _firebaseMessaging.getToken();
      } else if (Platform.isIOS) {
        final apnToken = await _firebaseMessaging.getAPNSToken();
        if (apnToken != null) {
          fcmToken = await _firebaseMessaging.getToken();
        } else {
          log('APNs token is null, cannot get FCM token', name: 'PushNotificationService');
        }
      }

      return fcmToken;
    } catch (e) {
      log('Failed to get FCM token: $e', name: 'PushNotificationService', error: e);
      return null;
    }
  }

  void _initializeLocalNotifications() {
    if (Platform.isAndroid) {
      _localNotifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      _localNotifications
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }

    const initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_notification');
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationTapped,
    );
  }

  Future<void> _setupMessageHandlers() async {
    // Handle notification when app is terminated and user clicks on it
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _onMessageOpenedAppStreamController.add(initialMessage);
    }

    // Handle when user taps on notification (app in background)
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_foregroundMessage);
  }

  Future<void> _foregroundMessage(RemoteMessage message) async {
    log('Handling foreground message: ${message.messageId}', name: 'PushNotificationService');

    if (Platform.isAndroid && message.notification != null) {
      await _showLocalNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        payload: message.data.toString(),
      );
    }

    _onMessageStreamController.add(message);
  }

  Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    log('Message opened from background: ${message.messageId}', name: 'PushNotificationService');
    _onMessageOpenedAppStreamController.add(message);
  }

  Future<void> _onLocalNotificationTapped(NotificationResponse response) async {
    log('Local notification tapped with payload: ${response.payload}', name: 'PushNotificationService');
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'notification_channel',
      'Notifications',
      channelDescription: 'Notification channel',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await _localNotifications.show(
      title.hashCode,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  void dispose() {
    _onMessageStreamController.close();
    _onMessageOpenedAppStreamController.close();
  }
}

/// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling background message: ${message.messageId}', name: 'PushNotificationService');
}
