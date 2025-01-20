import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/login_controller.dart';
import 'package:redcross/scenes/widgets/form_textfield.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceForm extends StatelessWidget {
  AmbulanceForm({super.key});

  final LoginController _formController = Get.put( LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Request Ambulance", style: TextStyle(
          fontSize: 16,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor
        ) ),
        leading: const BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text( "Emergency Information", style: TextStyle( 
                fontSize: 20.14,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w600,
                color: Color(0xFF545454)
              ), ),
              const SizedBox( height: 25 ),
              FormTextfield( question: 'No. of people hurt/in-need', textEditingController: _formController.noPeopleController, ),
              const SizedBox( height: 25 ),
              FormTextfield( question: 'No. of ambulances required', textEditingController: _formController.noAmbulancesController, ),
              const SizedBox( height: 25 ),
              FormTextfield( question: 'No. of emergency patients/Medical Risk', textEditingController: _formController.noPatientsController, ),
              const SizedBox( height: 25 ),
              const Row(
              children: [
                Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.whiteColorB,
                  size: 24.0,
                ),
                Text( "By continuing, you accept our privacy policy", style: TextStyle( 
                  fontWeight: FontWeight.w500, 
                  fontFamily: "Inter", 
                  fontSize: 10, 
                  color: AppColors.greyColorC 
                ) ),
              ],
            ),
            const SizedBox( height: 15 ),
            RedBtn(label: "Continue", onPressed: () {
                // Get.toNamed('/ambulance-success-request');
                Get.toNamed( '/ambulance-map' );
            } )
            ],
          ),
        ),
      )
    );
  }
}