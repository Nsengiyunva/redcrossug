import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';

class BleedingCutPage3 extends StatelessWidget {
  const BleedingCutPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25 ),
          child: Container(
            height: 591,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const SizedBox( height: 15 ),
                Image.asset( 'assets/images/fa_kit.png', width: 168, height: 130 ),
                const SizedBox( height: 30 ),
                const Column(
                  children: [
                    Text( "Find the First Aid Kit:", style: TextStyle(
                      fontSize: 11.37,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold
                    ) ),
                    Text( "Locate the kit and make sure it contains the essentials.",style: TextStyle(
                      fontSize: 11.37,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700
                    ), ),
                  ],
                ),
               const SizedBox( height: 30 ),
               Image.asset( 'assets/images/fa_frame.png', width: 255, height: 113.99 ),
               const SizedBox( height: 15 ),
               RedBtn(label: 'Next', onPressed: () {}, squared: true, )
              ],
            ),
          )
          );
  }
}