import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/fa_service_list_item.dart';

class FirstAidEmergencies extends StatelessWidget {
  const FirstAidEmergencies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
          title: const Text(
            "First Aid Guide",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF000000)),
          ),
          leading: const BackButton() // Back button added here
          ),
      body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: Column(
                children: [
                  FaServiceListItem(
                    id: 1,
                    icon_name: 'alarm',
                    label: 'Emergency',
                    forTraining: false,
                  ),
                  const SizedBox(height: 15),
                  FaServiceListItem(
                    id: 2,
                    icon_name: 'chest',
                    label: 'Chest Discomfort',
                    forTraining: false,
                  ),
                  const SizedBox(height: 15),
                  FaServiceListItem(
                      id: 3,
                      icon_name: 'choking',
                      label: 'Choking',
                      forTraining: false),
                  const SizedBox(height: 15),
                  FaServiceListItem(
                      id: 4,
                      icon_name: 'radioactive',
                      label: 'Poisoning',
                      forTraining: false),
                  const SizedBox(height: 15),
                  FaServiceListItem(
                      id: 5,
                      icon_name: 'radioactive',
                      label: 'Stroke',
                      forTraining: false),
                  const SizedBox(height: 15),
                  FaServiceListItem(
                      id: 6,
                      icon_name: 'accident',
                      label: 'General Accident',
                      forTraining: false),
                  const SizedBox(height: 15),
                  FaServiceListItem(
                      id: 7,
                      icon_name: 'radioactive',
                      label: 'Unconsciousness',
                      forTraining: false),
                  const SizedBox(height: 15),
                  FaServiceListItem(
                      id: 8,
                      icon_name: 'bleeding',
                      label: 'Bleeding/Cut',
                      forTraining: false)
                ],
              ))),
    );
  }
}
