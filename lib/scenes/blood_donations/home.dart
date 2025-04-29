import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/widgets/disaster_list_item.dart';
import 'package:redcross/scenes/widgets/menu_list_items.dart';
import 'package:redcross/utils/colors.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final DisastersListController disasterController =
      Get.put(DisastersListController());

  String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const Text(""),
            leading: const BackButton() // Back button added here
            ),
        body: Obx(() {
          // if (disasterController.isLoading.value) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          // if (disasterController.disasters.isEmpty) {
          //   return const Center(
          //       child: Center(child: Text('No Disasters were found.')));
          // }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Blood Donations")],
            ),
          );
        }));
  }
}
