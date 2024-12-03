import 'package:flutter/material.dart';
import 'package:redcross/scenes/donation_progress.dart';
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
                            const Text('Bottom Sheet Modal', style: TextStyle(fontSize: 18)),
                            const SizedBox(height: 10),
                            const Text('This modal slides up from the bottom.'),
                            const Spacer(),
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