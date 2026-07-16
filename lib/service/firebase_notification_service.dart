import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

/// Firebase Notification Service
///
/// Handles all Firebase Cloud Messaging (FCM) functionality including:
/// - FCM token generation and management
/// - Foreground notification handling
/// - Background notification handling
/// - Notification permission requests
/// - Local notification display
class FirebaseNotificationService {
  FirebaseNotificationService._();
  static final FirebaseNotificationService instance =
  FirebaseNotificationService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  /// Initialize Firebase Messaging and Local Notifications
  Future<void> initialize() async {
    try {
      // Request notification permissions
      await _requestPermission();

      // Turn off native popups when app is open (Prevents duplicate popups in foreground)
      await _configureForegroundPresentation();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Setup message handlers
      _setupMessageHandlers();
    } catch (_) {
    }
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  /// Force Firebase to turn off native UI banners in foreground so local notifications take control cleanly
  Future<void> _configureForegroundPresentation() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );
  }

  /// Initialize Flutter Local Notifications
  Future<void> _initializeLocalNotifications() async {
    // Standardize your modern monochrome notification asset name here
    // (e.g., 'ic_stat_notification' instead of the full app launcher icon to prevent solid white squares)
    const androidSettings = AndroidInitializationSettings(
      'ic_stat_notification',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  /// Setup message handlers for different notification states
  void _setupMessageHandlers() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background messages (when app is in background but not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Handle notification that opened the app from terminated state
    _handleInitialMessage();
  }

  /// Handle messages when app is in foreground
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print("Foreground received");
    }

    // Show local notification when app is in foreground
    if (message.notification != null) {
      await _showLocalNotification(message);
    }
  }

  /// Handle notification tap (when app is in background)
  void _handleNotificationTap(RemoteMessage message) {
    _navigateBasedOnPayload(message.data);
  }

  /// Handle initial message (when app was opened from terminated state)
  Future<void> _handleInitialMessage() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _navigateBasedOnPayload(initialMessage.data);
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription: 'General notifications for Crescent Change',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: 'ic_stat_notification', // Updated to use the correct drawable resource string
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'Crescent Change',
      message.notification?.body ?? '',
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  /// Handle notification tap from local notifications
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!) as Map<String, dynamic>;
        _navigateBasedOnPayload(data);
      } catch (_) {
      }
    }
  }

  /// Navigate to appropriate screen based on notification data
  void _navigateBasedOnPayload(Map<String, dynamic> data) {
    final route = data['route'] as String?;

    if (route != null && route.isNotEmpty) {
      Get.toNamed(route);
    }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    try {
      String? token;
      if (Platform.isIOS) {
        String? apnsToken;
        for (int i = 0; i < 5; i++) {
          apnsToken = await _firebaseMessaging.getAPNSToken();
          if (apnsToken != null) {
            break;
          }
          await Future.delayed(const Duration(seconds: 2));
        }
      }
      token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      return null;
    }
  }

  /// Listen to token refresh events
  void onTokenRefresh(Function(String) callback) {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      callback(newToken);
    });
  }

  /// Delete FCM token
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
    } catch (_) {
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
    } catch (_) {
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    } catch (_) {
    }
  }
}

/// Background message handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Silent execution handler. System native handler will draw background UI alerts automatically.
}