import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:redcross/controllers/user_training_controller.dart';
import 'package:redcross/scenes/widgets/training_box_img.dart';
import 'package:redcross/utils/colors.dart';

class TrainingHome extends StatelessWidget {
  TrainingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          title: const Text("Request Training",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.blackColor,
              )),
          leading: const BackButton() // Back button added here
          ),
      body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: const Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TrainingBoxImg(
                            category: "family",
                            label: 'For Families',
                            img: 'assets/images/training_1.png'),
                        TrainingBoxImg(
                            category: "individual",
                            label: 'For Individuals',
                            img: 'assets/images/training_2.png')
                      ]),
                  SizedBox(height: 25),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TrainingBoxImg(
                            category: "organization",
                            label: 'For Organizations',
                            img: 'assets/images/training_3.png'),
                        TrainingBoxImg(
                            category: "schools",
                            label: 'First Aid in Schools',
                            img: 'assets/images/training_4.png')
                      ])
                ],
              ))),
    );
  }
}
