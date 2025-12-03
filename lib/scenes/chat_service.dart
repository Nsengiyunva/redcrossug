// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatService {
  final String baseUrl;
  final String websiteToken;

  WebSocketChannel? _channel;
  int? conversationId;
  final int accountId = 143638;
  final String inboxIdentifier; // Usually 1 for hosted Chatwoot

  ChatService({
    required this.baseUrl,
    required this.websiteToken,
    required this.inboxIdentifier,
  });

  /// Initialize: create conversation and start listening
  Future<void> initWebSocket(
      void Function(Map<String, dynamic>) onMessage) async {
    // Step 1: Create conversation
    final conv = await _createConversation();
    conversationId = conv['id'];

    // Step 2: Connect to WebSocket
    final wsUrl = baseUrl.replaceFirst('https', 'wss') + '/cable';
    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    // Step 3: Subscribe to conversation channel
    final subscribeMessage = jsonEncode({
      "command": "subscribe",
      "identifier": jsonEncode({
        "channel": "ConversationChannel",
        "conversation_id": conversationId,
      }),
    });

    _channel!.sink.add(subscribeMessage);

    // Step 4: Listen for messages
    _channel!.stream.listen((event) {
      final data = jsonDecode(event);
      if (data['type'] == null && data['message'] != null) {
        onMessage(data['message']);
      }
    });
  }

  /// Send a message to the conversation
  Future<void> sendMessage(String message) async {
    if (conversationId == null) {
      throw Exception('Conversation not initialized');
    }

    final url = Uri.parse(
        '$baseUrl/api/v1/accounts/$accountId/conversations/$conversationId/messages');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'api_access_token': websiteToken,
      },
      body: jsonEncode({
        'content': message,
        'message_type': 1,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to send message: ${response.body}');
    }
  }

  /// Create conversation via website token
  Future<Map<String, dynamic>> _createConversation() async {
    print("base url $baseUrl");
    print("account id $accountId");

    final url = Uri.parse('$baseUrl/api/v1/accounts/$accountId/conversations');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'api_access_token': websiteToken,
      },
      body: jsonEncode({
        'source_id': 'flutter_app', // optional, your identifier
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create conversation: ${response.body}');
    }

    return jsonDecode(response.body)['data'];
  }

  void dispose() {
    _channel?.sink.close(status.normalClosure);
  }
}
