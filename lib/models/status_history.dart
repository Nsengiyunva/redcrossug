import 'package:redcross/models/incident_user.dart';

class StatusHistory {
  final String status;
  final String statusLabel;
  final String? previousStatusLabel;
  final String comments;
  final String timeSinceChange;
  final IncidentUser changedBy;

  StatusHistory({
    required this.status,
    required this.statusLabel,
    this.previousStatusLabel,
    required this.comments,
    required this.timeSinceChange,
    required this.changedBy,
  });
}
