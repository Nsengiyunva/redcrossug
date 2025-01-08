import 'package:flutter/material.dart';

class FirstAidDetails extends StatelessWidget {
  const FirstAidDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text("Bleeding / Cut", style: TextStyle( fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w600, color: Color(0xFF000000) )),
        leading: const BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25 ),
          child: Container(
            height: 591,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric( vertical: 10 ),
                child: Image.asset( 'assets/images/fa_kit.png', width: 168, height: 130 )
               ),

              ],
            ),
          )
          )
        ),
    );
  }
}