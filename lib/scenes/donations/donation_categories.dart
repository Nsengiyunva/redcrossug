// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/donations_controller.dart';
import 'package:redcross/scenes/blood_donations/drive_details.dart';
import 'package:redcross/scenes/widgets/back_button_text.dart';
import 'package:redcross/scenes/widgets/donation_listing_item.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class DonationCategories extends StatefulWidget {
  const DonationCategories({super.key});

  @override
  State<DonationCategories> createState() => _DonationCategoriesState();
}

class _DonationCategoriesState extends State<DonationCategories> {
  final DonationsController _donations_controller =
      Get.put(DonationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
            title: const BackButtonText(),
            leading: const BackButton() // Back button added here
            ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: Obx(() {
              return Column(
                children: _donations_controller.causes_list.map((donation) {
                  print(donation!['funds_raised']);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: DonationListingItem(
                      title: donation!['title'],
                      target: donation!['target'],
                      funds_raised: donation!['funds_raised'],
                      subtitle: StorageService.truncateString(
                          donation!['description'], 25),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DriveDetails()),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            }),
          ),
        ));
  }
}
