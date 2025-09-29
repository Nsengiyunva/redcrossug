import 'package:flutter/material.dart';
import 'package:redcross/scenes/auth/account_success.dart';
import 'package:redcross/scenes/blood_donations/blood_donation_success.dart';
import 'package:redcross/scenes/widgets/back_button_text.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class BloodEligibility extends StatefulWidget {
  const BloodEligibility({super.key});

  @override
  State<BloodEligibility> createState() => _BloodEligibilityState();
}

class _BloodEligibilityState extends State<BloodEligibility> {
  final List<Item> _items = <Item>[
    Item(header: 'Platelet Donation', body: [
      'Donation frequency: Every 56 days, up to 6 times a year',
      'You must be in good health and feeling well',
      'You must be at least 16 years old in most states',
      'You must weigh at least 50 kgs',
      'You must be HIV/AIDS negative'
    ]),
    Item(header: 'Whole Blood Donation', body: [
      'Donation frequency: Every 56 days, up to 6 times a year',
      'You must be in good health and feeling well',
      'You must be at least 16 years old in most states',
      'You must weigh at least 50 kgs',
      'You must be HIV/AIDS negative'
    ]),
    Item(header: 'Plasma Donation', body: [
      'Donation frequency: Every 56 days, up to 6 times a year',
      'You must be in good health and feeling well',
      'You must be at least 16 years old in most states',
      'You must weigh at least 50 kgs',
      'You must be HIV/AIDS negative'
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: BackButtonText(),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Text(
              "Blood",
              style: TextStyle(
                  fontSize: 26.33,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryRedColor,
                  height: StorageService.getHeight(28, 26),
                  letterSpacing: StorageService.getSpacing(26)),
            ),
            const SizedBox(height: 5),
            Text(
              "Donation Eligibility",
              style: TextStyle(
                  fontSize: 26.33,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                  color: AppColors.blackColor,
                  height: StorageService.getHeight(28, 26),
                  letterSpacing: StorageService.getSpacing(26)),
            ),
            const SizedBox(height: 15),

            // 🔹 Sub heading
            Text(
              "Next Eligible donation date:",
              style: TextStyle(
                fontSize: 14.4,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
                height: StorageService.getHeight(24, 14),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Saturday, July 10th, 2025",
              style: TextStyle(
                  fontSize: 14.4,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: AppColors.greyColorB,
                  height: StorageService.getHeight(24, 14)),
            ),
            const SizedBox(height: 50),

            ..._items.map((item) {
              return CustomExpandableTile(item: item);
            }),

            // const SizedBox(height: 25),
            // RedBtn(
            //   label: 'Continue',
            //   onPressed: () {
            //     // Get.toNamed("/blood-donation-eligibility");
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //           builder: (context) => const BloodDonationSuccess()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class CustomExpandableTile extends StatefulWidget {
  final Item item;
  const CustomExpandableTile({super.key, required this.item});

  @override
  State<CustomExpandableTile> createState() => _CustomExpandableTileState();
}

class _CustomExpandableTileState extends State<CustomExpandableTile>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.only(bottom: 15),
            height: 61,
            width: 348,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(color: Colors.red, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        width: 42,
                        height: 42,
                        margin: const EdgeInsets.only(left: 2, top: 2),
                        decoration: BoxDecoration(
                            color: AppColors.redColorM,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Icon(Icons.water_drop_outlined,
                                size: 27, color: AppColors.primaryRedColor))),
                    const SizedBox(width: 10),
                    Text(
                      widget.item.header,
                      style: TextStyle(
                          fontSize: 16.36,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColor,
                          height: StorageService.getHeight(20, 16),
                          letterSpacing: StorageService.getSpacing(16)),
                    ),
                  ],
                ),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0, // 180° when expanded
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 28,
                    color: AppColors.primaryRedColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(
            children: widget.item.body
                .map(
                  (text) => ListTile(
                    contentPadding: const EdgeInsets.only(left: 40, right: 10),
                    tileColor: AppColors.whiteColor,
                    title: Row(
                      children: [
                        const Text(
                          "• ",
                          style: TextStyle(
                            fontSize: 20, // bigger bullet
                            height: 1, // aligns well with text
                          ),
                        ),
                        Expanded(
                          child: Text(
                            text,
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 11.75,
                                fontWeight: FontWeight.w300,
                                color: AppColors.blackColorG,
                                height: StorageService.getHeight(15, 12),
                                letterSpacing: StorageService.getSpacing(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          crossFadeState:
              _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}

class Item {
  final String header;
  final List<String> body;
  Item({required this.header, required this.body});
}
