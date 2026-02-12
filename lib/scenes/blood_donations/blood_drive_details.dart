// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/models/blood_drive_request.dart';
import 'package:redcross/utils/colors.dart';

class BloodDriveDetails extends StatelessWidget {
  final BloodDriveRequest request;

  const BloodDriveDetails({super.key, required this.request});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.blue;
    }
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Request Details',
                  style: TextStyle(
                      fontSize: screenWidth * 0.09,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter"),
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.008,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(request.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        request.status.toUpperCase(),
                        style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: _getStatusColor(request.status),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                // Organization Info Section
                _buildSectionCard(
                  context,
                  'Organization Information',
                  [
                    _buildDetailRow(
                      context,
                      Icons.business,
                      'Organization',
                      request.organizationName,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.people,
                      'Expected Donors',
                      '${request.expectedDonors} people',
                    ),
                    _buildDetailRow(
                      context,
                      Icons.calendar_today,
                      'Requested Date',
                      DateFormat('MMMM dd, yyyy').format(request.requestedDate),
                    ),
                  ],
                  screenWidth,
                  screenHeight,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Location Section
                _buildSectionCard(
                  context,
                  'Location Details',
                  [
                    _buildDetailRow(
                      context,
                      Icons.location_city,
                      'District',
                      request.district,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.location_on,
                      'Venue',
                      request.location,
                    ),
                  ],
                  screenWidth,
                  screenHeight,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Contact Information Section
                _buildSectionCard(
                  context,
                  'Contact Information',
                  [
                    _buildDetailRow(
                      context,
                      Icons.person,
                      'Contact Person',
                      request.contactPerson,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.phone,
                      'Phone',
                      request.contactNumber,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.email,
                      'Email',
                      request.contactEmail,
                    ),
                  ],
                  screenWidth,
                  screenHeight,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Facilities Section
                _buildSectionCard(
                  context,
                  'Available Facilities',
                  [
                    _buildFacilityRow(
                      context,
                      'Tents',
                      request.hasTents,
                    ),
                    _buildFacilityRow(
                      context,
                      'Public Address System',
                      request.hasPublicAddress,
                    ),
                    _buildFacilityRow(
                      context,
                      'Chairs',
                      request.hasChairs,
                    ),
                    _buildFacilityRow(
                      context,
                      'Tables',
                      request.hasTables,
                    ),
                  ],
                  screenWidth,
                  screenHeight,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Additional Notes Section
                if (request.additionalNotes != null &&
                    request.additionalNotes!.isNotEmpty)
                  _buildSectionCard(
                    context,
                    'Additional Notes',
                    [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          request.additionalNotes!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                    screenWidth,
                    screenHeight,
                  ),
                if (request.additionalNotes != null &&
                    request.additionalNotes!.isNotEmpty)
                  SizedBox(height: screenHeight * 0.02),

                // Admin Notes Section (if approved/rejected)
                if (request.adminNotes != null &&
                    request.adminNotes!.isNotEmpty)
                  _buildSectionCard(
                    context,
                    'Admin Notes',
                    [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(screenWidth * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          request.adminNotes!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            color: Colors.blue[900],
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                    screenWidth,
                    screenHeight,
                  ),
                if (request.adminNotes != null &&
                    request.adminNotes!.isNotEmpty)
                  SizedBox(height: screenHeight * 0.02),

                // Review Information (if reviewed)
                if (request.reviewedAt != null)
                  _buildSectionCard(
                    context,
                    'Review Information',
                    [
                      _buildDetailRow(
                        context,
                        Icons.person_outline,
                        'Reviewed By',
                        request.reviewedBy?.name ?? 'N/A',
                      ),
                      _buildDetailRow(
                        context,
                        Icons.access_time,
                        'Reviewed At',
                        DateFormat('MMM dd, yyyy hh:mm a')
                            .format(request.reviewedAt!),
                      ),
                    ],
                    screenWidth,
                    screenHeight,
                  ),
                if (request.reviewedAt != null)
                  SizedBox(height: screenHeight * 0.02),

                // Requestor Information Section
                _buildSectionCard(
                  context,
                  'Requested By',
                  [
                    _buildDetailRow(
                      context,
                      Icons.person,
                      'Name',
                      request.user.name,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.email,
                      'Email',
                      request.user.email,
                    ),
                    _buildDetailRow(
                      context,
                      Icons.phone,
                      'Phone',
                      request.user.phoneNo,
                    ),
                    if (request.user.membershipId != null)
                      _buildDetailRow(
                        context,
                        Icons.badge,
                        'Membership ID',
                        request.user.membershipId!,
                      ),
                  ],
                  screenWidth,
                  screenHeight,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Action Buttons (if pending)
                if (request.status.toLowerCase() == 'pending')
                  Column(
                    children: const [
                      // GestureDetector(
                      //   onTap: () {
                      //     // Handle edit action
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text('Edit functionality coming soon'),
                      //         backgroundColor: Colors.blue,
                      //         behavior: SnackBarBehavior.floating,
                      //       ),
                      //     );
                      //   },
                      //   child: Container(
                      //     width: double.infinity,
                      //     padding: EdgeInsets.symmetric(
                      //       vertical: screenHeight * 0.02,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: Colors.blue,
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         'Edit Request',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: screenWidth * 0.045,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: screenHeight * 0.015),
                      // GestureDetector(
                      //   onTap: () {
                      //     // Handle cancel action
                      //     _showCancelDialog(context);
                      //   },
                      //   child: Container(
                      //     width: double.infinity,
                      //     padding: EdgeInsets.symmetric(
                      //       vertical: screenHeight * 0.02,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: Colors.red[50],
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         'Cancel Request',
                      //         style: TextStyle(
                      //           color: Colors.red,
                      //           fontSize: screenWidth * 0.045,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    String title,
    List<Widget> children,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      width: double.infinity,
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
          Text(
            title,
            style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter"),
          ),
          SizedBox(height: screenHeight * 0.015),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.012),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryRedColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: screenWidth * 0.033,
                      color: Colors.grey[600],
                      fontFamily: "Inter"),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityRow(
    BuildContext context,
    String facility,
    bool available,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.01),
      child: Row(
        children: [
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            color: available ? Colors.green : AppColors.primaryRedColor,
            size: screenWidth * 0.05,
          ),
          const SizedBox(width: 12),
          Text(
            facility,
            style: TextStyle(
                fontSize: screenWidth * 0.038,
                color: Colors.grey[800],
                fontFamily: "Inter"),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Cancel Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to cancel this blood drive request?',
                style: TextStyle(fontFamily: "Inter"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Reason for cancellation (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'No, Keep It',
                style: TextStyle(fontFamily: "Inter"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Request cancelled successfully',
                      style: TextStyle(fontFamily: "Inter"),
                    ),
                    backgroundColor: Colors.orange,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text(
                'Yes, Cancel',
                style: TextStyle(
                    fontFamily: "Inter", color: AppColors.primaryRedColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
