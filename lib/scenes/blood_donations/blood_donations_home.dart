import 'package:flutter/material.dart';
import 'package:redcross/scenes/blood_donations/blood_banks_list.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_faq_screen.dart';
import 'package:redcross/scenes/blood_donations/blood_drive_requests_list.dart';
import 'package:redcross/scenes/blood_donations/blood_eligibility.dart';
import 'package:redcross/scenes/blood_donations/donation_campaign_list.dart';
import 'package:redcross/scenes/blood_donations/donation_register.dart';
import 'package:redcross/scenes/donations/donation_history.dart';
import 'package:redcross/utils/colors.dart';

class BloodDonationsHome extends StatelessWidget {
  const BloodDonationsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'SF Pro',
      ),
      home: const BloodDonationHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BloodDonationHome extends StatelessWidget {
  const BloodDonationHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.03),
                // Title
                Text(
                  'Blood Donation',
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),

                // Find Donation Campaigns Button
                _buildMainButton(
                  context,
                  'Find Donation\nCampaigns',
                  Icons.home_outlined,
                  () {},
                ),
                SizedBox(height: screenHeight * 0.02),

                // Two column buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildSecondaryButton(
                        context,
                        'Eligibility to Donate',
                        Icons.water_drop_outlined,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BloodEligibility()),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: _buildSecondaryButton(
                        context,
                        'Register as a Donor',
                        Icons.format_list_bulleted,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DonationRegister()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // New buttons row
                Row(
                  children: [
                    Expanded(
                      child: _buildSecondaryButton(
                        context,
                        'Blood Drive Request',
                        Icons.calendar_today_outlined,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // CreateBloodDriveRequestScreen()
                                    const BloodDriveRequestsList()),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: _buildSecondaryButton(
                        context,
                        'Blood Banks',
                        Icons.local_hospital_outlined,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BloodBanksList()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // FAQ and Info row
                Row(
                  children: [
                    Expanded(
                      child: _buildSecondaryButton(
                        context,
                        'FAQs',
                        Icons.help_outline,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BloodDonationFaqScreen()),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: Container(), // Placeholder for symmetry
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                // Donations Campaigns Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donations Campaigns',
                      style: TextStyle(
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // CreateBloodDriveRequestScreen()
                                  DonationCampaignList()),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // Campaign Card
                _buildCampaignCard(context),
                SizedBox(height: screenHeight * 0.03),

                // Donation History Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donation History',
                      style: TextStyle(
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // CreateBloodDriveRequestScreen()
                                  const DonationHistory()),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // History Items
                _buildHistoryItem(context),
                SizedBox(height: screenHeight * 0.015),
                _buildHistoryItem(context),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainButton(
      BuildContext context, String text, IconData icon, VoidCallback onTap) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.025,
          horizontal: screenWidth * 0.05,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: screenWidth * 0.12,
            ),
            SizedBox(width: screenWidth * 0.04),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(
      BuildContext context, String text, IconData icon, VoidCallback onTap) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.025,
          horizontal: screenWidth * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.red,
              size: screenWidth * 0.1,
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignCard(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
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
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.18,
            height: screenWidth * 0.18,
            decoration: BoxDecoration(
              color: Colors.yellow[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.settings,
              color: Colors.blue[800],
              size: screenWidth * 0.1,
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rotary Nakawa Blood\nDonation Drive',
                  style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter"),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'Old Industrial Park, Nakawa Plot 11',
                  style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                      fontFamily: "Inter"),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  '⏰ Tuesday 23rd December 2024 | 10AM- 5PM',
                  style: TextStyle(
                      fontSize: screenWidth * 0.032,
                      color: AppColors.primaryRedColor,
                      fontFamily: "Inter"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
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
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.water_drop,
              color: Colors.red,
              size: screenWidth * 0.06,
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NITA-U Staff Donation',
                  style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter"),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'May 10, 2025',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '01',
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Units',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
