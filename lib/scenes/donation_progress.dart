import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationProgress extends StatelessWidget {
  final String amount;
  final String target;
  final String currency;

  final currencyFormat = NumberFormat("#,##0.00", "en_US");

  DonationProgress({super.key, required this.amount, required this.target, required this.currency });

  @override
  Widget build(BuildContext context) {
    // var formattedAmount =int.tryParse( amount );
    // print( formattedAmount );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular( 10 )
      ),
      padding: const EdgeInsets.symmetric( horizontal: 15, vertical: 15 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox( height: 25 ),
          const Text( "Donation raised", style: TextStyle( fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: Color(0xFF969492) )),
          const SizedBox( height: 10 ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
              value: 0.6, 
              backgroundColor: Colors.grey[500],
              color: const Color(0xFFED1C24), 
              minHeight: 8,
            ),
            )
          ),
          const SizedBox( height: 20 ),
          Row(
            children: [
              Text( "$currency $amount", style: const TextStyle( fontSize: 16, fontWeight: FontWeight.w600, fontFamily: "Inter" ), ),
               const Padding(
                padding: EdgeInsets.symmetric( horizontal: 2 ),
                child: Text( 
                  "/", 
                  style: TextStyle( color:Color(0xFF969492), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "Inter" ) 
                ),),
               Padding(
                padding: const EdgeInsets.symmetric( horizontal: 2 ),
                child: Text( "$currency $target", style: const TextStyle( color: Color(0xFF969492), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "Inter" ), 
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}