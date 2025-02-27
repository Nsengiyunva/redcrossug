import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/user_training_controller.dart';
import 'package:redcross/utils/colors.dart';

class FaServiceListItem extends StatelessWidget {
  final String icon_name;
  final String label;
  final int id;
  bool? forTraining;

  FaServiceListItem(
      {super.key,
      required this.icon_name,
      required this.label,
      required this.id,
      this.forTraining});

  @override
  Widget build(BuildContext context) {
    final iconMap = <String, IconData>{
      'alarm': Icons.access_alarms,
      'chest': Icons.bedroom_baby_sharp,
      'choking': Icons.face_6_rounded,
      'radioactive': Icons.replay_circle_filled_outlined,
      'bleeding': Icons.bloodtype,
      'accident': Icons.car_crash,
      'training': Icons.card_giftcard_sharp
    };

    final iconData = iconMap[icon_name] ?? Icons.error;

    final UserTrainingController trainingController =
        Get.put(UserTrainingController());

    return GestureDetector(
      onTap: () {
        // print("here ${forTraining}");
        forTraining!
            ? trainingController.fetchTrainingDetails(id)
            : Get.toNamed("/first-aid-item-details");
      },
      child: Container(
        height: 61,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                  color: AppColors.redColorC,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Icon(
                iconData,
                color: AppColors.redColorA,
                size: 32.39,
              )),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 17.74,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500)))
          ],
        ),
      ),
    );
  }
}
