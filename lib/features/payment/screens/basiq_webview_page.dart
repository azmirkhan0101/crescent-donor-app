import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A WebView page for Basiq bank connection.
///
/// This page handles the bank linking process and automatically
/// returns to the previous screen when a success callback is detected.
class BasiqWebViewPage extends StatefulWidget {
  const BasiqWebViewPage({super.key, required this.url});

  final String url;

  @override
  State<BasiqWebViewPage> createState() => _BasiqWebViewPageState();
}

class _BasiqWebViewPageState extends State<BasiqWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
            _checkCallback(url);
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _checkCallback(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_checkCallback(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  /// Checks if the URL contains the success callback and closes the WebView if detected.
  bool _checkCallback(String url) {
    debugPrint('Basiq WebView URL: $url');

    // Check if the URL contains the specific callback
    if (url.contains("http://localhost:3000/callback")) {
      debugPrint('Success callback detected, closing WebView.');
      if (mounted) {
        Navigator.pop(context);
      }
      return true;
    }
    return false;
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
          onPressed: () => Navigator.pop(context),
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
}
