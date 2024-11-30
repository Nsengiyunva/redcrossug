import 'package:flutter/material.dart';
import 'package:redcross/scenes/card_board.dart';
import 'package:redcross/scenes/home_badge.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          // padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: const Column(
             children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10 ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( "Good afternoon",  style: TextStyle( fontSize: 20, color: Colors.black ) ),
                      Text( "Garvin John Wick", style: TextStyle( fontSize: 24, color: Colors.black ) )
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
               SizedBox( height: 10 ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardBoard( title: "Blood Donation", icon_name: "blood_icon",  ),
                  CardBoard( title: "First Aid", icon_name: "hospital" ),
                ],
               ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardBoard( title: "Ambulance", icon_name: "ambulance" ),
                  CardBoard( title: "Disasters", icon_name: "disasters" ),
                ],
               ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardBoard( title: "Memberships", icon_name: "membership" ),
                  CardBoard( title: "Donations", icon_name: "cash" ),
                ],
               ),
               SizedBox( height: 15 ),
               Padding(padding: EdgeInsets.symmetric( horizontal: 20.0 ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upcoming Events', style: TextStyle( fontSize: 16 )),
                  Text('See All', style: TextStyle( fontSize: 16 ) )
                ],
               )
               ),
               Row(
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