import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          Image.asset( 'assets/images/redcross_main.png', width: 800, height: 800 )
         ],
       ),
      ),
    );
  }
}