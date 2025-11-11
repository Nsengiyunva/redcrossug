// ==================== BLOOD DRIVE REQUESTS LIST SCREEN ====================

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/models/blood_drive_request.dart';
import 'package:redcross/scenes/blood_donations/blood_drive_details.dart';
import 'package:redcross/scenes/blood_donations/created_blood_drive_request_screen.dart';

class BloodDriveRequestsList extends StatefulWidget {
  const BloodDriveRequestsList({super.key});

  @override
  State<BloodDriveRequestsList> createState() =>
      _BloodDriveRequestsListScreenState();
}

class _BloodDriveRequestsListScreenState extends State<BloodDriveRequestsList> {
  List<BloodDriveRequest> requests = [];
  bool isLoading = true;
  int currentPage = 1;
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  void _loadRequests() {
    // Sample data - replace with actual API call
    final sampleData = {
      "success": true,
      "data": {
        "current_page": 1,
        "data": [
          {
            "id": 1,
            "user_id": 1,
            "organization_name": "Red Cross Rwanda - Kigali Branch",
            "expected_donors": 150,
            "district": "Gasabo",
            "location": "Kigali Convention Centre, Main Hall",
            "contact_person": "Marie Uwimana",
            "contact_number": "+250788123456",
            "contact_email": "marie.uwimana@redcross.rw",
            "has_tents": true,
            "has_public_address": true,
            "has_chairs": false,
            "has_tables": true,
            "status": "approved",
            "requested_date": "2025-12-14T21:00:00.000000Z",
            "additional_notes":
                "We need assistance with chairs as our venue doesn't provide them.",
            "admin_notes": null,
            "cancellation_reason": null,
            "cancelled_at": null,
            "reviewed_at": "2025-10-31T15:11:49.000000Z",
            "reviewed_by": {
              "id": 3,
              "name": "Admin User",
              "first_name": "Admin",
              "last_name": "User",
              "email": "admin@example.com",
              "membership_id": null,
              "phone_no": "+256700000001",
              "nationality": "Ugandan",
            },
            "created_at": "2025-10-31T14:59:36.000000Z",
            "updated_at": "2025-10-31T15:11:49.000000Z",
            "user": {
              "id": 1,
              "name": "Joe Biden",
              "first_name": "Joe",
              "last_name": "Biden",
              "email": "nsambataufeeq@gmail.com",
              "membership_id": "URCS-102/M/3768/2024",
              "phone_no": "+256751830778",
              "nationality": "Uganda",
            }
          }
        ],
        "last_page": 1,
      }
    };

    setState(() {
      // requests = (sampleData['data']?['data'] as List)
      //     .map((json) => BloodDriveRequest.fromJson(json))
      //     .toList();
      // lastPage = sampleData['data']['last_page'];
      isLoading = false;
    });
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
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                '${requests.length} active requests',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
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
                                  ),
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
        backgroundColor: Colors.red,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Request',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
                    ),
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
                    ),
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
                  ),
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
                  ),
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
                    ),
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
