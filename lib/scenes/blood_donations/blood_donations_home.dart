// import 'package:flutter/material.dart';
// import 'package:redcross/scenes/blood_donations/blood_eligibility.dart';
// import 'package:redcross/scenes/blood_donations/donation_campaign_details.dart';
// import 'package:redcross/scenes/blood_donations/donation_campaign_list.dart';
// import 'package:redcross/scenes/widgets/blood_donation_list_item.dart';
// import 'package:redcross/scenes/widgets/donation_badge.dart';
// import 'package:redcross/scenes/widgets/donation_history_item.dart';
// import 'package:redcross/scenes/widgets/nav_list_items.dart';
// import 'package:redcross/utils/colors.dart';

// class BloodDonationsHome extends StatelessWidget {
//   const BloodDonationsHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.bgColor,
//         body: SingleChildScrollView(
//           child: Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(vertical: 30.0),
//               padding:
//                   const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     alignment: Alignment.centerLeft,
//                     child: const Text(
//                       "Blood Donation",
//                       style: TextStyle(
//                         fontFamily: "Inter",
//                         fontSize: 26.33,
//                         fontWeight: FontWeight.w700,
//                       ),
//                       textAlign: TextAlign.start, // Align text to start
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                                 builder: (context) => DonationCampaignList()),
//                           );
//                         },
//                         child: Container(
//                             height: 86,
//                             width: 335,
//                             padding: const EdgeInsets.only(right: 5, left: 10),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryRedColor,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: AppColors.primaryRedColor,
//                                 width: 1,
//                               ),
//                             ),
//                             child: const Center(
//                                 child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                   SizedBox(
//                                       height: 52,
//                                       width: 52,
//                                       child: Icon(
//                                         Icons.home,
//                                         color: AppColors.whiteColor,
//                                         size: 52,
//                                       )),
//                                   Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text("Find Donation",
//                                             style: TextStyle(
//                                                 fontFamily: "Inter",
//                                                 fontSize: 23.14,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.whiteColor)),
//                                         Text("Campaigns",
//                                             style: TextStyle(
//                                                 fontFamily: "Inter",
//                                                 fontSize: 23.14,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.whiteColor))
//                                       ])
//                                 ]))),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(children: [
//                     DonationBadge(
//                         title: 'Eligibility to Donate',
//                         icon_name: "blood_icon",
//                         onPressed: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                                 builder: (context) => const BloodEligibility()),
//                           );
//                         }),
//                     DonationBadge(
//                         title: 'Donation Highlights',
//                         icon_name: "gala",
//                         onPressed: () {})
//                   ]),
//                   const SizedBox(height: 25),
//                   NavListItems(
//                     label: 'Donations Campaigns',
//                     subtitle: "See All",
//                     onPressed: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                             builder: (context) => DonationCampaignList()),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           height: 107,
//                           width: 335,
//                           padding: const EdgeInsets.only(right: 5, left: 10),
//                           decoration: BoxDecoration(
//                             color: AppColors.whiteColor,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: BloodDonationListItem(
//                               name: "Rotary Nakawa Blood",
//                               location: "Old Industrial Park, Nakawa Plot 11",
//                               date: "Tuesday 23rd December  2024",
//                               time: "10AM-5PM",
//                               onPressed: () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const DonationCampaignDetails(
//                                             campaign: {},
//                                           )),
//                                 );
//                               })),
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   NavListItems(
//                     label: 'Donation History',
//                     subtitle: "See All",
//                     onPressed: () {},
//                   ),
//                   const SizedBox(height: 15),
//                   DonationHistoryItem(
//                     onPressed: () {},
//                   ),
//                   const SizedBox(height: 10),
//                   DonationHistoryItem(onPressed: () {})
//                 ],
//               )),
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:redcross/scenes/blood_donations/blood_banks_list.dart';
import 'package:redcross/scenes/blood_donations/blood_drive_requests_list.dart';
import 'package:redcross/scenes/blood_donations/created_blood_drive_request_screen.dart';
import 'package:redcross/scenes/blood_donations/donation_register.dart';

class BloodDonationsHome extends StatelessWidget {
  const BloodDonationsHome({Key? key}) : super(key: key);

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
  const BloodDonationHome({Key? key}) : super(key: key);

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
                        () {},
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
                                builder: (context) => DonationRegister()),
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
                                    BloodDriveRequestsList()),
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
                                builder: (context) => BloodBanksList()),
                          );
                        },
                      ),
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
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey,
                      ),
                    ),
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
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey,
                      ),
                    ),
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
              ),
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
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'Old Industrial Park, Nakawa Plot 11',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  '⏰ Tuesday 23rd December 2024 | 10AM- 5PM',
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    color: Colors.red,
                  ),
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
                  ),
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
