import 'dart:convert';

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
///
/// Usage:
/// ```dart
/// // Initialize in main.dart before runApp
/// await FirebaseNotificationService.instance.initialize();
///
/// // Get FCM token (for sending to backend)
/// String? token = await FirebaseNotificationService.instance.getToken();
///
/// // Listen to token refresh
/// FirebaseNotificationService.instance.onTokenRefresh((newToken) {
///   // Send updated token to backend
/// });
/// ```
class FirebaseNotificationService {
  FirebaseNotificationService._();
  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Initialize Firebase Messaging and Local Notifications
  ///
  /// Call this method in main.dart before runApp()
  /// Requests notification permissions and sets up handlers
  Future<void> initialize() async {
    try {
      // Request notification permissions (iOS)
      await _requestPermission();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get and log FCM token
      final token = await getToken();
      debugPrint('FCM Token: $token');

      // Setup message handlers
      _setupMessageHandlers();

      debugPrint('Firebase Notification Service initialized successfully');
    } catch (e) {
      debugPrint('Error initializing Firebase Notification Service: $e');
    }
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
      'Notification permission status: ${settings.authorizationStatus}',
    );
  }

  /// Initialize Flutter Local Notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
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
    debugPrint('Foreground message received: ${message.messageId}');
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');
    debugPrint('Data: ${message.data}');

    // Show local notification when app is in foreground
    if (message.notification != null) {
      await _showLocalNotification(message);
    }
  }

  /// Handle notification tap (when app is in background)
  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification tapped: ${message.messageId}');
    _navigateBasedOnPayload(message.data);
  }

  /// Handle initial message (when app was opened from terminated state)
  Future<void> _handleInitialMessage() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('App opened from notification: ${initialMessage.messageId}');
      _navigateBasedOnPayload(initialMessage.data);
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel', // Channel ID
      'Default Notifications', // Channel name
      channelDescription: 'General notifications for Crescent Charge',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
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
      message.notification?.title ?? 'Crescent Charge',
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
      } catch (e) {
        debugPrint('Error parsing notification payload: $e');
      }
    }
  }

  /// Navigate to appropriate screen based on notification data
  void _navigateBasedOnPayload(Map<String, dynamic> data) {
    // Extract navigation data
    final type = data['type'] as String?;
    final route = data['route'] as String?;

    debugPrint('Notification payload - type: $type, route: $route');

    // Navigate based on notification type
    if (route != null && route.isNotEmpty) {
      Get.toNamed(route);
    } else {
      // Default navigation based on type
      switch (type) {
        case 'donation':
          // Navigate to donation screen
          // Get.toNamed('/donation');
          break;
        case 'reward':
          // Navigate to rewards screen
          // Get.toNamed('/rewards');
          break;
        case 'profile':
          // Navigate to profile screen
          // Get.toNamed('/profile');
          break;
        default:
          debugPrint('Unknown notification type: $type');
      }
    }
  }

  /// Get FCM token
  ///
  /// Returns the current FCM token for this device
  /// Use this token to send notifications from your backend
  Future<String?> getToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  /// Listen to token refresh events
  ///
  /// FCM tokens can be refreshed by Firebase
  /// Call this to get notified when token changes
  void onTokenRefresh(Function(String) callback) {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token refreshed: $newToken');
      callback(newToken);
    });
  }

  /// Delete FCM token
  ///
  /// Call this when user logs out to remove the token
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      debugPrint('FCM token deleted');
    } catch (e) {
      debugPrint('Error deleting FCM token: $e');
    }
  }

  /// Subscribe to a topic
  ///
  /// Use this to subscribe users to specific notification topics
  /// Example: subscribeToTopic('all_users')
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }
}

/// Background message handler
///
/// This must be a top-level function (not inside a class)
/// Handles notifications when app is terminated
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Background message: ${message.messageId}');
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Data: ${message.data}');
}
