import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/training_box_img.dart';

class TrainingHome extends StatelessWidget {
  const TrainingHome({super.key});

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
            children: [
              Row(
                children: [
                  TrainingBoxImg()
                ]
              )
            ],
          )
          )
        ),
    );
  }
}