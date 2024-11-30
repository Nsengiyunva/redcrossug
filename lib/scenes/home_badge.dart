import 'package:flutter/material.dart';

class HomeBadge extends StatelessWidget {
  final String title;
  final String icon_name;

  const HomeBadge({ super.key, required this.title, required this.icon_name });

  @override
  Widget build(BuildContext context) {

    final iconMap = <String, IconData>{
      'blood_icon': Icons.bloodtype_rounded,
      'gala': Icons.safety_check,

    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return Container(
            width: 180,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0 ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 213, 211),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric( vertical: 10.0 ),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text( 'Annual Red' ),
                    Text( 'Cross Gala' ),
                    Text( 'and Fundraiser' )
                  ],
                ),
                Center(
                  child: Icon(
                    iconData,
                    color: Colors.red,
                    size: 60.0,
                  ),
                )
              ],
             ),
            )
          );
  }
}

// Column(
//               children: [
//                 const SizedBox( height: 20 ),
//                   Icon(
//                     iconData,
//                     color: Colors.white,
//                     size: 36.0,
//                   ),
//                 const SizedBox( height: 10 ),
//                 Text(
//                  title,
//                   style: const TextStyle(color: Colors.white, fontSize: 18),
//                 )
//                   ],
//             ),