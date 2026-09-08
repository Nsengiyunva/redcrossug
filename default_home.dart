// import 'package:flutter/material.dart';
// import 'package:redcross/controllers/home_controller.dart';
// import 'package:get/get.dart';
// import 'package:redcross/scenes/ambulances/ambulance_home.dart';
// import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
// import 'package:redcross/scenes/disasters/disaster_list.dart';
// import 'package:redcross/scenes/donations/home_donations.dart';
// import 'package:redcross/scenes/first_aid/first_aid_home.dart';
// import 'package:redcross/scenes/home_badge.dart';
// import 'package:redcross/scenes/volunteer/volunteer_home.dart';
// import 'package:redcross/scenes/widgets/card_board.dart';
// import 'package:redcross/utils/colors.dart';
// import 'package:redcross/utils/storage_service.dart';

// class DefaultHome extends StatefulWidget {
//   const DefaultHome({super.key});

//   @override
//   State<DefaultHome> createState() => _DefaultHomeState();
// }

// class _DefaultHomeState extends State<DefaultHome> {
//   var time = StorageService.displayWhatTime();
//   final HomeController homeController = Get.put(HomeController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.bgColor,
//         body: Obx(() {
//           if (homeController.isLoading.value) {
//             return Container(
//                 child: const Center(
//               child: Column(
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 25),
//                   Text("Loading...")
//                 ],
//               ),
//             ));
//           }

//           return SingleChildScrollView(
//             child: Container(
//               width: double.maxFinite,
//               margin: const EdgeInsets.symmetric(vertical: 30.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15.0, vertical: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Text(time,
//                                     style: const TextStyle(
//                                       fontSize: 16.46,
//                                       color: AppColors.blackColorF,
//                                       fontFamily: "Inter",
//                                       fontWeight: FontWeight.w400,
//                                     ))),
//                             Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Text(homeController.fullName.value,
//                                     style: const TextStyle(
//                                       fontSize: 20.97,
//                                       color: Color(0xFF545454),
//                                       fontFamily: "Inter",
//                                       fontWeight: FontWeight.w600,
//                                     ))),
//                           ],
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(right: 20),
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.notifications,
//                               color: Color(0xFF1C274C),
//                               size: 25.24,
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       CardBoard(
//                           title: "Blood Donation",
//                           icon_name: "blood_icon",
//                           onPressed: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const BloodDonationsHome()),
//                             );
//                             // Get.toNamed("/blood-donations");
//                           }),
//                       CardBoard(
//                           title: "First Aid",
//                           icon_name: "hospital",
//                           onPressed: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (context) => const FirstAidHome()),
//                             );
//                             // Get.toNamed("/first-aid-home");
//                           }),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       CardBoard(
//                         title: "Ambulance",
//                         icon_name: "ambulance",
//                         onPressed: () {
//                           // Get.toNamed('/ambulance-home');
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                                 builder: (context) => AmbulanceHome()),
//                           );
//                         },
//                       ),
//                       CardBoard(
//                         title: "Disasters",
//                         icon_name: "disasters",
//                         onPressed: () {
//                           // Get.toNamed('/disasters');
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                                 builder: (context) => DisasterList()),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CardBoard(
//                               title: "Donations",
//                               icon_name: "cash",
//                               onPressed: () {
//                                 // Get.toNamed("/home-donations");
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const HomeDonations()),
//                                 );
//                               }),
//                           CardBoard(
//                               title: "Memberships",
//                               icon_name: "cash",
//                               onPressed: () {
//                                 // Get.toNamed("/home-donations");
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const VolunteerHome()),
//                                 );
//                               })
//                         ],
//                       )),
//                   const SizedBox(height: 15),
//                   const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Upcoming Events',
//                               style: TextStyle(
//                                   fontSize: 12.79,
//                                   fontFamily: "Inter",
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.greyColorZ)),
//                           Row(children: [
//                             Text('See All',
//                                 style: TextStyle(
//                                     fontSize: 8.83,
//                                     fontFamily: "Inter",
//                                     fontWeight: FontWeight.w400,
//                                     color: AppColors.greyColorZ)),
//                           ])
//                         ],
//                       )),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       HomeBadge(
//                           title: 'Annual Red Cross Gala & Fundraiser',
//                           icon_name: "blood_icon"),
//                       HomeBadge(
//                           title: 'World Blood Donor Day', icon_name: "gala")
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         }));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:redcross/models/user.dart';
// import 'package:redcross/scenes/ambulances/ambulance_home.dart';
// import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
// import 'package:redcross/scenes/disasters/disaster_list.dart';
// import 'package:redcross/scenes/first_aid/first_aid_home.dart';
// import 'package:redcross/scenes/floating_chat_button.dart';
// import 'package:redcross/scenes/memberships/membership_card.dart';
// import 'package:redcross/scenes/volunteer/volunteer_home.dart';
// import 'package:redcross/utils/colors.dart';
// import 'package:redcross/utils/storage_service.dart';

