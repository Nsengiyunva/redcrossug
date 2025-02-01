import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';

class BasicTrainingDetails extends StatelessWidget {
  const BasicTrainingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Basic Aid Training", style: TextStyle( fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF000000) ),),
        leading: const BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20 ),
          child: Column(
            children: [
              Container(
                width: 319, // Set the container width
                height: 270, // Set the container height
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Background color
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Ensure image follows corners
                  child:  Image.asset( 
                    'assets/images/basic_1.png', 
                    width: 319, height: 270 
                  ),
                ),
            ),
            const SizedBox( height: 10 ),
            const Center(
              child: Text( "Duration: 2 Days", style: TextStyle(
              fontFamily: "Inter",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColorB
            ) )
            ),
            const SizedBox( height: 10 ),
            const Center(
              child: Padding(padding: EdgeInsets.symmetric( horizontal: 5, vertical: 5 ),
              child: Text( "URCS first aid training classes give you the information and the skills you need to help adults and children during many emergency situations. Our first aid training delivers the latest information using skills-based training.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Inter",
                  color: AppColors.blackColorC,
                  fontWeight: FontWeight.w400
                ), ),),
            ),
             const SizedBox( height: 10 ),
             RedBtn(label: 'Request for Training', onPressed: () {
              Get.toNamed( "/home" );
             } )
            ],
          )
          )
        ),
    );
  }
}