import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/ambulance_status_btn.dart';
import 'package:redcross/utils/colors.dart';

class AmbulanceProgressBox extends StatelessWidget {
  const AmbulanceProgressBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
      margin: const EdgeInsets.symmetric( vertical: 10 ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular( 9 )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text( "Ambulance Status" ),
          const SizedBox( height: 10 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AmbulanceStatusBtn( label: 'Pending', fillColor: AppColors.primaryRedColor, ),
              AmbulanceStatusBtn( label: 'Confirmed', fillColor: AppColors.greyColorA ),
              AmbulanceStatusBtn( label: 'On its way', fillColor: AppColors.greyColorA )
            ],
          )
        ],
      )
    );
  }
}