// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/models/conversation.dart';
import 'package:redcross/scenes/chat/chat_screen.dart';
import 'package:redcross/services/chat_api_service.dart';
import 'package:redcross/utils/colors.dart';

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({super.key});

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  bool _isLoading = true;
  List<Conversation> _conversations = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ChatApiService.getConversations();
      setState(() {
        _conversations = response.conversations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _showCreateConversationDialog() async {
    final messageController = TextEditingController();
    
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Start New Conversation',
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your initial message:',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: messageController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Type your message here...',
                  hintStyle: const TextStyle(fontFamily: "Inter"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primaryRedColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: "Inter",
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final message = messageController.text.trim();
                if (message.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a message'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }
                
                Navigator.pop(context);
                
                try {
                  await ChatApiService.createConversation(message: message);
                  _loadConversations();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Conversation created successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to create conversation: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRedColor,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Start Chat',
                style: TextStyle(fontFamily: "Inter"),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('MMM dd').format(dateTime);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'resolved':
        return Colors.blue;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryRedColor,
        title: const Text(
          'Conversations',
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
            icon: const Icon(Icons.add_comment, color: Colors.white),
            onPressed: _showCreateConversationDialog,
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadConversations,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryRedColor),
            ),
            SizedBox(height: 16),
            Text(
              'Loading conversations...',
              style: TextStyle(
                fontFamily: "Inter",
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading conversations',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Inter",
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadConversations,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRedColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_conversations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No conversations yet',
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a new conversation to get help',
              style: TextStyle(
                fontFamily: "Inter",
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showCreateConversationDialog,
              icon: const Icon(Icons.add),
              label: const Text('Start Conversation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRedColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primaryRedColor,
      onRefresh: _loadConversations,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          final conversation = _conversations[index];
          return _buildConversationCard(conversation);
        },
      ),
    );
  }

  Widget _buildConversationCard(Conversation conversation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(conversation: conversation),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryRedColor,
                    child: Text(
                      conversation.meta.sender.name.isNotEmpty
                          ? conversation.meta.sender.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          conversation.meta.sender.name,
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          conversation.meta.sender.email,
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatTimestamp(conversation.lastActivityAt),
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      if (conversation.unreadCount > 0) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryRedColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${conversation.unreadCount}',
                            style: const TextStyle(
                              fontFamily: "Inter",
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Last message preview
              if (conversation.messages.isNotEmpty) ...[
                Text(
                  conversation.messages.last.processedMessageContent,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
              ],
              // Metadata row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(conversation.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _getStatusColor(conversation.status),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: _getStatusColor(conversation.status),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          conversation.status.toUpperCase(),
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(conversation.status),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Assignee info
                  if (conversation.meta.assignee != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person,
                            size: 12,
                            color: Colors.blue[700],
                          ),
                          const SizedBox(width: 3),
                          Text(
                            conversation.meta.assignee!.name.split(' ').first,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 10,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  // Message count
                  if (conversation.messages.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 11,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${conversation.messages.length}',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  if (conversation.canReply)
                    Icon(
                      Icons.reply,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
