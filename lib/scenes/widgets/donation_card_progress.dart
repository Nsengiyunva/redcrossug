// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/utils/colors.dart';

class DonationCardProgress extends StatelessWidget {
  final currencyFormat = NumberFormat("#,##0.00", "en_US");

  final String target;
  final String funds_raised;
  double? progress;

  DonationCardProgress(
      {super.key,
      required this.target,
      required this.funds_raised,
      this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: LinearProgressIndicator(
              value: progress ?? 0.4,
              backgroundColor: Colors.grey[500],
              color: AppColors.primaryRedColor,
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              funds_raised ?? "350,000",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text("/",
                  style: TextStyle(
                      color: AppColors.greyColorG,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Inter")),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                target ?? "3,000,000",
                style: const TextStyle(
                    color: AppColors.greyColorG,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Inter"),
              ),
            ),
          ],
        )
      ],
    );
  }
}
