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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2 ),
            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0 ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE5E5),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 10 ),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               SizedBox(
                width: 100,
                child:  Text( title, style: const TextStyle( 
                  fontSize: 12.36, 
                  fontWeight: FontWeight.w600,
                  fontFamily: "Manrope",
                  color: Color(0xFF000000)
                )  ),
               ),
               Icon(
                iconData,
                color: const Color(0xFFED1C24),
                size: 53.74,
              ),
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