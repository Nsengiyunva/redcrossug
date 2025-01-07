import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/green_badge.dart';
import 'package:redcross/scenes/red_btn.dart';

class AccountSuccess extends StatelessWidget {
  final String button_label;
  final String title;
  final String success_message;
  final bool changeColor;

  AccountSuccess({super.key, required this.button_label, required this.title, required this.success_message, required this.changeColor });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          GreenBadge( changeColor: changeColor ),
          const SizedBox( height: 20 ),
          Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle( fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold ),
                
              ),
            ),
            const SizedBox( height: 15 ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Uniform padding of 16 pixels on all sides
              child: Center(
              child: Text(
                success_message,
                textAlign: TextAlign.center,
                style: const TextStyle( fontSize: 24, )
              ),
            ),
            ),
            const SizedBox( height: 30 ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 28 ),
              child: RedBtn( label: button_label, onPressed: () {  
                Get.toNamed( "/home" );
              }, ),
            )
         ],
       ),
      ),
    );
  }
}