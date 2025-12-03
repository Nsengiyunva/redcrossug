// ignore_for_file: unused_element, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:redcross/models/appointment.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

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

  Future<void> _loadAppointments() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = await StorageService.getToken();

      final response = await http.get(
        Uri.parse(
            'https://urcs-api.taufeeq.dev/api/blood-donation/appointments'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Requested-With": "XMLHttpRequest",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];

        final List apptList = data['appointments'] as List? ?? [];

        setState(() {
          appointments =
              apptList.map((json) => Appointment.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Network error, please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        // print(
        //     "Failed to fetch appointments. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch your blood donation appointments.'),
          backgroundColor: AppColors.primaryRedColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // print("Error fetching appointments: $e");
    }
  }

  List<Appointment> get filteredAppointments {
    if (selectedFilter == 'all') return appointments;

    return appointments
        .where((a) => a.status.toLowerCase() == selectedFilter)
        .toList();
  }

  Color _getStatusColor(String color) {
    switch (color.toLowerCase()) {
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
      builder: (c) => _buildAppointmentDetails(appointment),
    );
  }

  Widget _buildAppointmentDetails(Appointment appointment) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

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
                    overflow: TextOverflow.ellipsis, // prevents overflow
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        screenWidth * 0.02, // responsive horizontal padding
                    vertical:
                        screenHeight * 0.008, // responsive vertical padding
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(appointment.statusColor)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    appointment.statusLabel,
                    style: TextStyle(
                      color: _getStatusColor(appointment.statusColor),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035, // responsive font size
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // BANK
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_hospital, color: Colors.red),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.preferredBloodBank.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          appointment.preferredBloodBank.district,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildDetailRow(
                Icons.calendar_today,
                "Date",
                DateFormat('EEEE, MMM d yyyy')
                    .format(appointment.preferredDonationDate),
                screenWidth),

            const SizedBox(height: 12),

            _buildDetailRow(Icons.access_time, "Time Preference",
                appointment.timePreference, screenWidth),

            const SizedBox(height: 12),

            if (appointment.notes != null)
              _buildDetailRow(
                  Icons.notes, "Notes", appointment.notes ?? "", screenWidth),

            const SizedBox(height: 12),

            _buildDetailRow(Icons.phone, "Contact",
                appointment.preferredBloodBank.phone ?? "", screenWidth),

            const SizedBox(height: 12),

            _buildDetailRow(Icons.location_on, "Address",
                appointment.preferredBloodBank.address ?? "", screenWidth),

            const SizedBox(height: 25),

            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text("Close", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(Appointment appointment) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Cancel Appointment"),
        content:
            const Text("Are you sure you want to cancel this appointment?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Keep"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Appointment cancelled"),
                ),
              );
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.red, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.grey[600])),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.015),
            Text(
              "My Appointments",
              style: TextStyle(
                  fontSize: w * 0.08,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"),
            ),
            Text(
              "${appointments.length} appointment${appointments.length != 1 ? 's' : ''}",
              style: TextStyle(fontFamily: "Inter", color: Colors.grey[600]),
            ),
            SizedBox(height: h * 0.02),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip("All", "all"),
                  _buildFilterChip("Pending", "pending"),
                  _buildFilterChip("Confirmed", "confirmed"),
                  _buildFilterChip("Completed", "completed"),
                  _buildFilterChip("Cancelled", "cancelled"),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    )
                  : filteredAppointments.isEmpty
                      ? const Center(
                          child: Text("No appointments found"),
                        )
                      : ListView.builder(
                          itemCount: filteredAppointments.length,
                          itemBuilder: (c, i) => Padding(
                            padding: EdgeInsets.only(bottom: h * 0.015),
                            child: _buildAppointmentCard(
                                filteredAppointments[i], w, h),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final bool selected = selectedFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.red : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selected ? Colors.red : Colors.grey),
          ),
          child: Text(
            label,
            style: TextStyle(color: selected ? Colors.white : Colors.grey[700]),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment, double w, double h) {
    return GestureDetector(
      onTap: () => _showAppointmentDetails(appointment),
      child: Container(
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with blood bank name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    appointment.preferredBloodBank.name,
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(appointment.statusColor)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    appointment.statusLabel,
                    style: TextStyle(
                        fontFamily: "Inter",
                        color: _getStatusColor(appointment.statusColor)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Preferred Donation Date
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                      DateFormat('MMM d, yyyy')
                          .format(appointment.preferredDonationDate),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: "Inter")),
                ),
              ],
            ),

            // Time Preference
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    appointment.timePreference,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    appointment.preferredBloodBank.district,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Days remaining info
            if (appointment.daysUntilAppointment > 0 &&
                appointment.status.toLowerCase() == 'pending')
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        size: 16, color: Colors.blue),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "${appointment.daysUntilAppointment} day(s) remaining",
                        style: const TextStyle(color: Colors.blue),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
