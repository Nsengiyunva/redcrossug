import 'package:flutter/material.dart';
import 'package:redcross/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/ambulances/ambulance_home.dart';
import 'package:redcross/scenes/blood_donations/blood_donations_home.dart';
import 'package:redcross/scenes/disasters/disaster_list.dart';
import 'package:redcross/scenes/donations/home_donations.dart';
import 'package:redcross/scenes/first_aid/first_aid_home.dart';
import 'package:redcross/scenes/home_badge.dart';
import 'package:redcross/scenes/volunteer/volunteer_home.dart';
import 'package:redcross/scenes/widgets/card_board.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class DefaultHome extends StatefulWidget {
  const DefaultHome({super.key});

  @override
  State<DefaultHome> createState() => _DefaultHomeState();
}

class _DefaultHomeState extends State<DefaultHome> {
  var time = StorageService.displayWhatTime();
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Obx(() {
          if (homeController.isLoading.value) {
            return Container(
                child: const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 25),
                  Text("Loading...")
                ],
              ),
            ));
          }

          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(time,
                                    style: const TextStyle(
                                      fontSize: 16.46,
                                      color: AppColors.blackColorF,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                    ))),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(homeController.fullName.value,
                                    style: const TextStyle(
                                      fontSize: 20.97,
                                      color: Color(0xFF545454),
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ))),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Color(0xFF1C274C),
                              size: 25.24,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardBoard(
                          title: "Blood Donation",
                          icon_name: "blood_icon",
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BloodDonationsHome()),
                            );
                            // Get.toNamed("/blood-donations");
                          }),
                      CardBoard(
                          title: "First Aid",
                          icon_name: "hospital",
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const FirstAidHome()),
                            );
                            // Get.toNamed("/first-aid-home");
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardBoard(
                        title: "Ambulance",
                        icon_name: "ambulance",
                        onPressed: () {
                          // Get.toNamed('/ambulance-home');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AmbulanceHome()),
                          );
                        },
                      ),
                      CardBoard(
                        title: "Disasters",
                        icon_name: "disasters",
                        onPressed: () {
                          // Get.toNamed('/disasters');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => DisasterList()),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardBoard(
                              title: "Donations",
                              icon_name: "cash",
                              onPressed: () {
                                // Get.toNamed("/home-donations");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeDonations()),
                                );
                              }),
                          CardBoard(
                              title: "Memberships",
                              icon_name: "cash",
                              onPressed: () {
                                // Get.toNamed("/home-donations");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VolunteerHome()),
                                );
                              })
                        ],
                      )),
                  const SizedBox(height: 15),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Upcoming Events',
                              style: TextStyle(
                                  fontSize: 12.79,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1C274C))),
                          Row(children: [
                            Text('See All',
                                style: TextStyle(
                                    fontSize: 8.83,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF1C274C))),
                            // Icon(
                            //   Icons.audiotrack,
                            //   color: Color(0xFF1C274C),
                            //   size: 7.52,
                            // )
                          ])
                        ],
                      )),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeBadge(
                          title: 'Annual Red Cross Gala & Fundraiser',
                          icon_name: "blood_icon"),
                      HomeBadge(
                          title: 'World Blood Donor Day', icon_name: "gala")
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
