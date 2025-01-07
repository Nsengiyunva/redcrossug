import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_field.dart';
import 'package:redcross/controllers/login_controller.dart';

class AmbulanceHome extends StatelessWidget {
  AmbulanceHome({super.key});

  final LoginController _formController = Get.put( LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
          child: Column(
            children: [
              const Text( "Ambulance", style: TextStyle( fontSize: 30 ), ),
              
            ],
          ),
        ),
      )
    );
  }
}