import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/utils/api_endpoints.dart';
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
  String? _errorMessage;
  String? _chatwootBaseUrl;
  String? _websiteToken;

  @override
  void initState() {
    super.initState();
    _loadChatwootConfig();
  }

  Future<void> _loadChatwootConfig() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.config_chatwoot}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _chatwootBaseUrl = data['data']['base_url'];
          _websiteToken = data['data']['website_token'];
        });
        _initializeWebView();
      } else {
        setState(() {
          _errorMessage = 'Failed to load chat configuration';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading chat: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _initializeWebView() {
    if (_chatwootBaseUrl == null || _websiteToken == null) return;

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
        Uri.parse('$_chatwootBaseUrl/widget?website_token=$_websiteToken'),
      );
  }



  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
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
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorMessage = null;
                    _isLoading = true;
                  });
                  _loadChatwootConfig();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_chatwootBaseUrl == null || _websiteToken == null) {
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
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
