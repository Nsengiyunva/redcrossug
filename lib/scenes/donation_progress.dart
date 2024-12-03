import 'package:flutter/material.dart';

class DonationProgress extends StatelessWidget {
  const DonationProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( "Donation raised", style: TextStyle( fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[900] ) ),
          const SizedBox( height: 10 ),
          Container(
            // margin: EdgeInsets.all(20),
            child: LinearProgressIndicator(
              value: 0.6, // Set progress value (0.0 to 1.0)
              backgroundColor: Colors.grey[500],
              color: Colors.red, // Progress color
              minHeight: 8, // Height of the progress bar
            ),
          ),
          const SizedBox( height: 10 ),
          Row(
            children: [
               const Text( "UGX 50,000", style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold ), ),
               Text( "/", style: TextStyle( fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[800] ) ),
               Text( "UGX 2,500,000", style: TextStyle( fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[800] ), ),
            ],
          )
        ],
      ),
    );
  }
}