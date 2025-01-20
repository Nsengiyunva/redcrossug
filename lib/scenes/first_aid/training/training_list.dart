import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/fa_service_list_item.dart';
import 'package:redcross/utils/colors.dart';

class TrainingList extends StatelessWidget {
  const TrainingList({super.key});

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Request Training", style: TextStyle( fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF000000) ),),
        leading: const BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20 ),
          child: Column(
            children: [
              FaServiceListItem(icon_name: 'training', label: 'First Aid Training at Work place', forTraining: true,),
              const SizedBox( height: 15 ),
               FaServiceListItem(icon_name: 'training', label: 'CPR Training', forTraining: true,),
              const SizedBox( height: 15 ),
               FaServiceListItem(icon_name: 'training', label: 'Basic First Aid Training', forTraining: true,),
              const SizedBox( height: 15 ),
               FaServiceListItem(icon_name: 'training', label: 'Standard First Aid Training', forTraining: true,),
              const SizedBox( height: 15 ),
               FaServiceListItem(icon_name: 'training', label: 'Refresher First Aid Training', forTraining: true, ),
              const SizedBox( height: 15 ),
               FaServiceListItem(icon_name: 'training', label: 'Basic Ambulance Management', forTraining: true, ),
              const SizedBox( height: 15 ),
               FaServiceListItem(icon_name: 'training', label: 'AED Training', forTraining: true,),
              const SizedBox( height: 15 ),
               FaServiceListItem(icon_name: 'training', label: 'Basic Fire Safety', forTraining: true, )
            ],
          )
          )
        ),
    );
  }
}