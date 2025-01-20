import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconCard extends StatelessWidget {
  final String icon_name;
  final String label;

  const IconCard({super.key, required this.icon_name, required this.label });

  @override
  Widget build(BuildContext context) {
    final iconMap = <String, IconData>{
      'add': Icons.add_a_photo_sharp,
      'hospital': Icons.location_city,
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return Container(
      width: 180,
      height: 93,
      decoration: BoxDecoration(
        color: const Color(0xFFFFDCDC),
        borderRadius: BorderRadius.circular( 15 )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: const Color(0xFFED1C24),
              size: 32.39,
            ),
            Padding(padding: const EdgeInsets.symmetric( vertical: 2 ),
            child: TextButton(
              onPressed: () {
                Get.toNamed( "/training-home" );
              },
              child: Text( label, style: const TextStyle( fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "Inter", color: Color(0xFFED1C24)  ) ),
              )
            )
          ],
        ),
      )
    );
  }
}