import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/auth/profile_item.dart';
import 'package:redcross/scenes/auth/profile_list_item.dart';
import 'package:redcross/scenes/widgets/icon_card.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.peachColor,
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 30.0),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Account",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 23.88,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(height: 30),
            Container(
                height: 126.97,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.08),
                    color: AppColors.whiteColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileItem(),
                    Icon(
                      Icons.arrow_right,
                      color: AppColors.primaryRedColor,
                      size: 15.51,
                    ),
                  ],
                )),
            SizedBox(height: 15),
            Container(
                height: 470.16,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.08),
                    color: AppColors.whiteColor),
                child: Column(
                  children: [ProfileListItem(), ProfileListItem()],
                ))
          ],
        ),
      )),
    );
  }
}
