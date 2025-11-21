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

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      status: json['status'] ?? '',
      statusLabel: json['status_label'] ?? json['status'] ?? '',
      previousStatusLabel:
          json['previous_status_label'] ?? json['previous_status'],
      comments: json['comments'] ?? '',
      timeSinceChange: json['time_since_change'] ?? '',
      changedBy: json['changed_by'] != null
          ? IncidentUser.fromJson(json['changed_by'])
          : IncidentUser(
              id: 0,
              name: 'Unknown',
              email: '',
              phoneNo: '',
            ),
    );
  }
}
