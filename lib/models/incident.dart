import 'package:redcross/models/incident_user.dart';
import 'package:redcross/models/media_file.dart';
import 'package:redcross/models/status_history.dart';

class Incident {
  final int id;
  final String title;
  final String description;
  final String incidentType;
  final String severityLevel;
  final String status;
  final String district;
  final String locationAddress;
  final String contactPhone;
  final double latitude;
  final double longitude;
  final String timeSinceReported;
  final DateTime createdAt;
  final bool isEmergency;
  final int priorityScore;
  final String? additionalNotes;
  final int? estimatedAffectedPeople;
  final int? estimatedCasualties;
  final List<MediaFile> media;
  final List<StatusHistory> statusHistory;
  final IncidentUser user;

  Incident({
    required this.id,
    required this.title,
    required this.description,
    required this.incidentType,
    required this.severityLevel,
    required this.status,
    required this.district,
    required this.locationAddress,
    required this.contactPhone,
    required this.latitude,
    required this.longitude,
    required this.timeSinceReported,
    required this.createdAt,
    required this.isEmergency,
    required this.priorityScore,
    this.additionalNotes,
    this.estimatedAffectedPeople,
    this.estimatedCasualties,
    required this.media,
    required this.statusHistory,
    required this.user,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    return Incident(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      incidentType: json['incident_type'] ?? '',
      severityLevel: json['severity_level'] ?? '',
      status: json['status'] ?? '',
      district: json['district'] ?? '',
      locationAddress: json['location_address'] ?? '',
      contactPhone: json['contact_phone'] ?? '',
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
      timeSinceReported: json['time_since_reported'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      isEmergency: json['is_emergency'] ?? false,
      priorityScore: json['priority_score'] ?? 0,
      additionalNotes: json['additional_notes'],
      estimatedAffectedPeople: json['estimated_affected_people'],
      estimatedCasualties: json['estimated_casualties'],
      media: json['media'] != null
          ? (json['media'] as List).map((m) => MediaFile.fromJson(m)).toList()
          : [],
      statusHistory: json['status_history'] != null
          ? (json['status_history'] as List)
              .map((e) => StatusHistory.fromJson(e))
              .toList()
          : [],
      user: json['user'] != null
          ? IncidentUser.fromJson(json['user'])
          : IncidentUser(
              id: json['user_id'] ?? 0,
              name: 'Reporter',
              email: '',
              phoneNo: '',
            ),
    );
  }
}
