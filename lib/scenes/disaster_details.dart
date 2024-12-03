import 'package:flutter/material.dart';
import 'package:redcross/scenes/donation_progress.dart';
import 'package:redcross/scenes/price_tag.dart';
import 'package:redcross/scenes/red_btn.dart';

class DisasterDetails extends StatelessWidget {
  const DisasterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Stack(
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                      image: ExactAssetImage("assets/images/kasese_floods.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox( height: 5 ),
            const Padding(
              padding: EdgeInsets.symmetric( vertical: 5, horizontal: 20 ),
              child: Text( "Kasese Floods", style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black ), ),
            ),
            const SizedBox( height: 10 ),
            const Padding(
              padding: EdgeInsets.symmetric( horizontal: 20 ),
              child: Text( "Heavy rainfall has caused severe flooding, resulting in widespread destruction. Homes, bridges, and roads have been damaged, and many families have been displaced. Emergency teams are on the ground providing aid, but additional support is urgently needed.",
              style: TextStyle( fontSize: 14, color: Colors.black ), ),
            ),
            const SizedBox( height: 25 ),
            const Padding(
              padding: EdgeInsets.symmetric( horizontal: 20.0 ),
              child: DonationProgress(),
            ),
            const SizedBox( height: 25 ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
              child: ElevatedButton(
                child: const Text("Tap on this"),
                onPressed: () {

                 showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        height: 500, // Adjust height if needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text( "Donation Amount", style: TextStyle( fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500 ), ),
                            ),
                            SizedBox(height: 20 ),
                            Center(
                              child: Text( "Enter Price Manually", style: TextStyle( fontSize: 16, color: Colors.grey )  ),
                            ),
                            Row(
                              children: [
                                PriceTag( label: '100K', active: false ),
                                PriceTag( label: '250K', active: true ),
                                PriceTag( label: '350K', active: false),
                              ],
                            ),
                            SizedBox(height: 10 ),
                            Row(
                              children: [
                                PriceTag( label: '500K', active: false ),
                                PriceTag( label: '750K', active: false),
                                PriceTag( label: '1 million', active: false),
                              ],
                            ),
                            const Spacer(),
                            // RedBtn(label: "Continue to Payment"),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the modal
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  );


                },
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}