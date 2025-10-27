import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/donations/donation_categories.dart';
import 'package:redcross/scenes/home_badge.dart';
import 'package:redcross/scenes/widgets/donation_badge.dart';
import 'package:redcross/scenes/widgets/donation_history_item.dart';
import 'package:redcross/scenes/widgets/nav_list_items.dart';
import 'package:redcross/scenes/widgets/picture_badge.dart';
import 'package:redcross/utils/colors.dart';

class VolunteerTracking extends StatelessWidget {
  const VolunteerTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
          child: Text("Volunteer Tracking"),
        )));
  }
}
