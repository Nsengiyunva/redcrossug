import 'package:flutter/material.dart';
import 'package:redcross/scenes/green_badge.dart';
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
      appBar: AppBar(
        title: Text("Request Ambulance"),
        leading: BackButton() // Back button added here
      ),
      body: Container(
        padding: EdgeInsets.symmetric( vertical: 25 ),
        child: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          const RedBadge(),
          const SizedBox( height: 20 ),
          Center(
              child: Text(
                "Request Successful",
                textAlign: TextAlign.center,
                style: const TextStyle( fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold ),
                
              ),
            ),
            const SizedBox( height: 15 ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Uniform padding of 16 pixels on all sides
              child: Center(
              child: Text(
                "Your Ambulance Request was successful",
                textAlign: TextAlign.center,
                style: const TextStyle( fontSize: 24, )
              ),
            ),
            ),
            const SizedBox( height: 30 ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 28 ),
              child: RedBtn( label: "Check Status", onPressed: () {  }, ),
            )
         ],
       ),
      ),
      )
    );
  }
}