// ==================== BLOOD DRIVE REQUESTS LIST SCREEN ====================

// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:redcross/models/blood_drive_request.dart';
import 'package:redcross/scenes/blood_donations/blood_drive_details.dart';
import 'package:redcross/scenes/blood_donations/created_blood_drive_request_screen.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class BloodDriveRequestsList extends StatefulWidget {
  const BloodDriveRequestsList({super.key});

  @override
  State<BloodDriveRequestsList> createState() =>
      _BloodDriveRequestsListScreenState();
}

class _BloodDriveRequestsListScreenState extends State<BloodDriveRequestsList> {
  bool isLoading = true;
  List<BloodDriveRequest> requests = [];

  int currentPage = 1;
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = await StorageService.getToken();

      final response = await http.get(
        Uri.parse(
            'https://urcs-api.taufeeq.dev/api/blood-donation/drive-requests'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Requested-With": "XMLHttpRequest",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(response.body)['data'];

        final List dataList = responseData['data'] as List? ?? [];

        setState(() {
          requests =
              dataList.map((json) => BloodDriveRequest.fromJson(json)).toList();
          lastPage = responseData['last_page'] ?? 1;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // print(
        //     'Failed to load requests. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
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
      // print('Error fetching requests: $e');
    }
  }

  void _navigateToDetails(BloodDriveRequest request) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BloodDriveDetails(request: request),
      ),
    );
  }

  void _navigateToCreateRequest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateBloodDriveRequestScreen(),
      ),
    );
  }

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Blood Drive Requests',
                style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter"),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                '${requests.length} active requests',
                style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey[600],
                    fontFamily: "Inter"),
              ),
              SizedBox(height: screenHeight * 0.025),

              // Requests List
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : requests.isEmpty
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
                                  'No blood drive requests',
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      color: Colors.grey[600],
                                      fontFamily: "Inter"),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: requests.length,
                            itemBuilder: (context, index) {
                              final request = requests[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: screenHeight * 0.015,
                                ),
                                child: _buildRequestCard(
                                    request, screenWidth, screenHeight),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToCreateRequest,
        backgroundColor: AppColors.primaryRedColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Request',
          style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter"),
        ),
      ),
    );
  }

  Widget _buildRequestCard(
      BloodDriveRequest request, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () => _navigateToDetails(request),
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
                    request.organizationName,
                    style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    request.status.toUpperCase(),
                    style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: _getStatusColor(request.status),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter"),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${request.district} • ${request.location}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.005),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('MMM dd, yyyy').format(request.requestedDate),
                  style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                      fontFamily: "Inter"),
                ),
                SizedBox(width: screenWidth * 0.04),
                Icon(
                  Icons.people,
                  size: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${request.expectedDonors} expected donors',
                  style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                      fontFamily: "Inter"),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${request.contactPerson} • ${request.contactNumber}',
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[600],
                        fontFamily: "Inter"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
