import 'package:flutter/material.dart';

class CardBoard extends StatelessWidget {
  final String title;
  final String icon_name;

  const CardBoard({ super.key, required this.title, required this.icon_name });

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

    return Container(
            width: 180,
            height: 120,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0 ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox( height: 20 ),
                  Icon(
                    iconData,
                    color: Colors.white,
                    size: 36.0,
                  ),
                const SizedBox( height: 10 ),
                Text(
                 title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )
                  ],
            ),
          );
  }
}