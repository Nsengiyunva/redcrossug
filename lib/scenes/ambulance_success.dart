import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/red_badge.dart';
import 'package:redcross/scenes/red_btn.dart';

class AmbulanceSuccess extends StatelessWidget {
  // final String button_label;
  // final String title;
  // final String success_message;

  const AmbulanceSuccess({super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text("Request Ambulance", style: TextStyle(
          fontSize: 16,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          color: Color(0xFF000000)
        ) ),
        leading: const BackButton() // Back button added here
      ),
      body: Container(
        padding: const EdgeInsets.symmetric( vertical: 25 ),
        child: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          const RedBadge(),
          const SizedBox( height: 20 ),
          const Center(
              child: Text(
                "Request Successful",
                textAlign: TextAlign.center,
                style: TextStyle( 
                  fontFamily: "Inter",
                  fontSize: 27.37, 
                  color: Color(0xFFED1C24), 
                  fontWeight: FontWeight.w700 
                ),
              ),
            ),
            const SizedBox( height: 15 ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Uniform padding of 16 pixels on all sides
              child: Center(
              child: Text(
                "Your Ambulance Request was successful",
                textAlign: TextAlign.center,
                style: TextStyle( 
                  fontSize: 19.07,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF000000),
                  fontFamily: "Inter"
                )
              ),
            ),
            ),
            const SizedBox( height: 30 ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 28 ),
              child: RedBtn( label: "Check Status", onPressed: () {
                Get.toNamed( "/check-ambulance_status" );
              }, ),
            )
         ],
       ),
      ),
      )
    );
  }
}