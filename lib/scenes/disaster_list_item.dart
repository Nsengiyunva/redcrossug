import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisasterListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String location;

  const DisasterListItem({super.key, required this.title, required this.subtitle, required this.date, required this.location });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed( "/disaster-details" );
      },
      child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: ExactAssetImage("assets/images/kasese_floods.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
           Expanded(child: Container(
            height: 120,
            padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding( 
                      padding: const EdgeInsets.only( right: 2 ), 
                      child:Text( title, style: const TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black) ) 
                    ),
                    const Text( "|", style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black) ),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 2 ), 
                      child: Text( location, style: const TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black) ),
                    ),
                  ],
                ),
                Text( subtitle, style: const TextStyle( fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black) ),
                const SizedBox( height: 5 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only( right: 5.0 ), 
                    child: Row(
                      children: [
                        Icon(
                          Icons.bloodtype_rounded,
                          color: Colors.red,
                          size: 10.0,
                        ),
                        Text( 'Reported:', style: TextStyle( fontSize: 10, fontWeight: FontWeight.normal, color: Colors.red) )
                      ],
                    )
                    ),
                    Text( date, style: const TextStyle( fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black) )
                  ],
                )
              ],
            ),
           ))
        ]
      )
     ),
    );
  }
}