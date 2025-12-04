class ConversationSender {
  final Map<String, dynamic> additionalAttributes;
  final String availabilityStatus;
  final String email;
  final int id;
  final String name;
  final String phoneNumber;
  final bool blocked;
  final String? identifier;
  final String thumbnail;
  final Map<String, dynamic> customAttributes;
  final int createdAt;

  ConversationSender({
    required this.additionalAttributes,
    required this.availabilityStatus,
    required this.email,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.blocked,
    this.identifier,
    required this.thumbnail,
    required this.customAttributes,
    required this.createdAt,
  });

  factory ConversationSender.fromJson(Map<String, dynamic> json) {
    return ConversationSender(
      additionalAttributes: json['additional_attributes'] ?? {},
      availabilityStatus: json['availability_status'] ?? 'offline',
      email: json['email'] ?? '',
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      blocked: json['blocked'] ?? false,
      identifier: json['identifier'],
      thumbnail: json['thumbnail'] ?? '',
      customAttributes: json['custom_attributes'] ?? {},
      createdAt: json['created_at'] ?? 0,
    );
  }
}

class ConversationMeta {
  final ConversationSender sender;
  final String channel;
  final bool hmacVerified;

  ConversationMeta({
    required this.sender,
    required this.channel,
    required this.hmacVerified,
  });

  factory ConversationMeta.fromJson(Map<String, dynamic> json) {
    return ConversationMeta(
      sender: ConversationSender.fromJson(json['sender'] ?? {}),
      channel: json['channel'] ?? '',
      hmacVerified: json['hmac_verified'] ?? false,
    );
  }
}

class Conversation {
  final ConversationMeta meta;
  final int id;
  final List<dynamic> messages;
  final int accountId;
  final String uuid;
  final Map<String, dynamic> additionalAttributes;
  final int agentLastSeenAt;
  final int assigneeLastSeenAt;
  final bool canReply;
  final int contactLastSeenAt;
  final Map<String, dynamic> customAttributes;
  final int inboxId;
  final List<dynamic> labels;
  final bool muted;
  final dynamic snoozedUntil;
  final String status;
  final int createdAt;
  final double updatedAt;
  final int timestamp;
  final int firstReplyCreatedAt;
  final int unreadCount;
  final dynamic lastNonActivityMessage;
  final int lastActivityAt;
  final dynamic priority;
  final int waitingSince;
  final dynamic slaPolicyId;

  Conversation({
    required this.meta,
    required this.id,
    required this.messages,
    required this.accountId,
    required this.uuid,
    required this.additionalAttributes,
    required this.agentLastSeenAt,
    required this.assigneeLastSeenAt,
    required this.canReply,
    required this.contactLastSeenAt,
    required this.customAttributes,
    required this.inboxId,
    required this.labels,
    required this.muted,
    this.snoozedUntil,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.timestamp,
    required this.firstReplyCreatedAt,
    required this.unreadCount,
    this.lastNonActivityMessage,
    required this.lastActivityAt,
    this.priority,
    required this.waitingSince,
    this.slaPolicyId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      meta: ConversationMeta.fromJson(json['meta'] ?? {}),
      id: json['id'] ?? 0,
      messages: json['messages'] ?? [],
      accountId: json['account_id'] ?? 0,
      uuid: json['uuid'] ?? '',
      additionalAttributes: json['additional_attributes'] ?? {},
      agentLastSeenAt: json['agent_last_seen_at'] ?? 0,
      assigneeLastSeenAt: json['assignee_last_seen_at'] ?? 0,
      canReply: json['can_reply'] ?? true,
      contactLastSeenAt: json['contact_last_seen_at'] ?? 0,
      customAttributes: json['custom_attributes'] ?? {},
      inboxId: json['inbox_id'] ?? 0,
      labels: json['labels'] ?? [],
      muted: json['muted'] ?? false,
      snoozedUntil: json['snoozed_until'],
      status: json['status'] ?? 'open',
      createdAt: json['created_at'] ?? 0,
      updatedAt: (json['updated_at'] ?? 0).toDouble(),
      timestamp: json['timestamp'] ?? 0,
      firstReplyCreatedAt: json['first_reply_created_at'] ?? 0,
      unreadCount: json['unread_count'] ?? 0,
      lastNonActivityMessage: json['last_non_activity_message'],
      lastActivityAt: json['last_activity_at'] ?? 0,
      priority: json['priority'],
      waitingSince: json['waiting_since'] ?? 0,
      slaPolicyId: json['sla_policy_id'],
    );
  }
}

class ConversationResponse {
  final bool success;
  final List<Conversation> conversations;
  final int count;
  final int currentPage;
  final int totalCount;

  ConversationResponse({
    required this.success,
    required this.conversations,
    required this.count,
    required this.currentPage,
    required this.totalCount,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final payload = data['payload'] ?? [];
    final meta = data['meta'] ?? {};

    return ConversationResponse(
      success: json['success'] ?? false,
      conversations: (payload as List)
          .map((item) => Conversation.fromJson(item))
          .toList(),
      count: meta['count'] ?? 0,
      currentPage: meta['current_page'] ?? 1,
      totalCount: meta['total_count'] ?? 0,
    );
  }
}
