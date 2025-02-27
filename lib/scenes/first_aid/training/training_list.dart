import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/user_training_controller.dart';
import 'package:redcross/scenes/widgets/fa_service_list_item.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class TrainingList extends StatelessWidget {
  TrainingList({super.key});
  final UserTrainingController trainingController =
      Get.put(UserTrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          title: const Text("Request Training",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.blackColor,
              )),
          leading: const BackButton() // Back button added here
          ),
      body: Obx(() {
        if (trainingController.isLoading.value) {
          return const Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 25),
                Text("Loading Trainings...")
              ],
            ),
          );
        }

        if (trainingController.trainings.length == 0) {
          return const Center(
            child: Column(
              children: [
                SizedBox(height: 25),
                Text("There are no trainings available at the moment.")
              ],
            ),
          );
        }

        return SingleChildScrollView(
            child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 30.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                        child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        maxWidth: 400,
                        minHeight: 50,
                        maxHeight: 400,
                      ),
                      child: ListView.builder(
                        itemCount: trainingController.filtered_list.length,
                        itemBuilder: (context, index) {
                          var item = trainingController.filtered_list[index];

                          return Column(
                            children: [
                              FaServiceListItem(
                                id: item["id"],
                                icon_name: 'training',
                                label: StorageService.truncateString(
                                    item["name"], 25),
                                forTraining: true,
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ))
                  ],
                )));
      }),
    );
  }
}
