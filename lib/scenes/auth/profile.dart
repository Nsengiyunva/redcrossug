import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/home_controller.dart';
import 'package:redcross/scenes/auth/profile_item.dart';
import 'package:redcross/scenes/auth/profile_list_item.dart';
import 'package:redcross/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context, rootNavigator: true).pushReplacementNamed('/login');

    // Navigator.pushReplacementNamed(context, '/login');
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (context) => SignIn()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

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
                  color: AppColors.blackColor),
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
                    ProfileItem(
                        name: homeController.fullName.value,
                        phone: homeController.phoneNumber.value),
                    const Icon(
                      Icons.arrow_right,
                      color: AppColors.primaryRedColor,
                      size: 15.51,
                    ),
                  ],
                )),
            const SizedBox(height: 15),
            Container(
                height: 470.16,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.08),
                    color: AppColors.whiteColor),
                child: Column(
                  children: [
                    ProfileListItem(label: 'Community', onPressed: () {}),
                    ProfileListItem(label: 'ID Verification', onPressed: () {}),
                    ProfileListItem(label: 'Payment Methods', onPressed: () {}),
                    ProfileListItem(
                        label: 'Security & Biometrics', onPressed: () {}),
                    ProfileListItem(label: 'Help & Support', onPressed: () {}),
                    ProfileListItem(
                        label: 'App Version & Info', onPressed: () {}),
                    ProfileListItem(
                        label: 'Log Out', onPressed: () => _logout(context))
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
