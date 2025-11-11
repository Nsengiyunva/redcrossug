import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/models/appointment.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<Appointment> appointments = [];
  bool isLoading = true;
  String selectedFilter =
      'all'; // all, pending, confirmed, completed, cancelled

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() {
    // Simulating API call - replace with actual API call
    final sampleData = {
      "success": true,
      "message": "Appointments retrieved successfully",
      "data": {
        "appointments": [
          {
            "id": 2,
            "blood_donor_id": 1,
            "donor_name": "Joe Biden",
            "location": "Palm Courts, Plot 7A Lugogo By-Pass, Kampala",
            "phone_number": "+256751830778",
            "last_donation_date": "2024-01-31T21:00:00.000000Z",
            "preferred_blood_bank_id": 2,
            "preferred_donation_date": "2025-10-31T21:00:00.000000Z",
            "status": "completed",
            "time_preference": "Afternoon",
            "preferred_time": "14:00:00",
            "reminder_sent_at": null,
            "confirmed_at": null,
            "completed_at": null,
            "notes":
                "Regular donor, AB+ blood type. Last donation was 3 months ago.",
            "cancellation_reason": null,
            "created_by": 1,
            "created_at": "2025-10-30T19:39:29.000000Z",
            "updated_at": "2025-10-30T19:43:43.000000Z",
            "status_label": "Completed",
            "status_color": "success",
            "can_be_modified": false,
            "can_be_cancelled": false,
            "is_overdue": false,
            "days_until_appointment": -9,
            "preferred_blood_bank": {
              "id": 2,
              "name": "Gulu Regional Blood Bank",
              "district": "Gulu",
              "address": "Gulu Regional Referral Hospital",
              "phone": "+256-471-432059",
              "fax": null,
              "email": null,
              "po_box": null,
              "latitude": "2.77777800",
              "longitude": "32.29777800",
              "affiliated_hospital": "Gulu Regional Referral Hospital",
              "google_place_id": "ChIJ34m2mNfB_RwR4t18gB10B10",
              "is_active": true,
              "created_at": "2025-10-30T18:04:17.000000Z",
              "updated_at": "2025-10-30T18:04:17.000000Z",
              "coordinates": {"lat": 2.777778, "lng": 32.297778}
            }
          },
          {
            "id": 3,
            "blood_donor_id": 1,
            "donor_name": "Joe Biden",
            "location": "Palm Courts, Plot 7A Lugogo By-Pass, Kampala",
            "phone_number": "+256751830778",
            "last_donation_date": "2024-01-31T21:00:00.000000Z",
            "preferred_blood_bank_id": 1,
            "preferred_donation_date": "2025-11-15T21:00:00.000000Z",
            "status": "pending",
            "time_preference": "Morning",
            "preferred_time": "09:00:00",
            "reminder_sent_at": null,
            "confirmed_at": null,
            "completed_at": null,
            "notes": "First time donor",
            "cancellation_reason": null,
            "created_by": 1,
            "created_at": "2025-11-01T10:15:00.000000Z",
            "updated_at": "2025-11-01T10:15:00.000000Z",
            "status_label": "Pending",
            "status_color": "warning",
            "can_be_modified": true,
            "can_be_cancelled": true,
            "is_overdue": false,
            "days_until_appointment": 5,
            "preferred_blood_bank": {
              "id": 1,
              "name": "Nakaseero Blood Bank",
              "district": "Kampala",
              "address": "Uganda Blood Transfusion Service, Nakasero",
              "phone": "+256-414-346576",
              "email": "info@ubts.go.ug",
              "affiliated_hospital": "Uganda Blood Transfusion Service",
              "latitude": "0.31750000",
              "longitude": "32.58580000",
              "is_active": true,
              "coordinates": {"lat": 0.3175, "lng": 32.5858}
            }
          }
        ]
      }
    };

    setState(() {
      // appointments = (sampleData['data']!['appointments'] as List)
      //     .map((json) => Appointment.fromJson(json))
      //     .toList();
      isLoading = false;
    });
  }

  List<Appointment> get filteredAppointments {
    if (selectedFilter == 'all') {
      return appointments;
    }
    return appointments
        .where((apt) => apt.status.toLowerCase() == selectedFilter)
        .toList();
  }

  Color _getStatusColor(String statusColor) {
    switch (statusColor.toLowerCase()) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'danger':
        return Colors.red;
      case 'info':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showAppointmentDetails(Appointment appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAppointmentDetails(appointment),
    );
  }

  Widget _buildAppointmentDetails(Appointment appointment) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Appointment Details',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      _getStatusColor(appointment.statusColor).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  appointment.statusLabel,
                  style: TextStyle(
                    color: _getStatusColor(appointment.statusColor),
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),

          // Blood Bank Info
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_hospital, color: Colors.red, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.preferredBloodBank.name,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appointment.preferredBloodBank.district,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.025),

          // Appointment Details
          _buildDetailRow(
            Icons.calendar_today,
            'Date',
            DateFormat('EEEE, MMMM d, yyyy')
                .format(appointment.preferredDonationDate),
            screenWidth,
          ),
          SizedBox(height: screenHeight * 0.015),
          _buildDetailRow(
            Icons.access_time,
            'Time Preference',
            appointment.timePreference,
            screenWidth,
          ),
          if (appointment.notes != null) ...[
            SizedBox(height: screenHeight * 0.015),
            _buildDetailRow(
              Icons.notes,
              'Notes',
              appointment.notes!,
              screenWidth,
            ),
          ],
          SizedBox(height: screenHeight * 0.015),
          _buildDetailRow(
            Icons.phone,
            'Contact',
            appointment.preferredBloodBank.phone,
            screenWidth,
          ),
          SizedBox(height: screenHeight * 0.015),
          _buildDetailRow(
            Icons.location_on,
            'Address',
            appointment.preferredBloodBank.address,
            screenWidth,
          ),

          const Spacer(),

          // Action Buttons
          if (appointment.canBeCancelled) ...[
            Row(
              children: [
                if (appointment.canBeModified)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Modify appointment logic
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Modify appointment feature'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.018),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Modify',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (appointment.canBeModified)
                  SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showCancelDialog(appointment);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
          ],

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text(
          'Are you sure you want to cancel this appointment? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, Keep It'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close bottom sheet
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment cancelled successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              // API call to cancel appointment
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.red, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'My Appointments',
                style: TextStyle(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                '${appointments.length} appointment${appointments.length != 1 ? 's' : ''}',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: screenHeight * 0.025),

              // Filter Chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFilterChip('All', 'all', screenWidth),
                    const SizedBox(width: 8),
                    _buildFilterChip('Pending', 'pending', screenWidth),
                    const SizedBox(width: 8),
                    _buildFilterChip('Confirmed', 'confirmed', screenWidth),
                    const SizedBox(width: 8),
                    _buildFilterChip('Completed', 'completed', screenWidth),
                    const SizedBox(width: 8),
                    _buildFilterChip('Cancelled', 'cancelled', screenWidth),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.025),

              // Appointments List
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : filteredAppointments.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.event_busy,
                                  size: screenWidth * 0.2,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'No appointments found',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredAppointments.length,
                            itemBuilder: (context, index) {
                              final appointment = filteredAppointments[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: screenHeight * 0.015,
                                ),
                                child: _buildAppointmentCard(
                                    appointment, screenWidth, screenHeight),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, double screenWidth) {
    final isSelected = selectedFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: screenWidth * 0.035,
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(
      Appointment appointment, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () => _showAppointmentDetails(appointment),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    appointment.preferredBloodBank.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(appointment.statusColor)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    appointment.statusLabel,
                    style: TextStyle(
                      color: _getStatusColor(appointment.statusColor),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('MMM d, yyyy')
                      .format(appointment.preferredDonationDate),
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  size: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  appointment.timePreference,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.008),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    appointment.preferredBloodBank.district,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            if (appointment.daysUntilAppointment > 0 &&
                appointment.status.toLowerCase() == 'pending') ...[
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.info_outline,
                        size: 16, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text(
                      '${appointment.daysUntilAppointment} day${appointment.daysUntilAppointment != 1 ? 's' : ''} until appointment',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
