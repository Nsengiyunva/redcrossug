import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/utils/colors.dart';

class DonationCardProgress extends StatelessWidget {
  final currencyFormat = NumberFormat("#,##0.00", "en_US");

  DonationCardProgress({super.key});

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
              value: 0.4,
              backgroundColor: Colors.grey[500],
              color: AppColors.primaryRedColor,
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Row(
          children: [
            Text(
              "UGX 350,000",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text("/",
                  style: TextStyle(
                      color: AppColors.greyColorG,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Inter")),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                "UGX 3,000,000",
                style: TextStyle(
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
