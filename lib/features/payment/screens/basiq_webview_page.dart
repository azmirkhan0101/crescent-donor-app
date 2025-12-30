import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_round_up_bank_connection_controller.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/get_basiq_connections_controller.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/save_basiq_connection_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BasiqWebViewPage extends StatefulWidget {
  const BasiqWebViewPage({super.key, required this.url});

  final String url;

  @override
  State<BasiqWebViewPage> createState() => _BasiqWebViewPageState();
}

class _BasiqWebViewPageState extends State<BasiqWebViewPage> {
  final getBasiqConnectionsController =
      Get.find<GetBasiqConnectionsController>();
  final saveBasiqConnectionController =
      Get.find<SaveBasiqConnectionController>();
  final connectedBankAccountsController = Get.find<GetRoundUpBankConnection>();
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isSuccessHandled = false;

  @override
  void initState() {
    super.initState();
    print('Basiq WebView URL: ${widget.url}');
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'BasiqChannel',
        onMessageReceived: (JavaScriptMessage message) async {
          debugPrint('Basiq JS Message: ${message.message}');
          if (message.message.contains('success') ||
              message.message.contains('complete') ||
              message.message.contains('connected')) {
            debugPrint('Success detected via JS Message');

            if (mounted && !_isSuccessHandled) {
              _isSuccessHandled = true;
              await _getBasiqConnections();
              if (mounted) {
                GoRouter.of(context).pop();
              }
            }
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar if needed
          },
          onPageStarted: (String url) {
            debugPrint('WebView started loading: $url');
            setState(() {
              _isLoading = true;
            });
            _handleNavigation(url);
          },
          onPageFinished: (String url) async {
            debugPrint('WebView finished loading: $url');
            setState(() {
              _isLoading = false;
            });
            _handleNavigation(url);

            // Inject JS to periodically check title and post it to BasiqChannel
            // This handles SPA transitions that don't trigger onPageFinished
            await _controller.runJavaScript('''
              (function() {
                setInterval(function() {
                  var title = document.title.toLowerCase();
                  if (title.indexOf('success') !== -1 || 
                      title.indexOf('complete') !== -1 || 
                      title.indexOf('connected') !== -1) {
                    BasiqChannel.postMessage('title:' + document.title);
                  }
                }, 1000);
              })();
            ''');

            // Initial check
            try {
              final title = await _controller.getTitle();
              debugPrint('WebView title: $title');
              if (title != null &&
                  (title.toLowerCase().contains('success') ||
                      title.toLowerCase().contains('complete') ||
                      title.toLowerCase().contains('connected'))) {
                debugPrint('Success detected via Title: $title');
                if (mounted && !_isSuccessHandled) {
                  _isSuccessHandled = true;
                  await _getBasiqConnections();
                  if (mounted) {
                    GoRouter.of(context).pop();
                  }
                }
              }
            } catch (e) {
              debugPrint('Error getting title: $e');
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('Navigation request to: ${request.url}');
            if (_shouldHandleSuccess(request.url)) {
              debugPrint(
                'Success detected in navigation request: ${request.url}',
              );
              if (mounted && !_isSuccessHandled) {
                _isSuccessHandled = true;
                _getBasiqConnections().then((_) {
                  if (mounted) GoRouter.of(context).pop();
                });
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  bool _shouldHandleSuccess(String url) {
    final lowerUrl = url.toLowerCase();
    return lowerUrl.contains('success') ||
        lowerUrl.contains('complete') ||
        lowerUrl.contains('finished') ||
        lowerUrl.contains('basiq-callback') ||
        lowerUrl.contains('done') ||
        lowerUrl.contains('exit') ||
        lowerUrl.contains('congratulations') ||
        lowerUrl.contains('thank-you');
  }

  void _handleNavigation(String url) {
    if (_shouldHandleSuccess(url)) {
      debugPrint('Success detected in page load: $url');
      if (mounted && !_isSuccessHandled) {
        _isSuccessHandled = true;
        _getBasiqConnections().then((_) {
          if (mounted) GoRouter.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Basiq Account'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async {
            if (!_isSuccessHandled) {
              _isSuccessHandled = true;
              await _getBasiqConnections();
            }
            if (mounted) GoRouter.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Future<void> _getBasiqConnections() async {
    bool isSuccess = await getBasiqConnectionsController.fetchConnections();
    if (isSuccess && getBasiqConnectionsController.connections.isNotEmpty) {
      if (!mounted) return;

      // show a modal bottom sheet with list of connections
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.rw)),
        ),
        builder: (sheetContext) {
          return Container(
            padding: EdgeInsets.fromLTRB(16.rw, 16.rh, 16.rw, 32.rh),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.rw,
                  height: 4.rh,
                  margin: EdgeInsets.only(bottom: 20.rh),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.rw),
                  ),
                ),
                Text(
                  'Select Bank Account',
                  style: TextStyle(
                    fontSize: 18.rfs,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.rh),
                Text(
                  'Choose an account to link for round-ups',
                  style: TextStyle(fontSize: 14.rfs, color: Colors.grey[600]),
                ),
                SizedBox(height: 24.rh),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(sheetContext).size.height * 0.6,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: getBasiqConnectionsController.connections.length,
                    separatorBuilder: (context, index) =>
                        Divider(height: 1.rh, color: Colors.grey[100]),
                    itemBuilder: (context, index) {
                      final connection =
                          getBasiqConnectionsController.connections[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.rh,
                          horizontal: 4.rw,
                        ),
                        leading: Container(
                          width: 44.rw,
                          height: 44.rw,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F7FF),
                            borderRadius: BorderRadius.circular(12.rw),
                          ),
                          child: Icon(
                            Icons.account_balance,
                            color: const Color(0xFF0066FF),
                            size: 24.rw,
                          ),
                        ),
                        title: Text(
                          connection.accountName,
                          style: TextStyle(
                            fontSize: 16.rfs,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          connection.institutionName,
                          style: TextStyle(fontSize: 13.rfs),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          size: 20.rw,
                          color: Colors.grey,
                        ),
                        onTap: () async {
                          // save connection id to shared preferences
                          bool isSaveSuccess =
                              await saveBasiqConnectionController
                                  .saveConnection(connection);
                          if (isSaveSuccess) {
                            connectedBankAccountsController
                                .fetchRoundUpBankConnection();
                            ToastMsg.success('Connection saved successfully');
                            if (context.mounted) Navigator.pop(sheetContext);
                          } else {
                            ToastMsg.error('Failed to save connection');
                            if (context.mounted) Navigator.pop(sheetContext);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else if (isSuccess && getBasiqConnectionsController.connections.isEmpty) {
      ToastMsg.info('No accounts found to connect.');
    }
  }
}
