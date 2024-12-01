import 'package:flutter/material.dart';
import 'package:redcross/scenes/donation_progress.dart';
import 'package:redcross/scenes/red_btn.dart';

class DisasterDetails extends StatelessWidget {
  const DisasterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                      image: ExactAssetImage("assets/images/kasese_floods.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox( height: 5 ),
            Padding(
              padding: EdgeInsets.symmetric( vertical: 5, horizontal: 20 ),
              child: Text( "Kasese Floods", style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black ), ),
            ),
            SizedBox( height: 10 ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 20 ),
              child: Text( "Heavy rainfall has caused severe flooding, resulting in widespread destruction. Homes, bridges, and roads have been damaged, and many families have been displaced. Emergency teams are on the ground providing aid, but additional support is urgently needed.",
              style: TextStyle( fontSize: 14, color: Colors.black ), ),
            ),
            SizedBox( height: 25 ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 20.0 ),
              child: DonationProgress(),
            ),
            SizedBox( height: 25 ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
              child: RedBtn( label: 'Donate to Emergency' )
            )
            ],
          ),
        ),
      ),
    );
  }
}