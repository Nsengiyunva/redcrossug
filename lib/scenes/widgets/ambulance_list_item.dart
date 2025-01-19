import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/tag_item.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceListItem extends StatelessWidget {
  final String place;
  final String location;
  final String time;

  const AmbulanceListItem({super.key, required this.place, required this.location, required this.time });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, 
      decoration: BoxDecoration(
        color: Colors.white,
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
                  margin: const EdgeInsets.only( left: 10, right: 5  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE3E1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                  Icons.fire_truck_sharp,
                  color:AppColors.primaryRedColor,
                  size: 15,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding( 
                    padding: const EdgeInsets.symmetric( horizontal: 5 ),
                    child: Text( place, style: const TextStyle( 
                      fontSize: 12, 
                      fontWeight: FontWeight.w600, 
                      color: Color(0xFF000000),
                      fontFamily: "Inter"
                      )
                    ) 
                  ) ,
                  Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 5 ), 
                    child: Text( location, style: const TextStyle( 
                      fontSize: 12, 
                      fontWeight: FontWeight.w600, 
                      color: Color(0xFF000000),
                      fontFamily: "Inter"
                      ) 
                    ),
                  )
                ],
              ),
            ],
          ),
          const TagItem(label: 'Contact', height: 25.58, width: 64.15 )
          // Row(
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.symmetric( horizontal: 2 ), 
          //       child: Text( 'Est:', style: TextStyle( 
          //         fontSize: 13.66, 
          //         fontWeight: FontWeight.w400, 
          //         color: Color(0xFF000000),
          //         fontFamily: "Inter"
          //        ) ) 
          //     ),
          //      Padding(
          //       padding: const EdgeInsets.symmetric( horizontal: 2 ), 
          //       child: Text( time, style: const TextStyle( 
          //         fontSize: 13.66, 
          //         fontWeight: FontWeight.w600, 
          //         color: Color(0xFF000000),
          //         fontFamily: "Inter"
          //       ) ) 
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}