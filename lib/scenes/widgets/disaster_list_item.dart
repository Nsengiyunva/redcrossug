import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisasterListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String location;
  final String photo;
  final int id;

  const DisasterListItem({super.key, required this.id, required this.title, required this.subtitle, required this.date, required this.location, required this.photo });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed( "/disaster-details", arguments: {
          'title': title,
          'id': id
        } );
      },
      child: Container(
        height: 97,
        padding: const EdgeInsets.only( left: 10, right: 2 ),
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Container(
              width: 75,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: NetworkImage('https://picsum.photos/300'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
           Expanded(
            child: Container(
            // height: 120,
            padding: const EdgeInsets.symmetric( horizontal: 10 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding( 
                      padding: const EdgeInsets.only( right: 0 ), 
                      child:Text( title, style: const TextStyle( fontSize: 13.74, fontFamily: "Inter", fontWeight: FontWeight.w700, color: Color(0xFF000000)) ) 
                    ),
                    const Text( "|", style: TextStyle( fontSize: 13.74, fontFamily: "Inter", fontWeight: FontWeight.w700, color: Color(0xFF000000) ) ),
                    Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 2 ), 
                      child: Text( location, style: const TextStyle( fontSize: 13.74, fontFamily: "Inter", fontWeight: FontWeight.w700, color: Color(0xFF000000)) ),
                    ),
                  ],
                ),
                Text( subtitle, style: const TextStyle( fontSize: 11.37, fontFamily: "Inter", fontWeight: FontWeight.w400, color: Color(0xFF000000) ) ),
                const SizedBox( height: 5 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only( right: 5.0 ), 
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Color(0xFFED1C24),
                          size: 6.21,
                        ),
                        Padding(
                          padding: EdgeInsets.only( left: 1 ),
                          child: Text( 'Reported:', style: TextStyle( fontSize: 7.06, fontFamily: "Inter", fontWeight: FontWeight.w400, color: Color(0xFFED1C24) ) ),
                        )
                      ],
                      )
                    ),
                    Text( date, style: const TextStyle( fontSize: 7.06, fontFamily: "Inter", fontWeight: FontWeight.w700, color: Color(0xFF000000) ) )
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