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
import 'package:flutter/material.dart';
import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';

class DefaultHome extends StatelessWidget {
  const DefaultHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Red Cross',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'SF Pro',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: SafeArea(
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
                _buildUpcomingEvents(isTablet),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good afternoon',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Garvin John Wick',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C2C2C),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2C3E50),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceGrid(bool isTablet, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = isTablet ? 3 : 2;
        final spacing = isTablet ? 20.0 : 16.0;
        final childAspectRatio = isTablet ? 1.3 : 1.15;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: childAspectRatio,
          children: [
            _buildServiceCard(
                icon: Icons.water_drop_outlined,
                label: 'Blood Donation',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const BloodDonationsHome()),
                  );
                }),
            _buildServiceCard(
                icon: Icons.medical_services_outlined,
                label: 'First Aid',
                onPressed: () {}),
            _buildServiceCard(
                icon: Icons.local_hospital_outlined,
                label: 'Ambulance',
                onPressed: () {}),
            _buildServiceCard(
                icon: Icons.warning_amber_rounded,
                label: 'Disasters',
                onPressed: () {}),
            _buildServiceCard(
                icon: Icons.card_membership_outlined,
                label: 'Memberships',
                onPressed: () {}),
            _buildServiceCard(
                icon: Icons.attach_money_outlined,
                label: 'Donations',
                onPressed: () {}),
            _buildServiceCard(
                icon: Icons.calendar_view_day,
                label: 'Volunteers',
                onPressed: () {}),
          ],
        );
      },
    );
  }

  Widget _buildServiceCard(
      {required IconData icon, required String label, required onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE31E24),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE31E24).withOpacity(0.3),
            blurRadius: 8,
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
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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

  Widget _buildUpcomingEvents(bool isTablet) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C2C2C),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xFF2C2C2C),
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildEventCard(
                title: 'Annual Red\nCross Gala\n& Fundraiser',
                icon: Icons.percent_outlined,
              ),
              const SizedBox(width: 16),
              _buildEventCard(
                title: 'World Blood\nDonor Day',
                icon: Icons.water_drop_outlined,
              ),
              const SizedBox(width: 16),
              _buildEventCard(
                title: 'Annual Red\nCross Gala\n& Fundraiser',
                icon: Icons.percent_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard({required String title, required IconData icon}) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5E7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C2C2C),
                height: 1.3,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE31E24),
                width: 3,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFE31E24),
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildBottomNav() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           offset: const Offset(0, -2),
  //         ),
  //       ],
  //     ),
  //     child: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             _buildNavItem(
  //               icon: Icons.home,
  //               label: 'Home',
  //               index: 0,
  //             ),
  //             _buildNavItem(
  //               icon: Icons.water_drop_outlined,
  //               label: 'B. Donation',
  //               index: 1,
  //             ),
  //             _buildNavItem(
  //               icon: Icons.medical_services_outlined,
  //               label: 'First Aid',
  //               index: 2,
  //             ),
  //             _buildNavItem(
  //               icon: Icons.person_outline,
  //               label: 'Profile',
  //               index: 3,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildNavItem({
  //   required IconData icon,
  //   required String label,
  //   required int index,
  // }) {
  //   final isSelected = _selectedIndex == index;
  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         _selectedIndex = index;
  //       });
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 8),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(
  //             icon,
  //             color: isSelected ? const Color(0xFFE31E24) : Colors.grey,
  //             size: 28,
  //           ),
  //           const SizedBox(height: 4),
  //           Text(
  //             label,
  //             style: TextStyle(
  //               fontSize: 12,
  //               color: isSelected ? const Color(0xFFE31E24) : Colors.grey,
  //               fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
