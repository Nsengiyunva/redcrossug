// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:redcross/models/incident.dart';
import 'package:redcross/utils/colors.dart';

class IncidentDetails extends StatelessWidget {
  final Incident report;

  const IncidentDetails({super.key, required this.report});

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'serious':
        return Colors.orange;
      case 'moderate':
        return Colors.yellow.shade700;
      case 'minor':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return Colors.blue;
      case 'in_progress':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Incident Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(report.severityLevel),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          report.severityLevel.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(report.status),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          report.status.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter"),
                        ),
                      ),
                      const Spacer(),
                      if (report.isEmergency)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.warning,
                                  color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text(
                                'EMERGENCY',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter"),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    report.title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter"),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        report.timeSinceReported,
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                            fontFamily: "Inter"),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Priority: ${report.priorityScore}',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 12,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'INCIDENT INFORMATION',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 0.5,
                        fontFamily: "Inter"),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Description', report.description),
                  const SizedBox(height: 16),
                  _buildInfoRow('Incident Type',
                      report.incidentType.replaceAll('_', ' ').toUpperCase()),
                  const SizedBox(height: 16),
                  _buildInfoRow('District', report.district),
                  const SizedBox(height: 16),
                  _buildInfoRow('Location', report.locationAddress),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                      'Coordinates', '${report.latitude}, ${report.longitude}'),
                  const SizedBox(height: 16),
                  _buildInfoRow('Contact Phone', report.contactPhone),
                  if (report.additionalNotes != null &&
                      report.additionalNotes!.isNotEmpty &&
                      report.additionalNotes != 'N/A') ...[
                    const SizedBox(height: 16),
                    _buildInfoRow('Additional Notes', report.additionalNotes!),
                  ],
                  if (report.estimatedAffectedPeople != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoRow(
                        'Affected People', '${report.estimatedAffectedPeople}'),
                  ],
                  if (report.estimatedCasualties != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoRow(
                        'Casualties', '${report.estimatedCasualties}'),
                  ],

                  const SizedBox(height: 32),
                  const Text(
                    'REPORTER INFORMATION',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Name', report.user.name),
                  const SizedBox(height: 16),
                  _buildInfoRow('Email', report.user.email),
                  const SizedBox(height: 16),
                  _buildInfoRow('Phone', report.user.phoneNo),
                  if (report.user.membershipId != null) ...[
                    const SizedBox(height: 16),
                    _buildInfoRow('Membership ID', report.user.membershipId!),
                  ],

                  // Media Section
                  if (report.media.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    const Text(
                      'MEDIA',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                          fontFamily: "Inter"),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: report.media.map((media) {
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              media.isImage ? Icons.image : Icons.videocam,
                              color: Colors.grey.shade600,
                              size: 40,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  // Status History
                  if (report.statusHistory.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    const Text(
                      'STATUS HISTORY',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                          fontFamily: "Inter"),
                    ),
                    const SizedBox(height: 16),
                    ...report.statusHistory.map((history) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(history.status)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    history.statusLabel,
                                    style: TextStyle(
                                        color: _getStatusColor(history.status),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter"),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  history.timeSinceChange,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                      fontFamily: "Inter"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              history.comments,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'By: ${history.changedBy.name}',
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                  fontFamily: "Inter"),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],

                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontFamily: "Inter"),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.4,
              fontFamily: "Inter"),
        ),
      ],
    );
  }
}
