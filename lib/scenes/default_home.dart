import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/home_badge.dart';
import 'package:redcross/scenes/widgets/card_board.dart';
import 'package:redcross/utils/colors.dart';

class DefaultHome extends StatelessWidget {
  DefaultHome({super.key});

  var isLogin = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            // padding: EdgeInsets.symmetric( horizontal: 8 ),
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Good afternoon",
                                  style: TextStyle(
                                    fontSize: 16.46,
                                    color: Color(0xFF545454),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                  ))),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Anthony Blinked",
                                  style: TextStyle(
                                    fontSize: 20.97,
                                    color: Color(0xFF545454),
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ))),
                        ],
                      ),
                    ),
                    Padding(
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
                        onPressed: () {}),
                    CardBoard(
                        title: "First Aid",
                        icon_name: "hospital",
                        onPressed: () {
                          Get.toNamed("/first-aid-home");
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
                        Get.toNamed('/ambulance-home');
                      },
                    ),
                    CardBoard(
                      title: "Disasters",
                      icon_name: "disasters",
                      onPressed: () {
                        Get.toNamed('/disasters');
                      },
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CardBoard(
                            title: "Donations",
                            icon_name: "cash",
                            onPressed: () {}),
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
                          Icon(
                            Icons.audiotrack,
                            color: Color(0xFF1C274C),
                            size: 7.52,
                          )
                        ])
                      ],
                    )),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeBadge(
                        title: 'Annual Red Cross Gala',
                        icon_name: "blood_icon"),
                    HomeBadge(title: 'World Blood Donor Day', icon_name: "gala")
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
