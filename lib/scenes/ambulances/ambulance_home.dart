import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/ambulances/ambulance_progress_box.dart';
import 'package:redcross/scenes/widgets/ambulance_list_item.dart';
import 'package:redcross/scenes/widgets/red_btn_icon.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceHome extends StatelessWidget {
  AmbulanceHome({super.key});

  final LoginController _formController = Get.put( LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text( "Ambulance", style: TextStyle( 
                fontSize: 26.33, 
                fontWeight: FontWeight.w700,
                fontFamily: "Inter",
                color: Color(0xFF000000)
                ), ),
              const SizedBox( height: 15 ),
              RedBtnIcon( noColor: false, label: 'Request for Ambulance', 
              onPressed: () {
                Get.toNamed( "/ambulance-request-form" );
              }, icon_name: "local_police", ),
              // RedBtnIcon(noColor: true, label: "Ambulance for Status", onPressed: () {}, icon_name: "fire_truck", ),
              const SizedBox( height: 15 ),
              const AmbulanceProgressBox(),
              const Text( "Private Service Providers", style: TextStyle( 
                fontSize: 17.94,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor
               ), ),
              const SizedBox( height: 15 ),
              const AmbulanceListItem(place: "Life Link", location: 'Hospital, Naalya', time: '23 mins'),
              const SizedBox( height: 15 ),
              const AmbulanceListItem(place: "Frost Medical", location: 'Center, Wakiso', time: '11 mins'),
              const SizedBox( height: 15 ),
              const AmbulanceListItem(place: "Children", location: 'Clinic, Naalya', time: '30 mins'),
            ],
          ),
        ),
      )
    );
  }
}