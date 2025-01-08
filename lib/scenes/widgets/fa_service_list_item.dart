import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaServiceListItem extends StatelessWidget {
  final String icon_name;
  final String label;

  FaServiceListItem({super.key, required this.icon_name, required this.label });

  @override
  Widget build(BuildContext context) {

    final iconMap = <String, IconData>{
      'alarm': Icons.access_alarms,
      'chest': Icons.bedroom_baby_sharp,
      'choking': Icons.face_6_rounded,
      'radioactive': Icons.replay_circle_filled_outlined,
      'bleeding': Icons.bloodtype,
      'accident': Icons.car_crash,
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return GestureDetector(
      onTap: (){
        Get.toNamed( "/first-aid-emergency-details" );
      },
      child: Container(
      height: 61,
      padding: EdgeInsets.symmetric( horizontal: 10 ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Color(0xFFFFE3E1),
              borderRadius: BorderRadius.circular( 10 )
            ),
            child: Center(
              child: Icon(
                iconData,
                color: Color(0xFFED1C24),
                size: 32.39,
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric( horizontal: 15 ),
            child: Text( "$label", style: TextStyle( fontSize: 17.74, fontFamily: "Inter", fontWeight: FontWeight.w500 ) )
          )
        ],
      ),
      ),
    );
  }
}