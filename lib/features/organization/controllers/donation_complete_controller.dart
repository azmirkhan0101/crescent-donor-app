import 'dart:async';
import 'dart:io';

import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
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
      openDownloadedFile(payload);
    }
  }

  /// Open the downloaded PDF file
  Future<void> openDownloadedFile(String filePath) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final file = File(filePath);
      if (await file.exists()) {

        final result = await OpenFilex.open(filePath);

        if (result.type != ResultType.done) {
          ToastMsg.error('Failed to open file');
        }
      } else {
        ToastMsg.error('File not found');
      }
    } catch (e) {
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

  Future<void> downloadReceipt(String url, String fileName) async {
    const int notificationId = 0;
    File? tempFile;
    bool isSavedSuccessfully = false; // Track if we should preserve the cache file

    try {
      // Initialize notifications
      await initializeNotifications();

      // 1. Run the clear cache routine at the start to tidy up old files
      await clearOldExportCache();

      // Request notification permission for Android 13+
      if (Platform.isAndroid) {
        final notificationStatus = await Permission.notification.status;
        if (!notificationStatus.isGranted) {
          await Permission.notification.request();
        }
      }

      // 2. Align with the 'exports' subfolder used by your cleanup routine
      final tempDir = await getTemporaryDirectory();
      final exportDir = Directory('${tempDir.path}/exports');
      if (!await exportDir.exists()) {
        await exportDir.create(recursive: true);
      }

      final tempFilePath = '${exportDir.path}/$fileName.pdf';
      tempFile = File(tempFilePath);

      // Show initial download notification
      await _showDownloadNotification(
        notificationId,
        'Downloading receipt...',
        0,
      );

      // 3. Download the file with progress tracking (UNTOUCHED LOGIC)
      final request = http.Request('GET', Uri.parse(url));
      final response = await http.Client().send(request);

      if (response.statusCode == 200) {
        final contentLength = response.contentLength ?? 0;
        final sink = tempFile.openWrite();

        int downloaded = 0;
        int lastProgress = 0;

        await for (var chunk in response.stream) {
          sink.add(chunk);
          downloaded += chunk.length;

          final progress = contentLength > 0
              ? ((downloaded / contentLength) * 100).toInt()
              : 0;

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

        // 4. Open the Native "Save As" file dialog
        final params = SaveFileDialogParams(sourceFilePath: tempFile.path);
        final finalPath = await FlutterFileDialog.saveFile(params: params);

        if (finalPath != null) {
          isSavedSuccessfully = true; // Mark true so 'finally' doesn't delete it

          // CRITICAL: Pass the internal tempFile.path as the payload, NOT finalPath
          await _showDownloadCompleteNotification(
            notificationId,
            'Receipt downloaded successfully',
            tempFile.path,
          );

          ToastMsg.success('Receipt saved successfully');
        } else {
          await _showDownloadErrorNotification(
              notificationId, 'Save cancelled');
          ToastMsg.error('Save cancelled');
        }
      } else {
        await _showDownloadErrorNotification(notificationId, 'Download failed');
        ToastMsg.error('Failed to download receipt');
      }
    } catch (e) {
      await _showDownloadErrorNotification(
        notificationId,
        'Download failed: $e',
      );
      ToastMsg.error('Failed to download receipt');
    } finally {
      // 5. Smart Cleanup: Only delete immediately if the process failed or was cancelled.
      // If successful, leave it alive so the user can tap the notification to view it!
      if (!isSavedSuccessfully && tempFile != null && await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }

  /// Scans the internal app sandbox and deletes temporary export files
  /// that have been sitting around for more than 6 hours.
  Future<void> clearOldExportCache() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final exportDir = Directory('${tempDir.path}/exports');

      if (await exportDir.exists()) {
        final now = DateTime.now();

        // Asynchronously list files in the exports directory
        await for (final entity in exportDir.list()) {
          if (entity is File) {
            final lastModified = await entity.lastModified();

            // Checks if the file age exceeds 6 hours
            if (now.difference(lastModified).inHours > 6) {
              await entity.delete();
              debugPrint('Successfully purged old export cache: ${entity.path}');
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error clearing export cache: $e');
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
      autoCancel: false
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
