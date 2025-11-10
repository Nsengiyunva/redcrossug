import 'package:flutter/material.dart';

class Appointments extends StatelessWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appointments = [
      {
        "id": 2,
        "donor_name": "Joe Biden",
        "location": "Palm Courts, Plot 7A Lugogo By-Pass, Kampala",
        "phone_number": "+256751830778",
        "preferred_donation_date": "2025-10-31",
        "status": "completed",
        "status_label": "Completed",
        "status_color": "success",
        "notes":
            "Regular donor, AB+ blood type. Last donation was 3 months ago.",
        "preferred_blood_bank": {
          "name": "Gulu Regional Blood Bank",
          "district": "Gulu",
        },
      },
      {
        "id": 3,
        "donor_name": "Karen Becks",
        "location": "Palm Courts, Plot 7A Lugogo By-Pass, Kampala",
        "phone_number": "+256751830778",
        "preferred_donation_date": "2025-10-31",
        "status": "pending",
        "status_label": "Pending",
        "status_color": "pending",
        "notes":
            "Regular donor, AB+ blood type. Last donation was 3 months ago.",
        "preferred_blood_bank": {
          "name": "Gulu Regional Blood Bank",
          "district": "Gulu",
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          final statusColor = _getStatusColor(appointment['status_color']);

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.redAccent),
                      const SizedBox(width: 8),
                      Text(
                        appointment['donor_name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          appointment['status_label'],
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '📍 ${appointment['location']}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  Text('🏥 ${appointment['preferred_blood_bank']['name']}'),
                  const SizedBox(height: 8),
                  Text(
                    '🗓 Date: ${appointment['preferred_donation_date']}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '🩸 Notes: ${appointment['notes']}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String statusColor) {
    switch (statusColor) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'danger':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
