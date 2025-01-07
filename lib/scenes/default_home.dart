import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/card_board.dart';
import 'package:redcross/scenes/home_badge.dart';

class DefaultHome extends StatelessWidget {
  DefaultHome({super.key});

  var isLogin = false.obs;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          // padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Column(
             children: [
               const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10 ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( "Good afternoon",  style: TextStyle( fontSize: 20, color: Colors.black ) ),
                      Text( "Anthony Blinked", style: TextStyle( fontSize: 24, color: Colors.black ) )
                    ],
                  ),
                  ),
                  Padding(padding: EdgeInsets.symmetric( horizontal: 15 ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.black,
                        size: 36.0,
                      )
                    ],
                  ),
                  )
                ],
               ),
               const SizedBox( height: 10 ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardBoard( title: "Blood Donation", icon_name: "blood_icon", onPressed: () {}  ),
                  CardBoard( title: "First Aid", icon_name: "hospital", onPressed: () {} ),
                ],
               ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardBoard( title: "Ambulance", icon_name: "ambulance", onPressed: () {
                    Get.toNamed('/ambulances-home');
                  }, ),
                  CardBoard( title: "Disasters", icon_name: "disasters", onPressed: () { 
                    Get.toNamed('/disasters');
                  },  ),
                ],
               ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardBoard( title: "Memberships", icon_name: "membership", onPressed: () {} ),
                  CardBoard( title: "Donations", icon_name: "cash", onPressed: () {} ),
                ],
               ),
               const SizedBox( height: 15 ),
               const Padding(padding: EdgeInsets.symmetric( horizontal: 20.0 ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upcoming Events', style: TextStyle( fontSize: 16 )),
                  Text('See All', style: TextStyle( fontSize: 16 ) )
                ],
               )
               ),
               const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomeBadge(title: 'Annual Red Cross Gala',  icon_name: "blood_icon" ),
                  HomeBadge(title: 'World Blood Donor Day', icon_name: "gala" )
                ],
               )
             ],
          ),
          ),
        )
      );
  }
} 