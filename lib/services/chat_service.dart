import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/utils/api_endpoints.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  WebViewController? _controller;
  String? _chatwootBaseUrl;
  String? _websiteToken;
  bool _isInitialized = false;
  bool _isLoading = false;

  WebViewController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    if (_isInitialized || _isLoading) return;

    _isLoading = true;

    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/${ApiEndpoints.authEndpoints.config_chatwoot}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _chatwootBaseUrl = data['data']['base_url'];
        _websiteToken = data['data']['website_token'];
        
        _createWebViewController();
        _isInitialized = true;
      } else {
        throw Exception('Failed to load chat configuration');
      }
    } catch (e) {
      _isLoading = false;
      rethrow;
    }

    _isLoading = false;
  }

  void _createWebViewController() {
    if (_chatwootBaseUrl == null || _websiteToken == null) return;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..loadRequest(
        Uri.parse('$_chatwootBaseUrl/widget?website_token=$_websiteToken'),
      );
  }

  void reset() {
    _controller = null;
    _isInitialized = false;
    _isLoading = false;
    _chatwootBaseUrl = null;
    _websiteToken = null;
  }
}
