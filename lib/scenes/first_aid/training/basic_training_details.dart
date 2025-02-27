import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/user_training_controller.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';

class BasicTrainingDetails extends StatelessWidget {
  BasicTrainingDetails({super.key});

  final UserTrainingController trainingController =
      Get.put(UserTrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          title: const Text(
            "Basic Aid Training",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.blackColor),
          ),
          leading: const BackButton()),
      body: Obx(() {
        if (trainingController.isFetching.value) {
          return Container(
            child: const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 25),
                  Text("Loading Training Details...")
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
            child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 30.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                        "${trainingController.training_details["training"]["name"]}",
                        style: TextStyle(
                            fontFamily: "Inter",
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w800)),
                    SizedBox(height: 15),
                    Container(
                      width: 319, // Set the container width
                      height: 270, // Set the container height
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Background color
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15), // Ensure image follows corners
                        child: Image.network(
                          width: 319,
                          height: 270,
                          '${trainingController.training_details["training"]["image_url"]}',
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Text("Failed to load image");
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                        child: Text(
                            "Duration: ${trainingController.training_details["training"]["duration"]}",
                            style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackColorB))),
                    const SizedBox(height: 10),
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "${trainingController.training_details["training"]["description"]}",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Inter",
                              color: AppColors.blackColorC,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    RedBtn(
                        label: 'Request for Training',
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0)),
                            ),
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                height: 500,
                                child: Column(
                                  children: [
                                    Text(
                                        "Number of Participants: ${trainingController.training_details["number_of_participants"]}"),
                                    const SizedBox(height: 15),
                                    Text(
                                        "Date of Training: ${trainingController.training_details["start_date"]}"),
                                    const SizedBox(height: 15),
                                    Text(
                                        "Training Fee: ${trainingController.training_details["payment_amount"]}"),
                                    const SizedBox(height: 15),
                                    RedBtn(
                                        label: 'Proceed',
                                        onPressed: () {
                                          trainingController
                                              .trainingApplication(
                                            trainingController.training_details[
                                                "training"]["id"],
                                            trainingController
                                                .training_details["start_date"],
                                            trainingController.training_details[
                                                "number_of_participants"],
                                          );
                                        })
                                  ],
                                ),
                              );
                            },
                          );
                        })
                  ],
                )));
      }),
    );
  }
}
