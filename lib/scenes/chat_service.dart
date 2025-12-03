import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatService {
  final String baseUrl;
  final String inboxIdentifier;
  final String authToken; // optional if your API requires it

  WebSocketChannel? _channel;

  ChatService({
    required this.baseUrl,
    required this.inboxIdentifier,
    this.authToken = '',
  });

  /// Initialize WebSocket to listen for incoming messages
  void initWebSocket(void Function(Map<String, dynamic>) onMessage) {
    final wsUrl = '$baseUrl/cable?access_token=$authToken';

    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    _channel!.stream.listen((event) {
      final data = jsonDecode(event);
      if (data['type'] == 'message_created') {
        onMessage(data['message']);
      }
    });
  }

  /// Send a message to Chatwoot via REST API
  Future<void> sendMessage(String message) async {
    final url = Uri.parse(
        '$baseUrl/api/v1/accounts/1/inboxes/$inboxIdentifier/conversations/messages');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'api_access_token': authToken,
      },
      body: jsonEncode({
        'content': message,
        'message_type': 1, // 1 = outgoing
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to send message: ${response.body}');
    }
  }

  void dispose() {
    _channel?.sink.close();
  }
}
