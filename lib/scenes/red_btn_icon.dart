import 'package:flutter/material.dart';

class RedBtnIcon extends StatelessWidget {
  final String label;
  final bool noColor;
  final VoidCallback onPressed;
  final String icon_name;

  

  const RedBtnIcon({super.key, required this.label, required this.onPressed, required this.icon_name, required this.noColor });
  

  @override
  Widget build(BuildContext context) {

    final iconMap = <String, IconData>{
      'local_police': Icons.local_police,
      'fire_truck': Icons.fire_truck,
    };
    
     final iconData = iconMap[icon_name] ?? Icons.error;

    return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                onPressed: onPressed,
                style: noColor ? ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.red, width: 2), // Border color and width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular( 5 ), // Optional: Rounded corners
                  ),
                   backgroundColor: Colors.white,
                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15 ),
                ) :  ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular( 5 )
              ),
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15 ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: noColor ? Colors.red : Colors.white,
                  size: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 8 ),
                  child: noColor ? Text( label , style: const TextStyle( fontSize: 20, color: Colors.red ) ) : Text( label , style: const TextStyle( fontSize: 20, color: Colors.white ) 
                  ),
                )
              ],
            ),
          )
          ]
        );
    }
}