import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/widgets/green_badge.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';

class AccountSuccess extends StatelessWidget {
  final String button_label;
  final String title;
  final String success_message;
  final bool changeColor;
  final bool? payment;

  AccountSuccess(
      {super.key,
      required this.button_label,
      required this.title,
      required this.success_message,
      required this.changeColor,
      this.payment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GreenBadge(changeColor: changeColor),
            const SizedBox(height: 20),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 23.12,
                    fontFamily: "Manrope",
                    color: AppColors.blackColorF,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(success_message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 13.18,
                        color: AppColors.blackColorL,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter")),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RedBtn(
                label: button_label,
                onPressed: () {
                  payment! ? Get.toNamed("/home") : Get.toNamed("/login");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
