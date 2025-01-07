import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/ambulance_status_item.dart';

class AmbulanceStatus extends StatelessWidget {
  AmbulanceStatus({super.key});

  final LoginController _formController = Get.put( LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ambulance Status"),
        leading: const BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
          child: Column(
            children: [
              Center(
                child: Image.asset( 'assets/images/ambulance.png', width: 300, height: 300 ),
              ),
              AmbulanceStatusItem(label: 'Status', noComponent: true, value: ""),
              const SizedBox( height: 25 ),
              AmbulanceStatusItem(label: 'Number of Ambulances', noComponent: false, value: "01"),
              const SizedBox( height: 25 ),
              AmbulanceStatusItem(label: 'Ambulances', noComponent: false, value: "Red Cross Nakasero" ),
            ],
          ),
        ),
      )
    );
  }
}