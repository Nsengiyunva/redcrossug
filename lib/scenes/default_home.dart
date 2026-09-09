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
import 'package:flutter/material.dart';
import 'package:redcross/models/user.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
import 'package:redcross/scenes/bulletins/bulletins_list.dart';
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
    final isSmallScreen = size.height < 700;
    final horizontalPadding = isTablet ? 32.0 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      body: Stack(
        children: [
          // Soft decorative backdrop behind the header for visual depth.
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFE31E24).withOpacity(0.06),
                    const Color(0xFFE31E24).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Positioned.fill gives this a bounded height (matching the
          // screen), which the Expanded grid below needs to size itself
          // exactly to the remaining space instead of scrolling.
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  isSmallScreen ? 10.0 : 16.0,
                  horizontalPadding,
                  isSmallScreen ? 10.0 : 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isSmallScreen),
                    SizedBox(height: isSmallScreen ? 14 : 20),
                    _buildAboutUsButton(context, isSmallScreen),
                    SizedBox(height: isSmallScreen ? 14 : 20),
                    Flexible(
                      child: _buildServiceGrid(context),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 14),
                    _buildBulletinsButton(context, isSmallScreen),
                    SizedBox(height: isSmallScreen ? 10 : 14),
                    _buildFeedbackButton(context, isSmallScreen),
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

  Widget _buildHeader(bool isSmallScreen) {
    final initial = (loggedInUser?.name?.isNotEmpty ?? false)
        ? loggedInUser!.name[0].toUpperCase()
        : "U";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: isSmallScreen ? 42 : 48,
                height: isSmallScreen ? 42 : 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE31E24), Color(0xFFB71C1C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE31E24).withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 17 : 19,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 13.5,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      loggedInUser?.name ?? "",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 19 : 23,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E1E1E),
                        letterSpacing: -0.3,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: EdgeInsets.all(isSmallScreen ? 9 : 11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEDEDF2), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: const Color(0xFF2C3E50),
            size: isSmallScreen ? 20 : 22,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutUsButton(BuildContext context, bool isSmallScreen) {
    return _buildFullWidthActionButton(
      icon: Icons.info_outline_rounded,
      label: 'About URCS',
      subtitle: 'Learn who we are and what we do',
      gradient: const LinearGradient(
        colors: [Color(0xFF2C3E50), Color(0xFF1A252F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      iconColor: Colors.white,
      textColor: Colors.white,
      shadowColor: const Color(0xFF2C3E50),
      isSmallScreen: isSmallScreen,
      onPressed: () => _openAboutUsUrl(context),
    );
  }

  Widget _buildBulletinsButton(BuildContext context, bool isSmallScreen) {
    return _buildFullWidthActionButton(
      icon: Icons.campaign_outlined,
      label: 'Bulletins',
      subtitle: 'Browse all news and announcements',
      gradient: const LinearGradient(
        colors: [Color(0xFFFFA726), Color(0xFFFF6F00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      iconColor: Colors.white,
      textColor: Colors.white,
      shadowColor: const Color(0xFFFF6F00),
      isSmallScreen: isSmallScreen,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BulletinsList()),
        );
      },
    );
  }

  Widget _buildFeedbackButton(BuildContext context, bool isSmallScreen) {
    return _buildFullWidthActionButton(
      icon: Icons.feedback_outlined,
      label: 'Give Feedback',
      subtitle: 'Tell us what you think',
      gradient: const LinearGradient(
        colors: [Color(0xFF26A69A), Color(0xFF00695C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      iconColor: Colors.white,
      textColor: Colors.white,
      shadowColor: const Color(0xFF00695C),
      isSmallScreen: isSmallScreen,
      onPressed: () => _openFeedbackSheet(context),
    );
  }

  Future<void> _openFeedbackSheet(BuildContext context) async {
    final feedbackController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00695C).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.feedback_outlined,
                          color: Color(0xFF00695C)),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Give Feedback',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(sheetContext).pop(),
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Your feedback helps us improve the app.',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: feedbackController,
                  minLines: 4,
                  maxLines: 6,
                  textInputAction: TextInputAction.newline,
                  style: const TextStyle(fontFamily: "Inter", fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Type your feedback here...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: const Color(0xFFF7F8FB),
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(color: Color(0xFF00695C), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final text = feedbackController.text.trim();
                      Navigator.of(sheetContext).pop();
                      if (text.isNotEmpty && context.mounted) {
                        // TODO: send `text` to your feedback API here.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Thank you for your feedback!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00695C),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Submit Feedback',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    feedbackController.dispose();
  }

  /// The 6 primary service cards, laid out as a 2-column x 3-row grid
  /// whose card size is derived from the space actually available
  /// (via [Expanded] + [LayoutBuilder]), so all 6 always fit on screen
  /// without scrolling, regardless of device height.
  Widget _buildServiceGrid(BuildContext context) {
    final cards = <_ServiceCardData>[
      _ServiceCardData(
        icon: Icons.water_drop_rounded,
        label: 'Blood Donation',
        gradient: const LinearGradient(
          colors: [Color(0xFFE31E24), Color(0xFFB71C1C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        iconColor: Colors.white,
        textColor: Colors.white,
        shadowColor: const Color(0xFFE31E24),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const BloodDonationsHome()),
          );
        },
      ),
      _ServiceCardData(
        icon: Icons.medical_services_rounded,
        label: 'First Aid',
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6E6E), Color(0xFFEF4747)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        iconColor: Colors.white,
        textColor: Colors.white,
        shadowColor: const Color(0xFFFF5252),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FirstAidHome()),
          );
        },
      ),
      _ServiceCardData(
        icon: Icons.local_hospital_rounded,
        label: 'Ambulance',
        gradient: null,
        color: const Color(0xFFFFF1F0),
        iconColor: const Color(0xFFE31E24),
        textColor: const Color(0xFF7F0000),
        shadowColor: const Color(0xFFE31E24),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AmbulanceHome()),
          );
        },
      ),
      _ServiceCardData(
        icon: Icons.warning_rounded,
        label: 'Disasters',
        gradient: null,
        color: const Color(0xFFFFE0E0),
        iconColor: const Color(0xFFD32F2F),
        textColor: const Color(0xFF7F0000),
        shadowColor: const Color(0xFFD32F2F),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DisasterList()),
          );
        },
      ),
      _ServiceCardData(
        icon: Icons.card_membership_rounded,
        label: 'Membership',
        gradient: null,
        color: const Color(0xFFFFC9C9),
        iconColor: const Color(0xFFB71C1C),
        textColor: const Color(0xFF7F0000),
        shadowColor: const Color(0xFFB71C1C),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MembershipCard()),
          );
        },
      ),
      _ServiceCardData(
        icon: Icons.volunteer_activism_rounded,
        label: 'Volunteers',
        gradient: null,
        color: const Color(0xFFFFADAD),
        iconColor: const Color(0xFF7F0000),
        textColor: const Color(0xFF5C0000),
        shadowColor: const Color(0xFF7F0000),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const VolunteerHome()),
          );
        },
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const crossAxisCount = 2;
        const rows = 3;
        const spacing = 12.0;

        final maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width - 40;
        final maxHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 420.0;

        final cardWidth =
            (maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;
        // Cap the row height so cards stay compact on taller screens
        // instead of stretching to fill all remaining space — while
        // still shrinking further (never growing past this) on short
        // screens so all 6 always fit without scrolling.
        final rawCardHeight = (maxHeight - spacing * (rows - 1)) / rows;
        final cardHeight = rawCardHeight.clamp(0.0, 84.0);
        final aspectRatio = (cardWidth / cardHeight).clamp(1.4, 3.2);
        final gridHeight = cardHeight * rows + spacing * (rows - 1);

        return SizedBox(
          height: gridHeight,
          width: maxWidth,
          child: GridView.count(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
            physics: const NeverScrollableScrollPhysics(),
            children: cards
                .map((c) => _buildServiceCard(
                      icon: c.icon,
                      label: c.label,
                      gradient: c.gradient,
                      color: c.color,
                      iconColor: c.iconColor,
                      textColor: c.textColor,
                      hasBorder: c.hasBorder,
                      shadowColor: c.shadowColor,
                      onPressed: c.onPressed,
                    ))
                .toList(growable: false),
          ),
        );
      },
    );
  }

  Widget _buildFullWidthActionButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Gradient gradient,
    required Color iconColor,
    required Color textColor,
    required Color shadowColor,
    required VoidCallback onPressed,
    bool isSmallScreen = false,
  }) {
    return Container(
      height: isSmallScreen ? 60 : 68,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.28),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          splashColor: Colors.white.withOpacity(0.15),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: isSmallScreen ? 8 : 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon,
                      color: iconColor, size: isSmallScreen ? 20 : 23),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: textColor,
                          fontSize: isSmallScreen ? 14.5 : 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor.withOpacity(0.75),
                          fontSize: isSmallScreen ? 10.5 : 11.5,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward_rounded,
                      color: iconColor, size: 15),
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
    Gradient? gradient,
    Color? color,
    required Color iconColor,
    required Color textColor,
    bool hasBorder = false,
    required Color shadowColor,
    required VoidCallback onPressed,
  }) {
    final bool isFilled = gradient != null;

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? color : null,
        borderRadius: BorderRadius.circular(22),
        border: hasBorder
            ? Border.all(color: const Color(0xFFE7E7EE), width: 1.4)
            : null,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(isFilled ? 0.28 : 0.10),
            blurRadius: isFilled ? 16 : 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(22),
          splashColor: (isFilled ? Colors.white : iconColor).withOpacity(0.12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final iconBoxSize =
                    (constraints.maxHeight * 0.52).clamp(28.0, 40.0);
                final iconSize = iconBoxSize * 0.5;
                final fontSize =
                    (constraints.maxHeight * 0.19).clamp(12.0, 14.5);

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: iconBoxSize,
                      height: iconBoxSize,
                      decoration: BoxDecoration(
                        color: isFilled
                            ? Colors.white.withOpacity(0.2)
                            : iconColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(iconBoxSize * 0.32),
                      ),
                      alignment: Alignment.center,
                      child: Icon(icon, color: iconColor, size: iconSize),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          label,
                          style: TextStyle(
                            color: textColor,
                            fontSize: fontSize,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.1,
                            height: 1.2,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceCardData {
  final IconData icon;
  final String label;
  final Gradient? gradient;
  final Color? color;
  final Color iconColor;
  final Color textColor;
  final bool hasBorder;
  final Color shadowColor;
  final VoidCallback onPressed;

  _ServiceCardData({
    required this.icon,
    required this.label,
    this.gradient,
    this.color,
    required this.iconColor,
    required this.textColor,
    this.hasBorder = false,
    required this.shadowColor,
    required this.onPressed,
  });
}
