// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redcross/models/conversation.dart';
import 'package:redcross/models/message.dart';
import 'package:redcross/utils/api_endpoints.dart';
import 'package:redcross/utils/storage_service.dart';

class ChatApiService {
  static const String _chatwootBasePath = '/chatwoot';

  static Future<ConversationResponse> getConversations() async {
    try {
      final token = await StorageService.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}$_chatwootBasePath/conversations');
      
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        
        // Debug: Print the response to see its structure
        print('API Response: $jsonResponse');
        
        // Validate response structure
        if (jsonResponse is! Map<String, dynamic>) {
          throw Exception('Invalid response format: expected Map but got ${jsonResponse.runtimeType}');
        }
        
        return ConversationResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getConversations: $e');
      throw Exception('Error fetching conversations: $e');
    }
  }

  static Future<Map<String, dynamic>> sendMessage({
    required int conversationId,
    required String message,
  }) async {
    try {
      final token = await StorageService.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final url = Uri.parse(
        '${ApiEndpoints.baseUrl}$_chatwootBasePath/conversations/$conversationId/messages',
      );
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'content': message,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  static Future<Map<String, dynamic>> createConversation({
    required String message,
    String status = 'open',
  }) async {
    try {
      final token = await StorageService.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final url = Uri.parse('${ApiEndpoints.baseUrl}$_chatwootBasePath/conversations');
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'message': message,
          'status': status,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create conversation: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating conversation: $e');
    }
  }

  static Future<MessagesResponse> getMessages(int conversationId) async {
    try {
      final token = await StorageService.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final url = Uri.parse(
        '${ApiEndpoints.baseUrl}$_chatwootBasePath/conversations/$conversationId/messages',
      );
      
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return MessagesResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching messages: $e');
    }
  }
}
