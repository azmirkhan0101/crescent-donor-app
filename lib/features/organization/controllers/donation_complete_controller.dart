import 'dart:async';
import 'dart:io';

import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/get_donation_full_status_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationCompleteController extends GetxController {
  // Donation summary data
  final RxString _amountDonated = 'Round Up'.obs;
  final RxString _organization = 'Healing Hands International'.obs;
  final RxString _donationType = 'One-Time'.obs;
  final RxString _specialMessage =
      '"Sending love & hope to everyone you\'re helping 💛."'.obs;
  final RxString _timestamp = ''.obs;
  final RxString _transactionId = '8FSD-4829-ACDF'.obs;

  // Timer for auto-refresh
  Timer? _refreshTimer;

  // Local notifications plugin
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Getters
  String get amountDonated => _amountDonated.value;
  String get organization => _organization.value;
  String get donationType => _donationType.value;
  String get specialMessage => _specialMessage.value;
  String get timestamp => _timestamp.value;
  String get transactionId => _transactionId.value;

  @override
  void onInit() {
    super.onInit();
    _generateTimestamp();

    // Get donation data from previous page if passed
    final donationData = Get.arguments as Map<String, dynamic>?;
    if (donationData != null) {
      _amountDonated.value = donationData['amount'] ?? 'Round Up';
      _organization.value =
          donationData['organization'] ?? 'Healing Hands International';
      _donationType.value = donationData['type'] ?? 'One-Time';
      _specialMessage.value =
          donationData['message'] ??
          '"Sending love & hope to everyone you\'re helping 💛."';
    }
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  void _generateTimestamp() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM d, yyyy · h:mm a');
    _timestamp.value = formatter.format(now);
  }

  void onDonePressed() {
    // Navigate back to home and clear all donation-related pages from stack
    Get.offAllNamed('/home');
  }

  void onClosePressed() {
    // Close the page and go back to home
    Get.offAllNamed('/home');
  }

  // /// Start auto-refresh timer if receiptId is not available
  // void startAutoRefreshIfNeeded(
  //   GetDonationFullStatusController controller,
  //   String donationId,
  // ) {
  //   // Cancel any existing timer
  //   _refreshTimer?.cancel();

  //   // Check if receiptId is available
  //   final receiptId =
  //       controller.donationFullStatus.value?.donation.receiptId?.id;

  //   if (receiptId == null || receiptId.isEmpty) {
  //     debugPrint('Receipt ID not available, starting auto-refresh timer...');

  //     // Start a periodic timer that runs every 5 seconds
  //     _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
  //       debugPrint('Auto-refreshing donation status...');

  //       final success = await controller.fetchDonationFullStatus(donationId);

  //       if (success) {
  //         final newReceiptId =
  //             controller.donationFullStatus.value?.donation.receiptId?.id;

  //         if (newReceiptId != null && newReceiptId.isNotEmpty) {
  //           debugPrint(
  //             'Receipt ID received: $newReceiptId, stopping auto-refresh',
  //           );
  //           timer.cancel();
  //           _refreshTimer = null;
  //         }
  //       }
  //     });
  //   } else {
  //     debugPrint('Receipt ID already available: $receiptId');
  //   }
  // }

  /// Initialize notification channel for downloads
  Future<void> initializeNotifications() async {
    // Initialize with callback for notification tap
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    const androidChannel = AndroidNotificationChannel(
      'download_channel',
      'Downloads',
      description: 'Notification channel for file downloads',
      importance: Importance.high,
      enableVibration: false,
      playSound: false,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  /// Handle notification tap - open the downloaded file
  void _onNotificationTapped(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      debugPrint('Notification tapped, opening file: $payload');
      openDownloadedFile(payload);
    }
  }

  /// Open the downloaded PDF file
  Future<void> openDownloadedFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        debugPrint('Opening file: $filePath');

        // Use open_filex to open the file (handles FileProvider automatically)
        final result = await OpenFilex.open(filePath);

        if (result.type == ResultType.done) {
          debugPrint('File opened successfully: $filePath');
        } else if (result.type == ResultType.noAppToOpen) {
          debugPrint('No app found to open PDF file');
          ToastMsg.error('No app found to open PDF files');
        } else if (result.type == ResultType.permissionDenied) {
          debugPrint('Permission denied to open file');
          ToastMsg.error('Permission denied');
        } else if (result.type == ResultType.fileNotFound) {
          debugPrint('File not found: $filePath');
          ToastMsg.error('File not found');
        } else {
          debugPrint('Failed to open file: ${result.message}');
          ToastMsg.error('Failed to open file');
        }
      } else {
        debugPrint('File does not exist: $filePath');
        ToastMsg.error('File not found');
      }
    } catch (e) {
      debugPrint('Error opening file: $e');
      ToastMsg.error('Failed to open file');
    }
  }

  /// Open PDF URL in browser
  Future<void> openReceiptInBrowser(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ToastMsg.error('Could not open receipt in browser');
      }
    } catch (e) {
      debugPrint('Error opening URL in browser: $e');
      ToastMsg.error('Failed to open receipt in browser');
    }
  }

  /// Download PDF file from URL and save to device
  Future<void> downloadReceipt(String url, String fileName) async {
    const int notificationId = 0;

    try {
      // Initialize notifications
      await initializeNotifications();

      Directory? directory;

      if (Platform.isAndroid) {
        // For Android, use external storage directory
        // For Android 13+ (API 33+), scoped storage is used automatically
        // For older versions, we need storage permission
        final storageStatus = await Permission.storage.status;

        if (!storageStatus.isGranted && !storageStatus.isLimited) {
          final result = await Permission.storage.request();
          if (!result.isGranted && !result.isLimited) {
            debugPrint('Storage permission denied');
            // Continue anyway for Android 13+ where permission is not required
          }
        }

        // Request notification permission for Android 13+
        if (Platform.isAndroid) {
          final notificationStatus = await Permission.notification.status;
          if (!notificationStatus.isGranted) {
            await Permission.notification.request();
          }
        }

        // Get external storage directory and create Downloads folder
        final externalDir = await getExternalStorageDirectory();
        if (externalDir != null) {
          // Navigate to Downloads folder: /storage/emulated/0/Download
          final downloadPath = '/storage/emulated/0/Download';
          directory = Directory(downloadPath);

          // Create directory if it doesn't exist
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
        }
      } else if (Platform.isIOS) {
        // For iOS, use application documents directory
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        debugPrint('Unable to access storage directory');
        ToastMsg.error('Unable to access storage directory');
        return;
      }

      // Create the file path
      final filePath = '${directory.path}/$fileName.pdf';
      debugPrint('Downloading receipt to: $filePath');

      // Show initial download notification
      await _showDownloadNotification(
        notificationId,
        'Downloading receipt...',
        0,
      );

      // Download the file with progress tracking
      final request = http.Request('GET', Uri.parse(url));
      final response = await http.Client().send(request);

      if (response.statusCode == 200) {
        final contentLength = response.contentLength ?? 0;
        final file = File(filePath);
        final sink = file.openWrite();

        int downloaded = 0;
        int lastProgress = 0;

        await for (var chunk in response.stream) {
          sink.add(chunk);
          downloaded += chunk.length;

          // Calculate progress percentage
          final progress = contentLength > 0
              ? ((downloaded / contentLength) * 100).toInt()
              : 0;

          // Update notification every 10% to avoid excessive updates
          if (progress - lastProgress >= 10 || progress == 100) {
            lastProgress = progress;
            await _showDownloadNotification(
              notificationId,
              'Downloading receipt...',
              progress,
            );
          }
        }

        await sink.flush();
        await sink.close();

        debugPrint('Receipt saved successfully to: $filePath');

        // Show success notification with file path as payload
        await _showDownloadCompleteNotification(
          notificationId,
          'Receipt downloaded successfully',
          filePath,
        );

        // Show success toast
        ToastMsg.success('Receipt downloaded to Downloads folder');
      } else {
        debugPrint(
          'Failed to download receipt. Status: ${response.statusCode}',
        );

        // Show error notification
        await _showDownloadErrorNotification(notificationId, 'Download failed');

        ToastMsg.error('Failed to download receipt');
      }
    } catch (e) {
      debugPrint('Error downloading receipt: $e');

      // Show error notification
      await _showDownloadErrorNotification(
        notificationId,
        'Download failed: $e',
      );

      ToastMsg.error('Failed to download receipt');
    }
  }

  /// Show download progress notification
  Future<void> _showDownloadNotification(
    int id,
    String title,
    int progress,
  ) async {
    final androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Notification channel for file downloads',
      importance: Importance.high,
      priority: Priority.high,
      showProgress: true,
      maxProgress: 100,
      progress: progress,
      onlyAlertOnce: true,
      ongoing: progress < 100,
      autoCancel: false,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id,
      title,
      '$progress%',
      notificationDetails,
    );
  }

  /// Show download complete notification
  Future<void> _showDownloadCompleteNotification(
    int id,
    String title,
    String filePath,
  ) async {
    final androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Notification channel for file downloads',
      importance: Importance.high,
      priority: Priority.high,
      showProgress: false,
      ongoing: false,
      autoCancel: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id,
      title,
      'Tap to view',
      notificationDetails,
      payload: filePath, // Pass file path to open on tap
    );
  }

  /// Show download error notification
  Future<void> _showDownloadErrorNotification(int id, String message) async {
    final androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Notification channel for file downloads',
      importance: Importance.high,
      priority: Priority.high,
      showProgress: false,
      ongoing: false,
      autoCancel: true,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id,
      'Download Failed',
      message,
      notificationDetails,
    );
  }
}
