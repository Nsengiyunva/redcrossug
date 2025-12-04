import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatWebView extends StatefulWidget {
  const ChatWebView({super.key});

  @override
  State<ChatWebView> createState() => _ChatWebViewState();
}

class _ChatWebViewState extends State<ChatWebView> {
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
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..setOnConsoleMessage((JavaScriptConsoleMessage message) {
        debugPrint('JS Console [${message.level.name}]: ${message.message}');
      })
      ..loadRequest(
        Uri.parse('https://app.chatwoot.com/widget?website_token=A8gHzuZToLDXuv4LMS16gBry'),
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryRedColor,
        title: const Text(
          'Chat Support',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: Colors.white,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryRedColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading chat...',
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
