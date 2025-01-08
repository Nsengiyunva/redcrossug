import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/fa_service_list_item.dart';

class FirstAidEmergencies extends StatelessWidget {
  const FirstAidEmergencies({super.key});

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FC),
      appBar: AppBar(
        title: Text("First Aid Guide", style: TextStyle( fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF000000) ),),
        leading: BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20 ),
          child: Column(
            children: [
              FaServiceListItem(icon_name: 'alarm', label: 'Emergency',),
              SizedBox( height: 15 ),
              FaServiceListItem(icon_name: 'chest', label: 'Chest Discomfort',),
              SizedBox( height: 15 ),
              FaServiceListItem(icon_name: 'choking', label: 'Choking',),
              SizedBox( height: 15 ),
              FaServiceListItem(icon_name: 'radioactive', label: 'Poisoning',),
              SizedBox( height: 15 ),
              FaServiceListItem(icon_name: 'radioactive', label: 'Stroke',),
              SizedBox( height: 15 ),
              FaServiceListItem(icon_name: 'accident', label: 'General Accident',),
              SizedBox( height: 15 ),
              FaServiceListItem(icon_name: 'radioactive', label: 'Unconsciousness',),
              SizedBox( height: 15 ),
              FaServiceListItem(icon_name: 'bleeding', label: 'Bleeding/Cut',)
            ],
          )
          )
        ),
    );
  }
}