import 'package:flutter/material.dart';
import 'package:redcross/scenes/green_badge.dart';
import 'package:redcross/scenes/red_btn.dart';

class AccountSuccess extends StatelessWidget {
  const AccountSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          GreenBadge(),
          SizedBox( height: 5 ),
          Center(
              child: Text(
                'Welcome Aboard',
                textAlign: TextAlign.center,
                style: TextStyle( fontSize: 36, )
              ),
            ),
            SizedBox( height: 10 ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Uniform padding of 16 pixels on all sides
              child: Center(
              child: Text(
                'Your account has been created successfully, check your email for confirmation',
                textAlign: TextAlign.center,
                style: TextStyle( fontSize: 24, )
              ),
            ),
            ),
            SizedBox( height: 10 ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 28 ),
              child: RedBtn(),
            )
         ],
       ),
      ),
    );
  }
}