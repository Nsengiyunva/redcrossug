import 'package:flutter/material.dart';

class CardBoard extends StatelessWidget {
  final String title;
  final String icon_name;
  final VoidCallback onPressed;

  const CardBoard({ super.key, required this.title, required this.icon_name, required this.onPressed });

  @override
  Widget build(BuildContext context) {

    final iconMap = <String, IconData>{
      'blood_icon': Icons.bloodtype_rounded,
      'hospital': Icons.location_city,
      'ambulance': Icons.fire_truck_sharp,
      'disasters': Icons.storm_sharp,
      'membership': Icons.people_alt_sharp,
      'cash': Icons.money_sharp,

    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        width: 170,
        height: 115.84,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0 ),
        decoration: BoxDecoration(
          color: const Color(0xFFED1C24),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox( height: 20 ),
              Icon(
                iconData,
                color: Colors.white,
                size: 22.6,
              ),
            const SizedBox( height: 10 ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.55,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                color: Color(0xFFFFFFFF)
              ),
            )
              ],
        ),
      ),
    );
    
  }
}