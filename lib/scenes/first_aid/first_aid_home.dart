import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/icon_card.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';

class FirstAidHome extends StatelessWidget {
  const FirstAidHome({super.key});

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
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text( "First Aid", style: TextStyle( fontFamily: "Inter", fontSize: 26.33, fontWeight: FontWeight.w700 ), ),
              const SizedBox( height: 30 ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconCard(icon_name: 'add', label: "First Aid Guide" ),
                  IconCard(icon_name: 'hospital', label: "Request Training")
                ],
              ),
              const SizedBox( height: 5 ),
              RedBtn( label: 'Call for Emergency Services', onPressed: () {
                Get.toNamed( "/first-aid-emergency-services" );
              } )
            ],
            ),
          )
        ),
    );
  }
}