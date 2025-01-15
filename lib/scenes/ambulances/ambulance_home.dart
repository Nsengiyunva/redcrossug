import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/widgets/ambulance_list_item.dart';
import 'package:redcross/scenes/widgets/red_btn_icon.dart';

class AmbulanceHome extends StatelessWidget {
  AmbulanceHome({super.key});

  final LoginController _formController = Get.put( LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton() // Back button added here
      ),
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
              const SizedBox( height: 15 ),
              RedBtnIcon(noColor: true, label: "Ambulance for Status", onPressed: () {}, icon_name: "fire_truck", ),
              const SizedBox( height: 15 ),
              const Text( "Ambulances Near Me", style: TextStyle( 
                fontSize: 17.94,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                color: Color(0xFF000000)
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