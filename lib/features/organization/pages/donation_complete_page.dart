import 'dart:async';
import 'dart:io';

import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/date_time_converter/date_time_converter.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donation_complete_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/get_donation_full_status_controller.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _white = Color(0xFFFFFFFF);
const Color _grayText = Color(0xFF6E6E6E);
const Color _borderColor = Color(0xFFEDEDED);

class DonationCompletePage extends StatefulWidget {
  const DonationCompletePage({super.key});

  @override
  State<DonationCompletePage> createState() => _DonationCompletePageState();
}

class _DonationCompletePageState extends State<DonationCompletePage> {
  Timer? _refreshTimer;

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  /// Start auto-refresh timer if receiptId is not available
  void _startAutoRefreshIfNeeded(
    GetDonationFullStatusController controller,
    String donationId,
  ) {
    // Cancel any existing timer
    _refreshTimer?.cancel();

    // Check if receiptId is available
    final receiptId =
        controller.donationFullStatus.value?.donation.receiptId?.id;

    if (receiptId == null || receiptId.isEmpty) {
      debugPrint('Receipt ID not available, starting auto-refresh timer...');

      // Start a periodic timer that runs every 5 seconds
      _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        debugPrint('Auto-refreshing donation status...');

        final success = await controller.fetchDonationFullStatus(donationId);

        if (success) {
          final newReceiptId =
              controller.donationFullStatus.value?.donation.receiptId?.id;

          if (newReceiptId != null && newReceiptId.isNotEmpty) {
            debugPrint(
              'Receipt ID received: $newReceiptId, stopping auto-refresh',
            );
            timer.cancel();
            _refreshTimer = null;
          }
        }
      });
    } else {
      debugPrint('Receipt ID already available: $receiptId');
    }
  }

  // Initialize local notifications plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification channel for downloads
  Future<void> _initializeNotifications() async {
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
  static void _onNotificationTapped(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      debugPrint('Notification tapped, opening file: $payload');
      _openDownloadedFile(payload);
    }
  }

  /// Open the downloaded PDF file
  static Future<void> _openDownloadedFile(String filePath) async {
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
  Future<void> _openReceiptInBrowser(String url) async {
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
  Future<void> _downloadReceipt(String url, String fileName) async {
    const int notificationId = 0;

    try {
      // Initialize notifications
      await _initializeNotifications();

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

  @override
  Widget build(BuildContext context) {
    final donationCompleteController = Get.put(DonationCompleteController());
    final donateNowCtrl = Get.find<DonateNowController>();
    print('Donation ID: ${donateNowCtrl.donationResponse.value?.donation?.id}');

    return Scaffold(
      backgroundColor: AppColors.lightPageBackground,
      appBar: _buildAppBar(donationCompleteController, context),
      body: GetX<GetDonationFullStatusController>(
        initState: (state) {
          final donationId =
              donateNowCtrl.donationResponse.value?.donation?.id ?? '';
          if (donationId.isNotEmpty) {
            state.controller?.fetchDonationFullStatus(donationId).then((
              success,
            ) {
              if (success) {
                debugPrint(
                  'Fetched donation status for ID: $donationId successfully.',
                );
                // Start auto-refresh timer if receiptId is null
                _startAutoRefreshIfNeeded(state.controller!, donationId);
              } else {
                debugPrint(
                  'Failed to fetch donation status for ID: $donationId.',
                );
              }
            });
          } else {
            debugPrint('Donation ID is empty, cannot fetch status.');
          }
        },

        builder: (controller) {
          final donationDetails = controller.donationFullStatus.value?.donation;
          return RefreshIndicator(
            onRefresh: () async {
              final donationId =
                  donateNowCtrl.donationResponse.value?.donation?.id ?? '';
              if (donationId.isNotEmpty) {
                await controller.fetchDonationFullStatus(donationId);
              }
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.rw),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (controller.isLoading.value)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  else ...[
                    24.rh.heightWidth,

                    // Success Icon
                    // _buildSuccessIcon(),
                    Assets.home.starsTickMark.svg(),

                    24.rh.heightWidth,

                    // Thank You Message
                    Text(
                      'Thank you for your donation!',
                      style: AppTextStyles.f20w600().copyWith(
                        color: _offBlack,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    32.rh.heightWidth,

                    // Summary Card
                    _buildSummaryCard(
                      donatedAmount: donationDetails?.totalAmount
                          .toStringAsFixed(2),
                      organizationName:
                          donationDetails?.organization.name ?? 'N/A',
                      donationType: donationDetails?.donationType ?? 'N/A',
                      specialMessage: donationDetails?.specialMessage,
                      time: donationDetails?.createdAt,
                      receiptId: donationDetails?.receiptId?.id,
                    ),

                    24.rh.heightWidth,

                    // Save Receipt Button
                    _buildSaveReceiptButton(
                      pdfUrl: donationDetails?.receiptId?.pdfUrl,
                    ),

                    60.rh.heightWidth,

                    // Done Button
                    _buildDoneButton(context),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(
    DonationCompleteController controller,
    BuildContext context,
  ) {
    return AppBar(
      backgroundColor: AppColors.lightPageBackground,
      elevation: 0,
      centerTitle: true,
      leading: const SizedBox.shrink(),
      title: Text(
        'Donation Complete',
        style: AppTextStyles.f20w600().copyWith(
          color: _offBlack,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.2,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => context.goNamed(RoutePath.home),
          icon: Container(
            width: 24.rw,
            height: 24.rh,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
            child: const Icon(Icons.close, color: _offBlack, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    String? donatedAmount,
    String? organizationName,
    String? donationType,
    String? specialMessage,
    String? time,
    String? receiptId,
  }) {
    // print(receiptId);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Text(
              'Summary',
              style: AppTextStyles.f16W500().copyWith(color: _offBlack),
            ),
          ),

          // Summary Items
          _buildSummaryItem('Amount donated:', "\$$donatedAmount"),
          _buildSummaryItem('Organization:', organizationName ?? "N/A"),
          _buildSummaryItem('Donation Type:', donationType ?? "N/A"),

          // Special Message
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Special message:',
                  style: AppTextStyles.f14W400().copyWith(color: _grayText),
                ),

                8.rh.heightWidth,

                Text(
                  specialMessage ?? "No special message provided.",
                  style: AppTextStyles.f14W400().copyWith(
                    color: _offBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: _borderColor,
            margin: EdgeInsets.symmetric(vertical: 8.rh),
          ),

          // Timestamp and Transaction ID
          _buildSummaryItem(
            'Time:',
            DateConverter.isoStringToFormattedDateTime(time ?? '') ?? 'N/A',
          ),
          Skeletonizer(
            enabled: receiptId == null,
            child: _buildSummaryItem('Transaction ID:', receiptId ?? "N/A"),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(4.rw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.f14W400().copyWith(color: _grayText),
          ),

          Flexible(
            child: Text(
              value,
              style: AppTextStyles.f14W400().copyWith(
                color: _offBlack,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveReceiptButton({required String? pdfUrl}) {
    return GestureDetector(
      onTap: () async {
        if (pdfUrl != null && pdfUrl.isNotEmpty) {
          // Download the receipt
          await _downloadReceipt(
            pdfUrl,
            'CrescentCharge_Receipt_${DateTime.now().millisecondsSinceEpoch}',
          );

          // Also open in browser for viewing
          await _openReceiptInBrowser(pdfUrl);
        } else {
          ToastMsg.error('Receipt PDF URL is not available.');
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.common.downloadArrow.svg(),

          8.rw.heightWidth,

          Text(
            'Save receipt',
            style: AppTextStyles.f14W400().copyWith(
              color: _offBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.goNamed(RoutePath.home),
      style: ElevatedButton.styleFrom(
        backgroundColor: _offBlack,
        fixedSize: Size(double.maxFinite, 56.rh),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'Done',
        style: AppTextStyles.f16W500().copyWith(
          color: _white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ).paddingXY(X: 56.rw);
  }
}
