import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AmbulanceListItem extends StatelessWidget {
  const AmbulanceListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white38,
        border: Border.all(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10), 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                  padding: const EdgeInsets.all( 15 ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                  Icons.fire_truck_outlined,
                  color:Colors.red.shade800,
                  size: 45.0,
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding( 
                    padding: EdgeInsets.symmetric( horizontal: 5 ),
                    child: Text( 'Life Link Hospital', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black )) 
                  ) ,
                  Padding(
                    padding: EdgeInsets.symmetric( horizontal: 5 ), 
                    child: Text( 'Namugongo, Naalya', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black ) ),
                  )
                ],
              ),
            ],
          ),
          const Text( 'Second Part' )
        ],
      ),
    );
  }
}