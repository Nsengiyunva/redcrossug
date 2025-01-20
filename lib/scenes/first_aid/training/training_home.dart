import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/training_box_img.dart';
import 'package:redcross/utils/colors.dart';

class TrainingHome extends StatelessWidget {
  const TrainingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Request Training", style: TextStyle( fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF000000) ),),
        leading: const BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20 ),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TrainingBoxImg( label: 'For Families', img: 'assets/images/training_1.png'),
                  TrainingBoxImg( label: 'For Individuals', img: 'assets/images/training_2.png' )
                ]
              ),
              SizedBox( height: 25 ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TrainingBoxImg( label: 'For Organizations', img: 'assets/images/training_3.png'),
                  TrainingBoxImg( label: 'First Aid in Schools', img: 'assets/images/training_4.png' )
                ]
              )
            ],
          )
          )
        ),
    );
  }
}