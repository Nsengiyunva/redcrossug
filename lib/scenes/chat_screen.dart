// import 'package:flutter/material.dart';
// import 'package:redcross/scenes/chat_service.dart';

// class Chat extends StatefulWidget {
//   const Chat({super.key});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// // ChatMessage model
// class ChatMessage {
//   final String text;
//   final bool isUser;
//   final DateTime timestamp;

//   ChatMessage({
//     required this.text,
//     required this.isUser,
//     required this.timestamp,
//   });
// }

// class _ChatScreenState extends State<Chat> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final List<ChatMessage> messages = [];

//   late ChatService chatService;

//   @override
//   void initState() {
//     super.initState();

//     chatService = ChatService(
//       baseUrl: 'https://app.chatwoot.com',
//       inboxIdentifier: '',
//       authToken: 'A8gHzuZToLDXuv4LMS16gBry',
//     );

//     // Listen to incoming messages
//     chatService.initWebSocket((data) {
//       setState(() {
//         messages.add(ChatMessage(
//           text: data['content'] ?? '',
//           isUser: false,
//           timestamp: DateTime.now(),
//         ));
//       });
//       _scrollToBottom();
//     });
//   }

//   void _sendMessage() async {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     setState(() {
//       messages.add(ChatMessage(
//         text: text,
//         isUser: true,
//         timestamp: DateTime.now(),
//       ));
//     });

//     try {
//       await chatService.sendMessage(text);
//     } catch (e) {
//       debugPrint('Failed to send message: $e');
//     }

//     _messageController.clear();
//     _scrollToBottom();
//   }

//   void _scrollToBottom() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     chatService.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Minimal UI for demonstration
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return Align(
//                   alignment: message.isUser
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: message.isUser ? Colors.red : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       message.text,
//                       style: TextStyle(
//                         color: message.isUser ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SafeArea(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       hintText: 'Type a message...',
//                       contentPadding: EdgeInsets.all(12),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _sendMessage,
//                   color: Colors.red,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'chat_service.dart';

// ChatMessage model
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> messages = [];

  late ChatService chatService;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();

    chatService = ChatService(
      baseUrl: 'https://app.chatwoot.com',
      websiteToken: 'tHUXNzLajC8bqMSRfmmTxiFy',
      inboxIdentifier: "86416",
    );

    chatService.initWebSocket((data) {
      setState(() {
        messages.add(ChatMessage(
          text: data['content'] ?? '',
          isUser: false,
          timestamp: DateTime.now(),
        ));
        isTyping = false; // Stop typing indicator when a message arrives
      });
      _scrollToBottom();
    });
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      isTyping = true; // Optional: show typing until response comes
    });

    try {
      await chatService.sendMessage(text);
    } catch (e) {
      debugPrint('Failed to send message: $e');
      setState(() {
        isTyping = false;
      });
    }

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    chatService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (isTyping && index == messages.length) {
                  // Typing indicator bubble
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Agent is typing...',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  );
                }

                final message = messages[index];
                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: message.isUser ? Colors.red : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: message.isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(
                            color:
                                message.isUser ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTimestamp(message.timestamp),
                          style: TextStyle(
                            fontSize: 10,
                            color: message.isUser
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      contentPadding: EdgeInsets.all(12),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final hours = timestamp.hour.toString().padLeft(2, '0');
    final minutes = timestamp.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
