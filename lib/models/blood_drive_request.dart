import 'package:redcross/models/blood_user.dart';

class BloodDriveRequest {
  final int id;
  final int userId;
  final String organizationName;
  final int expectedDonors;
  final String district;
  final String location;
  final String contactPerson;
  final String contactNumber;
  final String contactEmail;
  final bool hasTents;
  final bool hasPublicAddress;
  final bool hasChairs;
  final bool hasTables;
  final String status;
  final DateTime requestedDate;
  final String? additionalNotes;
  final String? adminNotes;
  final String? cancellationReason;
  final DateTime? cancelledAt;
  final DateTime? reviewedAt;
  final BloodUser? reviewedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BloodUser user;

  BloodDriveRequest({
    required this.id,
    required this.userId,
    required this.organizationName,
    required this.expectedDonors,
    required this.district,
    required this.location,
    required this.contactPerson,
    required this.contactNumber,
    required this.contactEmail,
    required this.hasTents,
    required this.hasPublicAddress,
    required this.hasChairs,
    required this.hasTables,
    required this.status,
    required this.requestedDate,
    this.additionalNotes,
    this.adminNotes,
    this.cancellationReason,
    this.cancelledAt,
    this.reviewedAt,
    this.reviewedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory BloodDriveRequest.fromJson(Map<String, dynamic> json) {
    return BloodDriveRequest(
      id: json['id'],
      userId: json['user_id'],
      organizationName: json['organization_name'],
      expectedDonors: json['expected_donors'],
      district: json['district'],
      location: json['location'],
      contactPerson: json['contact_person'],
      contactNumber: json['contact_number'],
      contactEmail: json['contact_email'],
      hasTents: json['has_tents'],
      hasPublicAddress: json['has_public_address'],
      hasChairs: json['has_chairs'],
      hasTables: json['has_tables'],
      status: json['status'],
      requestedDate: DateTime.parse(json['requested_date']),
      additionalNotes: json['additional_notes'],
      adminNotes: json['admin_notes'],
      cancellationReason: json['cancellation_reason'],
      cancelledAt: json['cancelled_at'] != null
          ? DateTime.parse(json['cancelled_at'])
          : null,
      reviewedAt: json['reviewed_at'] != null
          ? DateTime.parse(json['reviewed_at'])
          : null,
      reviewedBy: json['reviewed_by'] != null
          ? BloodUser.fromJson(json['reviewed_by'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: BloodUser.fromJson(json['user']),
    );
  }
}
