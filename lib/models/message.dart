class MessageSender {
  final int id;
  final String name;
  final String availableName;
  final String avatarUrl;
  final String type;
  final String availabilityStatus;
  final String thumbnail;

  MessageSender({
    required this.id,
    required this.name,
    required this.availableName,
    required this.avatarUrl,
    required this.type,
    required this.availabilityStatus,
    required this.thumbnail,
  });

  factory MessageSender.fromJson(Map<String, dynamic> json) {
    return MessageSender(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      availableName: json['available_name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      type: json['type'] ?? '',
      availabilityStatus: json['availability_status'] ?? 'offline',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

class ChatMessage {
  final int id;
  final String content;
  final int inboxId;
  final int conversationId;
  final int messageType;
  final String contentType;
  final String status;
  final dynamic contentAttributes;
  final int createdAt;
  final bool private;
  final String? sourceId;
  final MessageSender? sender;

  ChatMessage({
    required this.id,
    required this.content,
    required this.inboxId,
    required this.conversationId,
    required this.messageType,
    required this.contentType,
    required this.status,
    required this.contentAttributes,
    required this.createdAt,
    required this.private,
    this.sourceId,
    this.sender,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      inboxId: json['inbox_id'] ?? 0,
      conversationId: json['conversation_id'] ?? 0,
      messageType: json['message_type'] ?? 0,
      contentType: json['content_type'] ?? 'text',
      status: json['status'] ?? '',
      contentAttributes: json['content_attributes'],
      createdAt: json['created_at'] ?? 0,
      private: json['private'] ?? false,
      sourceId: json['source_id'],
      sender: json['sender'] != null 
          ? MessageSender.fromJson(json['sender'])
          : null,
    );
  }

  bool get isUserMessage => sender?.type == 'user';
  bool get isActivityMessage => messageType == 2;
}

class MessagesResponse {
  final bool success;
  final List<ChatMessage> messages;
  final MessageSender? assignee;
  final dynamic contact;

  MessagesResponse({
    required this.success,
    required this.messages,
    this.assignee,
    this.contact,
  });

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final payload = data['payload'] ?? [];
    final meta = data['meta'] ?? {};

    return MessagesResponse(
      success: json['success'] ?? false,
      messages: (payload as List)
          .map((item) => ChatMessage.fromJson(item))
          .toList(),
      assignee: meta['assignee'] != null 
          ? MessageSender.fromJson(meta['assignee'])
          : null,
      contact: meta['contact'],
    );
  }
}
