class Bulletin {
  final int id;
  final String title;
  final String slug;
  final String body;
  final String? excerpt;
  final String? featuredImage;
  final BulletinCategory category;
  final BulletinSubtype? subtype;
  final int userId;
  final String? authorName;
  final bool isPublished;
  final DateTime? publishedAt;
  final String? status;
  final int viewCount;
  final String? seoTitle;
  final String? seoDescription;

  // Event fields
  final DateTime? eventStartDate;
  final DateTime? eventEndDate;
  final String? eventLocation;
  final String? eventDescription;
  final int? eventCapacity;
  final int? eventRegistered;

  // Request fields
  final DateTime? requestDeadline;
  final DateTime? applicationDeadline;
  final String? volunteerRequirements;

  // Contact fields
  final String? contactPerson;
  final String? contactPhone;
  final String? contactEmail;

  // Emergency fields
  final String? affectedArea;
  final String? severityLevel;
  final String? actionRequired;
  final String? coordinates;

  // Additional metadata
  final String? priority;
  final bool? requiresRegistration;
  final String? registrationUrl;
  final Map<String, dynamic>? customFields;

  // Relations
  final BulletinUser? user;
  final List<BulletinTag>? tags;

  Bulletin({
    required this.id,
    required this.title,
    required this.slug,
    required this.body,
    this.excerpt,
    this.featuredImage,
    required this.category,
    this.subtype,
    required this.userId,
    this.authorName,
    required this.isPublished,
    this.publishedAt,
    this.status,
    required this.viewCount,
    this.seoTitle,
    this.seoDescription,
    this.eventStartDate,
    this.eventEndDate,
    this.eventLocation,
    this.eventDescription,
    this.eventCapacity,
    this.eventRegistered,
    this.requestDeadline,
    this.applicationDeadline,
    this.volunteerRequirements,
    this.contactPerson,
    this.contactPhone,
    this.contactEmail,
    this.affectedArea,
    this.severityLevel,
    this.actionRequired,
    this.coordinates,
    this.priority,
    this.requiresRegistration,
    this.registrationUrl,
    this.customFields,
    this.user,
    this.tags,
  });

