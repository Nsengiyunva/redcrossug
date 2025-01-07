import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/text_field.dart';
import 'package:redcross/controllers/login_controller.dart';

class AmbulanceForm extends StatelessWidget {
  AmbulanceForm({super.key});

  final LoginController _formController = Get.put( LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Ambulance"),
        leading: BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
          child: Column(
            children: [
              const Text( "Emergency Information", style: TextStyle( fontSize: 30 ), ),
              const SizedBox( height: 25 ),
              TextFieldInput(question: 'No. of people hurt/in-need', textEditingController: _formController.noPeopleController, ),
              const SizedBox( height: 25 ),
              TextFieldInput(question: 'No. of ambulances required', textEditingController: _formController.noAmbulancesController, ),
              const SizedBox( height: 25 ),
              TextFieldInput(question: 'No. of emergency patients/Medical Risk', textEditingController: _formController.noPatientsController, ),
              const SizedBox( height: 25 ),
              RedBtn(label: "Continue", onPressed: () {
                 Get.toNamed('/ambulance-success-request');
              } )
            ],
          ),
        ),
      )
    );
  }
}