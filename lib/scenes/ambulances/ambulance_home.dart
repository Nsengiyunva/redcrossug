import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/ambulance_controller.dart';
import 'package:redcross/scenes/ambulances/ambulance_progress_box.dart';
import 'package:redcross/scenes/widgets/ambulance_list_item.dart';
import 'package:redcross/scenes/widgets/red_btn_icon.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceHome extends StatelessWidget {
  AmbulanceHome({super.key});

  final AmbulanceController ambulanceController =
      Get.put(AmbulanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: Text(""),
            leading: const BackButton() // Back button added here
            ),
        body: Obx(() {
          if (ambulanceController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
              child: SizedBox(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ambulance",
                    style: TextStyle(
                        fontSize: 26.33,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        color: Color(0xFF000000)),
                  ),
                  const SizedBox(height: 15),
                  RedBtnIcon(
                    noColor: false,
                    label: 'Request for Ambulance',
                    onPressed: () {
                      Get.toNamed("/ambulance-request-form");
                    },
                    icon_name: "local_police",
                  ),
                  const SizedBox(height: 15),
                  const AmbulanceProgressBox(),
                  const Text(
                    "Service Providers",
                    style: TextStyle(
                        fontSize: 17.94,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 15),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      maxWidth: 400,
                      minHeight: 50,
                      maxHeight: 400,
                    ),
                    child: ListView.builder(
                      itemCount: ambulanceController.ambulance_list.length,
                      itemBuilder: (context, index) {
                        var item = ambulanceController.ambulance_list[index];
                        // print("item ${item}");
                        return Column(
                          children: [
                            AmbulanceListItem(
                                place: item["location"],
                                location: item["status"]?.toUpperCase(),
                                time: item["created_at"]),
                            const SizedBox(height: 15)
                          ],
                        );
                      },
                    ),
                  ),
                  const Center(
                    child: Column(
                      children: [
                        Text("Red Cross Ambulance Hotlines:",
                            style: TextStyle(
                                fontSize: 13.16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                                fontFamily: "Inter")),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("+256 410 678 564",
                                style: TextStyle(
                                    fontSize: 14.7,
                                    color: AppColors.blueColor,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400)),
                            SizedBox(width: 15),
                            Text("+256 410 678 896",
                                style: TextStyle(
                                    fontSize: 14.7,
                                    color: AppColors.blueColor,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400))
                          ],
                        )
                      ],
                    ),
                  )
                  // const AmbulanceListItem(
                  //     place: "Life Link",
                  //     location: 'Hospital, Naalya',
                  //     time: '23 mins'),
                  // const SizedBox(height: 15),
                  // const AmbulanceListItem(
                  //     place: "Frost Medical",
                  //     location: 'Center, Wakiso',
                  //     time: '11 mins'),
                  // const SizedBox(height: 15),
                  // const AmbulanceListItem(
                  //     place: "Children",
                  //     location: 'Clinic, Naalya',
                  //     time: '30 mins'),
                ],
              )),
            ),
          );
        }));
  }
}