// class DefaultHome extends StatefulWidget {
//   const DefaultHome({super.key});

//   @override
//   State<DefaultHome> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<DefaultHome> {
//   var time = StorageService.displayWhatTime();
//   User? loggedInUser;
//   final int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     loadUser();
//   }

//   void loadUser() async {
//     loggedInUser = await StorageService.getUser();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isTablet = size.width > 600;

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: isTablet ? 32.0 : 20.0,
//               vertical: 16.0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(),
//                 SizedBox(height: isTablet ? 40 : 30),
//                 _buildServiceGrid(isTablet, context),
//                 SizedBox(height: isTablet ? 40 : 30),
//                 _buildUpcomingEvents(isTablet),
//                 const FloatingChatButton()
//               ],
//             ),
//           ),
//         ),
//       ),
//       // bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               time ?? "",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: "Inter",
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               loggedInUser?.name ?? "",
//               style: const TextStyle(
//                 fontSize: 28,
//                 fontFamily: "Inter",
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF2C2C2C),
//               ),
//             ),
//           ],
//         ),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: const Color(0xFF2C3E50),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Icon(
//             Icons.notifications,
//             color: Colors.white,
//             size: 24,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceGrid(bool isTablet, BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final crossAxisCount = isTablet ? 3 : 2;
//         final spacing = isTablet ? 20.0 : 16.0;
//         final childAspectRatio = isTablet ? 1.3 : 1.15;

//         return GridView.count(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           crossAxisCount: crossAxisCount,
//           crossAxisSpacing: spacing,
//           mainAxisSpacing: spacing,
//           childAspectRatio: childAspectRatio,
//           children: [
//             _buildServiceCard(
//                 icon: Icons.water_drop_outlined,
//                 label: 'Blood Donation',
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const BloodDonationsHome()),
//                   );
//                 }),
//             _buildServiceCard(
//                 icon: Icons.medical_services_outlined,
//                 label: 'First Aid',
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const FirstAidHome()),
//                   );
//                 }),
//             _buildServiceCard(
//                 icon: Icons.local_hospital_outlined,
//                 label: 'Ambulance',
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => AmbulanceHome()),
//                   );
//                 }),
//             _buildServiceCard(
//                 icon: Icons.warning_amber_rounded,
//                 label: 'Disasters',
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => DisasterList()),
//                   );
//                 }),
//             _buildServiceCard(
//                 icon: Icons.card_membership_outlined,
//                 label: 'Memberships',
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const MembershipCard()),
//                   );
//                 }),
//             _buildServiceCard(
//                 icon: Icons.calendar_view_day,
//                 label: 'Volunteers',
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => const VolunteerHome()),
//                   );
//                 }),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildServiceCard(
//       {required IconData icon, required String label, required onPressed}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFE31E24),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFFE31E24).withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   icon,
//                   color: Colors.white,
//                   size: 48,
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontFamily: "Inter",
//                     fontWeight: FontWeight.w600,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUpcomingEvents(bool isTablet) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Upcoming Events',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontFamily: "Inter",
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF2C2C2C),
//               ),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: const Row(
//                 children: [
//                   Text(
//                     'See All',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontFamily: "Inter",
//                       color: Color(0xFF2C2C2C),
//                     ),
//                   ),
//                   SizedBox(width: 4),
//                   Icon(
//                     Icons.chevron_right,
//                     color: Color(0xFF2C2C2C),
//                     size: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 180,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               _buildEventCard(
//                 title: 'Annual Red\nCross Gala\n& Fundraiser',
//                 icon: Icons.percent_outlined,
//               ),
//               const SizedBox(width: 16),
//               _buildEventCard(
//                 title: 'World Blood\nDonor Day',
//                 icon: Icons.water_drop_outlined,
//               ),
//               const SizedBox(width: 16),
//               _buildEventCard(
//                 title: 'Annual Red\nCross Gala\n& Fundraiser',
//                 icon: Icons.percent_outlined,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEventCard({required String title, required IconData icon}) {
//     return Container(
//       width: 280,
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: AppColors.redColorJ,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontFamily: "Inter",
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.blackColorY,
//                 height: 1.3,
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: AppColors.primaryRedColor,
//                 width: 3,
//               ),
//             ),
//             child: Icon(
//               icon,
//               color: AppColors.primaryRedColor,
//               size: 32,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

