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
}