  factory Bulletin.fromJson(Map<String, dynamic> json) {
    return Bulletin(
      id: json['id'] as int,
      title: json['title'] as String,
      slug: json['slug'] as String,
      body: json['body'] as String,
      excerpt: json['excerpt'] as String?,
      featuredImage: json['featured_image'] as String?,
      category: BulletinCategory.fromString(json['category'] as String),
      subtype: json['subtype'] != null
          ? BulletinSubtype.fromString(json['subtype'] as String)
          : null,
      userId: json['user_id'] as int,
      authorName: json['author_name'] as String?,
      isPublished: json['is_published'] as bool? ?? false,
      publishedAt: json['published_at'] != null
          ? DateTime.parse(json['published_at'] as String)
          : null,
      status: json['status'] as String?,
      viewCount: json['view_count'] as int? ?? 0,
      seoTitle: json['seo_title'] as String?,
      seoDescription: json['seo_description'] as String?,
      eventStartDate: json['event_start_date'] != null
          ? DateTime.parse(json['event_start_date'] as String)
          : null,
      eventEndDate: json['event_end_date'] != null
          ? DateTime.parse(json['event_end_date'] as String)
          : null,
      eventLocation: json['event_location'] as String?,
      eventDescription: json['event_description'] as String?,
      eventCapacity: json['event_capacity'] as int?,
      eventRegistered: json['event_registered'] as int?,
      requestDeadline: json['request_deadline'] != null
          ? DateTime.parse(json['request_deadline'] as String)
          : null,
      applicationDeadline: json['application_deadline'] != null
          ? DateTime.parse(json['application_deadline'] as String)
          : null,
      volunteerRequirements: json['volunteer_requirements'] as String?,
      contactPerson: json['contact_person'] as String?,
      contactPhone: json['contact_phone'] as String?,
      contactEmail: json['contact_email'] as String?,
      affectedArea: json['affected_area'] as String?,
      severityLevel: json['severity_level'] as String?,
      actionRequired: json['action_required'] as String?,
      coordinates: json['coordinates'] as String?,
      priority: json['priority'] as String?,
      requiresRegistration: json['requires_registration'] as bool?,
      registrationUrl: json['registration_url'] as String?,
      customFields: json['custom_fields'] as Map<String, dynamic>?,
      user: json['user'] != null
          ? BulletinUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      tags: json['tags'] != null
          ? (json['tags'] as List)
              .map((tag) => BulletinTag.fromJson(tag as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'body': body,
      'excerpt': excerpt,
      'featured_image': featuredImage,
      'category': category.value,
      'subtype': subtype?.value,
      'user_id': userId,
      'author_name': authorName,
      'is_published': isPublished,
      'published_at': publishedAt?.toIso8601String(),
      'status': status,
      'view_count': viewCount,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'event_start_date': eventStartDate?.toIso8601String(),
      'event_end_date': eventEndDate?.toIso8601String(),
      'event_location': eventLocation,
      'event_description': eventDescription,
      'event_capacity': eventCapacity,
      'event_registered': eventRegistered,
      'request_deadline': requestDeadline?.toIso8601String(),
      'application_deadline': applicationDeadline?.toIso8601String(),
      'volunteer_requirements': volunteerRequirements,
      'contact_person': contactPerson,
      'contact_phone': contactPhone,
      'contact_email': contactEmail,
      'affected_area': affectedArea,
      'severity_level': severityLevel,
      'action_required': actionRequired,
      'coordinates': coordinates,
      'priority': priority,
      'requires_registration': requiresRegistration,
      'registration_url': registrationUrl,
      'custom_fields': customFields,
      'user': user?.toJson(),
      'tags': tags?.map((tag) => tag.toJson()).toList(),
    };
  }
}

// Bulletin Category Enum
enum BulletinCategory {
  bloodDonation('blood_donation', 'Blood Donation'),
  disasterManagement('disaster_management', 'Disaster Management'),
  firstAid('first_aid', 'First Aid');

  final String value;
  final String label;

  const BulletinCategory(this.value, this.label);

  static BulletinCategory fromString(String value) {
    return BulletinCategory.values.firstWhere(
      (category) => category.value == value,
      orElse: () => BulletinCategory.bloodDonation,
    );
  }
}

// Bulletin Subtype Enum
enum BulletinSubtype {
  // General Communication
  notice('notice', 'Simple Notice', 'normal'),
  announcement('announcement', 'General Announcement', 'normal'),
  alert('alert', 'Alert', 'high'),
  update('update', 'Update', 'normal'),

  // Events & Activities
  event('event', 'Event', 'medium'),
  campaign('campaign', 'Campaign', 'medium'),
  training('training', 'Training', 'medium'),

  // Requests & Appeals
  urgentRequest('urgent_request', 'Urgent Request', 'critical'),
  volunteerCall('volunteer_call', 'Volunteer Call', 'medium'),
  donationAppeal('donation_appeal', 'Donation Appeal', 'medium'),

  // Emergencies & Disasters
  emergencyAlert('emergency_alert', 'Emergency Alert', 'critical'),
  safetyAdvisory('safety_advisory', 'Safety Advisory', 'high'),
  disasterUpdate('disaster_update', 'Disaster Update', 'high'),

  // Health & Medical
  healthTip('health_tip', 'Health Tip', 'normal'),
  medicalNotice('medical_notice', 'Medical Notice', 'normal'),
  bloodShortage('blood_shortage', 'Blood Shortage Alert', 'critical'),

  // Administrative
  policyUpdate('policy_update', 'Policy Update', 'normal'),
  serviceNotice('service_notice', 'Service Notice', 'normal'),
  report('report', 'Report', 'normal');

  final String value;
  final String label;
  final String priority;

  const BulletinSubtype(this.value, this.label, this.priority);

  static BulletinSubtype fromString(String value) {
    return BulletinSubtype.values.firstWhere(
      (subtype) => subtype.value == value,
      orElse: () => BulletinSubtype.notice,
    );
  }

  // Check if subtype has date fields
  bool get hasDateFields {
    return [
      BulletinSubtype.event,
      BulletinSubtype.campaign,
      BulletinSubtype.training,
      BulletinSubtype.urgentRequest,
      BulletinSubtype.volunteerCall,
      BulletinSubtype.bloodShortage,
    ].contains(this);
  }

  // Check if subtype has location field
  bool get hasLocationField {
    return [
      BulletinSubtype.event,
      BulletinSubtype.campaign,
      BulletinSubtype.training,
      BulletinSubtype.emergencyAlert,
      BulletinSubtype.disasterUpdate,
    ].contains(this);
  }

  // Check if subtype has contact fields
  bool get hasContactFields {
    return [
      BulletinSubtype.urgentRequest,
      BulletinSubtype.volunteerCall,
      BulletinSubtype.donationAppeal,
      BulletinSubtype.event,
      BulletinSubtype.campaign,
      BulletinSubtype.training,
    ].contains(this);
  }
}

// Bulletin User (author)
class BulletinUser {
  final int id;
  final String name;
  final String? email;

  BulletinUser({
    required this.id,
    required this.name,
    this.email,
  });

  factory BulletinUser.fromJson(Map<String, dynamic> json) {
    return BulletinUser(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

// Bulletin Tag
class BulletinTag {
  final int id;
  final String name;
  final String slug;

  BulletinTag({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory BulletinTag.fromJson(Map<String, dynamic> json) {
    return BulletinTag(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}