//-----
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/controllers/bulletins_controller.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
import 'package:redcross/scenes/bulletins/bulletins_list.dart';
import 'package:redcross/scenes/bulletins/bulletin_detail.dart';
import 'package:redcross/scenes/chat/floating_chat_button.dart';
import 'package:redcross/scenes/disasters/disaster_list.dart';
import 'package:redcross/scenes/first_aid/first_aid_home.dart';
import 'package:redcross/scenes/memberships/membership_card.dart';
import 'package:redcross/scenes/volunteer/volunteer_home.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultHome extends StatefulWidget {
  const DefaultHome({super.key});

  @override
  State<DefaultHome> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DefaultHome> {
  var time = StorageService.displayWhatTime();
  User? loggedInUser;
  final int _selectedIndex = 0;
  final BulletinsController bulletinsController = Get.put(BulletinsController());

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    loggedInUser = await StorageService.getUser();
    setState(() {});
  }

  Future<void> _openAboutUsUrl(BuildContext context) async {
    final Uri uri = Uri.parse('https://redcrossug.org/');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open redcrossug.org.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32.0 : 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(height: isTablet ? 40 : 30),
                    _buildServiceGrid(isTablet, context),
                    SizedBox(height: isTablet ? 40 : 30),
                    _buildBulletinCard(),
                    const SizedBox(height: 16),
                    _buildFullWidthActionButton(
                      icon: Icons.campaign_outlined,
                      label: 'View All Bulletins',
                      subtitle: 'Browse all news and announcements',
                      color: const Color(0xFFFFF3E0),
                      iconColor: const Color(0xFFFF6F00),
                      textColor: const Color(0xFF2C2C2C),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const BulletinsList()),
                        );
                      },
                    ),
                    const SizedBox(height: 80), // Space for floating button
                  ],
                ),
              ),
            ),
          ),
          const FloatingChatButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                loggedInUser?.name ?? "",
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C2C),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2C3E50), Color(0xFF34495E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2C3E50).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceGrid(bool isTablet, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primary CTA - Hero Carousel (Blood Donation, About Us)
        _HeroCarousel(
          items: [
            _HeroCarouselItem(
              icon: Icons.water_drop,
              label: 'Blood Donation',
              subtitle: 'Save lives by donating blood',
              gradient: const LinearGradient(
                colors: [Color(0xFFE31E24), Color(0xFFB71C1C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const BloodDonationsHome()),
                );
              },
            ),
            _HeroCarouselItem(
              icon: Icons.info_outline,
              label: 'About Us',
              subtitle: 'Learn who we are and what we do',
              gradient: const LinearGradient(
                colors: [Color(0xFF2C3E50), Color(0xFF1A252F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onPressed: () => _openAboutUsUrl(context),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Section Title
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Secondary Services Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isTablet ? 3 : 2,
          crossAxisSpacing: isTablet ? 20.0 : 16.0,
          mainAxisSpacing: isTablet ? 20.0 : 16.0,
          childAspectRatio: isTablet ? 1.3 : 1.15,
          children: [
            _buildServiceCard(
              icon: Icons.medical_services_outlined,
              label: 'First Aid',
              color: const Color(0xFFFF5252),
              iconColor: Colors.white,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const FirstAidHome()),
                );
              },
            ),
            _buildServiceCard(
              icon: Icons.local_hospital_outlined,
              label: 'Ambulance',
              color: Colors.white,
              iconColor: const Color(0xFFE31E24),
              textColor: const Color(0xFF2C2C2C),
              hasBorder: true,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AmbulanceHome()),
                );
              },
            ),
            _buildServiceCard(
              icon: Icons.warning_amber_rounded,
              label: 'Disasters',
              color: const Color(0xFFFFF3E0),
              iconColor: const Color(0xFFFF6F00),
              textColor: const Color(0xFF2C2C2C),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DisasterList()),
                );
              },
            ),
            _buildServiceCard(
              icon: Icons.card_membership_outlined,
              label: 'Memberships',
              color: const Color(0xFFE8F5E9),
              iconColor: const Color(0xFF2E7D32),
              textColor: const Color(0xFF2C2C2C),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const MembershipCard()),
                );
              },
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Volunteers - Full width button
        _buildFullWidthActionButton(
          icon: Icons.volunteer_activism_outlined,
          label: 'Become a Volunteer',
          subtitle: 'Make a difference today',
          color: const Color(0xFFF3E5F5),
          iconColor: const Color(0xFF7B1FA2),
          textColor: const Color(0xFF2C2C2C),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const VolunteerHome()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFullWidthActionButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 12,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required Color textColor,
    bool hasBorder = false,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: hasBorder
            ? Border.all(color: const Color(0xFFE0E0E0), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletinCard() {
    return Obx(() {
      // Get the first upcoming event or latest bulletin
      final upcomingEvents = bulletinsController.getUpcomingEvents();
      final bulletin = upcomingEvents.isNotEmpty
          ? upcomingEvents.first
          : (bulletinsController.bulletins.isNotEmpty
              ? bulletinsController.bulletins.first
              : null);

      if (bulletin == null) {
        // Show placeholder if no bulletins
        return Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B9D), Color(0xFFC06C84)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BulletinsList(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.campaign_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View Bulletins & Updates',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tap to see latest news',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      // Show actual bulletin
      return Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B9D), Color(0xFFC06C84)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BulletinDetail(bulletin: bulletin),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.campaign_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bulletin.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        if (bulletin.eventStartDate != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _formatDate(bulletin.eventStartDate!),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        else if (bulletin.publishedAt != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _formatDate(bulletin.publishedAt!),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Tomorrow';
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      return 'In ${diff.inDays} days';
    } else {
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }
}

/// Data for a single card shown inside [_HeroCarousel].
class _HeroCarouselItem {
  final IconData icon;
  final String label;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onPressed;

  const _HeroCarouselItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.gradient,
    required this.onPressed,
  });
}

/// Auto-advancing carousel used for the primary CTA hero cards
/// (e.g. Blood Donation, About Us) on the home screen.
class _HeroCarousel extends StatefulWidget {
  final List<_HeroCarouselItem> items;
  final Duration autoScrollInterval;

  const _HeroCarousel({
    required this.items,
    this.autoScrollInterval = const Duration(milliseconds: 4000),
  });

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.items.length > 1) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.autoScrollInterval, (timer) {
      if (!mounted || !_pageController.hasClients) return;
      _currentPage = (_currentPage + 1) % widget.items.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return _HeroCard(item: widget.items[index]);
            },
          ),
        ),
        if (widget.items.length > 1) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.items.length, (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFE31E24)
                      : const Color(0xFFE31E24).withOpacity(0.25),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}

/// Visual presentation of a single [_HeroCarouselItem].
class _HeroCard extends StatelessWidget {
  final _HeroCarouselItem item;

  const _HeroCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: item.gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE31E24).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 15,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
