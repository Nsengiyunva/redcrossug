import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AmbulanceListItem extends StatelessWidget {
  final String place;
  final String location;
  final String time;

  AmbulanceListItem({super.key, required this.place, required this.location, required this.time });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10), 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                  padding: const EdgeInsets.all( 10 ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                  Icons.fire_truck_sharp,
                  color:Colors.red.shade800,
                  size: 45.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding( 
                    padding: EdgeInsets.symmetric( horizontal: 5 ),
                    child: Text( place, style: TextStyle( fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black )) 
                  ) ,
                  Padding(
                    padding: EdgeInsets.symmetric( horizontal: 5 ), 
                    child: Text( '$location', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black ) ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric( horizontal: 2 ), 
                child: Text( 'Est:', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w200, color: Colors.black ) ) 
              ),
               Padding(
                padding: EdgeInsets.symmetric( horizontal: 2 ), 
                child: Text( '$time', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black ) ) 
              )
            ],
          )
        ],
      ),
    );
  }
}