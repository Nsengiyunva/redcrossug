// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class AmbulanceList extends StatefulWidget {
  @override
  _AmbulanceRequestsScreenState createState() =>
      _AmbulanceRequestsScreenState();
}

class _AmbulanceRequestsScreenState extends State<AmbulanceList> {
  List<AmbulanceRequest> requests = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAmbulanceRequests();
  }

  Future<void> _fetchAmbulanceRequests() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final token = await StorageService.getToken();

    try {
      final response = await http.get(
        Uri.parse(
            'https://urcs-api.taufeeq.dev/api/ambulance-requests'), // Replace with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          requests =
              data.map((json) => AmbulanceRequest.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load requests';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;
    final bool isDesktop = screenWidth >= 1024;

    final double horizontalPadding = isDesktop ? 40 : (isTablet ? 30 : 20);
    final double maxContentWidth =
        isDesktop ? 1200 : (isTablet ? 800 : screenWidth);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AmbulanceHome()),
            )
          },
        ),
        title: Text(
          'Ambulance Requests',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: _fetchAmbulanceRequests,
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: _buildBody(horizontalPadding, isDesktop, isTablet),
        ),
      ),
    );
  }

  Widget _buildBody(double horizontalPadding, bool isDesktop, bool isTablet) {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFFFF0000)),
            SizedBox(height: 16),
            Text(
              'Loading requests...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _fetchAmbulanceRequests,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF0000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Retry', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFFFFE5E5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_hospital_outlined,
                size: 40,
                color: Color(0xFFFF0000),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'No Ambulance Requests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'There are no ambulance requests at the moment',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primaryRedColor,
      onRefresh: _fetchAmbulanceRequests,
      child: ListView.builder(
        padding: EdgeInsets.all(horizontalPadding),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return _buildRequestCard(requests[index], isDesktop, isTablet);
        },
      ),
    );
  }

  Widget _buildRequestCard(
      AmbulanceRequest request, bool isDesktop, bool isTablet) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showRequestDetails(request),
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 20 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE5E5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.local_hospital_outlined,
                              color: Color(0xFFFF0000),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Request #${request.id}',
                                  style: TextStyle(
                                    fontSize: isDesktop ? 16 : 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  _formatDate(request.createdAt),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(request.status),
                  ],
                ),
                SizedBox(height: 16),
                Divider(color: Colors.grey[200], height: 1),
                SizedBox(height: 16),

                // Location
                _buildInfoRow(
                  Icons.location_on_outlined,
                  'Location',
                  request.location,
                  isDesktop,
                ),
                SizedBox(height: 12),

                // Phone
                _buildInfoRow(
                  Icons.phone_outlined,
                  'Phone',
                  request.phoneNumber,
                  isDesktop,
                ),
                SizedBox(height: 12),

                // Stats
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _buildStatChip(
                      Icons.people_outline,
                      '${request.numberOfPeople} People',
                    ),
                    _buildStatChip(
                      Icons.child_care_outlined,
                      '${request.numberOfChildren} Children',
                    ),
                    _buildStatChip(
                      Icons.medical_services_outlined,
                      '${request.numberOfCriticallyIll} Critical',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Color(0xFFFFF3CD);
        textColor = Color(0xFFFF9800);
        displayText = 'Pending';
        break;
      case 'approved':
        backgroundColor = Color(0xFFD4EDDA);
        textColor = Color(0xFF28A745);
        displayText = 'Approved';
        break;
      case 'rejected':
        backgroundColor = Color(0xFFF8D7DA);
        textColor = Color(0xFFDC3545);
        displayText = 'Rejected';
        break;
      case 'completed':
        backgroundColor = Color(0xFFD1ECF1);
        textColor = Color(0xFF17A2B8);
        displayText = 'Completed';
        break;
      default:
        backgroundColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
        displayText = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, bool isDesktop) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: isDesktop ? 15 : 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFFE5E5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Color(0xFFFF0000)),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFF0000),
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestDetails(AmbulanceRequest request) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RequestDetailsBottomSheet(request: request),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }
}

// Request Details Bottom Sheet
class RequestDetailsBottomSheet extends StatelessWidget {
  final AmbulanceRequest request;

  const RequestDetailsBottomSheet({Key? key, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Request Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    _buildStatusBadge(request.status),
                  ],
                ),
                SizedBox(height: 24),
                _buildDetailRow('Request ID', '#${request.id}'),
                _buildDetailRow('Location', request.location),
                _buildDetailRow('Phone Number', request.phoneNumber),
                _buildDetailRow(
                    'Number of People', '${request.numberOfPeople}'),
                _buildDetailRow(
                    'Number of Children', '${request.numberOfChildren}'),
                _buildDetailRow(
                    'Critically Ill', '${request.numberOfCriticallyIll}'),
                _buildDetailRow('Status', request.status.toUpperCase()),
                _buildDetailRow('Created', _formatDate(request.createdAt)),
                if (request.rejectedReason != null) ...[
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8D7DA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rejection Reason',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFDC3545),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          request.rejectedReason!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF0000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Color(0xFFFFF3CD);
        textColor = Color(0xFFFF9800);
        break;
      case 'approved':
        backgroundColor = Color(0xFFD4EDDA);
        textColor = Color(0xFF28A745);
        break;
      case 'rejected':
        backgroundColor = Color(0xFFF8D7DA);
        textColor = Color(0xFFDC3545);
        break;
      default:
        backgroundColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }
}

// Ambulance Request Model
class AmbulanceRequest {
  final int id;
  final int applicantId;
  final int? reviewedBy;
  final String? rejectedReason;
  final int numberOfPeople;
  final int numberOfChildren;
  final int numberOfCriticallyIll;
  final String location;
  final String phoneNumber;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? closeComments;

  AmbulanceRequest({
    required this.id,
    required this.applicantId,
    this.reviewedBy,
    this.rejectedReason,
    required this.numberOfPeople,
    required this.numberOfChildren,
    required this.numberOfCriticallyIll,
    required this.location,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.closeComments,
  });

  factory AmbulanceRequest.fromJson(Map<String, dynamic> json) {
    return AmbulanceRequest(
      id: json['id'],
      applicantId: json['applicant_id'],
      reviewedBy: json['reviewed_by'],
      rejectedReason: json['rejected_reason'],
      numberOfPeople: json['number_of_people'],
      numberOfChildren: json['number_of_children'],
      numberOfCriticallyIll: json['number_of_critically_ill'],
      location: json['location'],
      phoneNumber: json['phone_number'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      closeComments: json['close_comments'],
    );
  }
}
