// ignore_for_file: unused_local_variable, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class AvailableAmbulances extends StatelessWidget {
  AvailableAmbulances({super.key});

  // Mock data for available ambulances
  final List<Map<String, dynamic>> ambulances = [
    {
      'id': 'AMB-001',
      'type': 'Advanced Life Support',
      'location': 'Kampala Central',
      'distance': '2.5 km',
      'eta': '8 mins',
      'status': 'available',
      'equipment': ['Ventilator', 'Defibrillator', 'ECG Monitor'],
    },
    {
      'id': 'AMB-002',
      'type': 'Basic Life Support',
      'location': 'Nakawa',
      'distance': '4.2 km',
      'eta': '12 mins',
      'status': 'available',
      'equipment': ['Oxygen', 'First Aid Kit', 'Stretcher'],
    },
    {
      'id': 'AMB-003',
      'type': 'Emergency Response',
      'location': 'Kololo',
      'distance': '3.8 km',
      'eta': '10 mins',
      'status': 'available',
      'equipment': ['AED', 'Trauma Kit', 'Oxygen', 'Spine Board'],
    },
    {
      'id': 'AMB-004',
      'type': 'Advanced Life Support',
      'location': 'Ntinda',
      'distance': '6.1 km',
      'eta': '15 mins',
      'status': 'available',
      'equipment': ['Ventilator', 'Defibrillator', 'IV Equipment'],
    },
    {
      'id': 'AMB-005',
      'type': 'Patient Transport',
      'location': 'Mbuya',
      'distance': '5.5 km',
      'eta': '14 mins',
      'status': 'available',
      'equipment': ['Wheelchair', 'Oxygen', 'Basic Monitoring'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AmbulanceHome()),
            )
          },
        ),
        title: Text(
          "Available Ambulances",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
            letterSpacing: StorageService.getSpacing(18),
          ),
        ),
      ),
      body: Column(
        children: [
          // Header info
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: 16,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.primaryRedColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Showing ambulances near you",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                      letterSpacing: StorageService.getSpacing(13),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${ambulances.length} Available",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List of ambulances
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: 8,
              ),
              itemCount: ambulances.length,
              itemBuilder: (context, index) {
                final ambulance = ambulances[index];
                return _buildAmbulanceCard(
                  context,
                  ambulance,
                  screenWidth,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmbulanceCard(
    BuildContext context,
    Map<String, dynamic> ambulance,
    double screenWidth,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with ID and type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryRedColor?.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.local_hospital,
                      color: AppColors.primaryRedColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ambulance['id'],
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColor,
                          letterSpacing: StorageService.getSpacing(16),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ambulance['type'],
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                          letterSpacing: StorageService.getSpacing(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  ambulance['status'].toUpperCase(),
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.green[700],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Location and distance info
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Text(
                ambulance['location'],
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                  letterSpacing: StorageService.getSpacing(13),
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.navigation,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Text(
                ambulance['distance'],
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                  letterSpacing: StorageService.getSpacing(13),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.primaryRedColor,
              ),
              const SizedBox(width: 6),
              Text(
                "ETA: ${ambulance['eta']}",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryRedColor,
                  letterSpacing: StorageService.getSpacing(13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Equipment tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (ambulance['equipment'] as List<String>)
                .map((equipment) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        equipment,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),

          // Request button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                // Handle request ambulance
                _showRequestDialog(context, ambulance);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRedColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_alert,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Request This Ambulance",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: StorageService.getSpacing(14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestDialog(
      BuildContext context, Map<String, dynamic> ambulance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Request Ambulance",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
          content: Text(
            "Do you want to request ${ambulance['id']}?\n\nEstimated arrival: ${ambulance['eta']}",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle actual request
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Ambulance ${ambulance['id']} requested successfully!",
                      style: const TextStyle(fontFamily: "Inter"),
                    ),
                    backgroundColor: Colors.green[700],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRedColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Confirm Request",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
