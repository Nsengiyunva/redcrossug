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
      'local_police': Icons.lightbulb_outline,
      'fire_truck': Icons.fire_truck,
    };
    
     final iconData = iconMap[icon_name] ?? Icons.error;

    return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                onPressed: onPressed,
                style: noColor ? ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFED1C24), width: 2), // Border color and width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular( 5 ), // Optional: Rounded corners
                  ),
                   backgroundColor: Colors.white,
                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15 ),
                ) :  ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular( 5 )
              ),
              backgroundColor: const Color(0xFFED1C24),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15 ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    color: noColor ? const Color(0xFFED1C24) : Colors.white,
                    size: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only( left: 10 ),
                    child: SizedBox(
                      child: noColor ? Text( label , style: const TextStyle( 
                      fontSize: 12, 
                      fontWeight: FontWeight.w700,
                      fontFamily: "Inter",
                      color: Color(0xFFED1C24)
                    ) ) : 
                    Text( label , style: const TextStyle( 
                      fontSize: 12, 
                      fontWeight: FontWeight.w700,
                      fontFamily: "Inter",
                      color: Color(0xFFFFFFFF),
                     )
                    )
                    ) ,
                    )
              ],)
            ),
          )
          ]
        );
    }


    // Row(
    //           children: [
    //             Icon(
    //               iconData,
    //               color: noColor ? const Color(0xFFED1C24) : Colors.white,
    //               size: 24.0,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric( horizontal: 8 ),
    //               child: noColor ? Text( label , style: const TextStyle( 
    //                   fontSize: 12, 
    //                   fontWeight: FontWeight.w700,
    //                   fontFamily: "Inter",
    //                   color: Color(0xFFED1C24)
    //                 ) ) : Text( label , style: const TextStyle( 
    //                   fontSize: 12, 
    //                   fontWeight: FontWeight.w700,
    //                   fontFamily: "Inter",
    //                   color: Color(0xFFFFFFFF),

    //                 ) 
    //               ),
    //             )
    //           ],
    //         )
}