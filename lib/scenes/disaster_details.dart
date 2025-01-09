// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/scenes/donation_progress.dart';
// import 'package:redcross/scenes/price_tag.dart';

// class DisasterDetails extends StatelessWidget {
//   DisasterDetails({super.key});

//   final data = Get.arguments;

//   @override
//   Widget build(BuildContext context) {
//     print( data );
    
//     return Scaffold(
//       backgroundColor:Color(0xFFF6F8FC),
//       appBar: AppBar(
//         title: Text(""),
//         leading: BackButton() // Back button added here
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           margin: const EdgeInsets.symmetric(vertical: 15.0),
//           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//              Stack(
//               children: [
//                 Container(
//                   height: 250,
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                       image: ExactAssetImage("assets/images/kasese_floods.jpg"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox( height: 5 ),
//             const Padding(
//               padding: EdgeInsets.symmetric( vertical: 5, horizontal: 20 ),
//               child: Text( "Kasese Floods", style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black ), ),
//             ),
//             const SizedBox( height: 10 ),
//             const Padding(
//               padding: EdgeInsets.symmetric( horizontal: 20 ),
//               child: Text( "Heavy rainfall has caused severe flooding, resulting in widespread destruction. Homes, bridges, and roads have been damaged, and many families have been displaced. Emergency teams are on the ground providing aid, but additional support is urgently needed.",
//               style: TextStyle( fontSize: 14, color: Colors.black ), ),
//             ),
//             const SizedBox( height: 25 ),
//             const Padding(
//               padding: EdgeInsets.symmetric( horizontal: 20.0 ),
//               child: DonationProgress(),
//             ),
//             const SizedBox( height: 25 ),
//             Padding(
//               padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 20 ),
//               child: ElevatedButton(
//                 child: const Text("Donate"),
//                 onPressed: () {

//                  showModalBottomSheet(
//                     context: context,
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                     ),
//                     builder: (BuildContext context) {
//                       return Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(20),
//                         height: 500, // Adjust height if needed
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Center(
//                               child: Text( "Donation Amount", style: TextStyle( fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500 ), ),
//                             ),
//                             const SizedBox(height: 20 ),
//                             const Center(
//                               child: Text( "Enter Price Manually", style: TextStyle( fontSize: 16, color: Colors.grey )  ),
//                             ),
//                             const Row(
//                               children: [
//                                 PriceTag( label: '100K', active: false ),
//                                 PriceTag( label: '250K', active: true ),
//                                 PriceTag( label: '350K', active: false),
//                               ],
//                             ),
//                             const SizedBox(height: 10 ),
//                             const Row(
//                               children: [
//                                 PriceTag( label: '500K', active: false ),
//                                 PriceTag( label: '750K', active: false),
//                                 PriceTag( label: '1 million', active: false),
//                               ],
//                             ),
//                             const Spacer(),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 Get.toNamed( "/initiate-payment" ); // Close the modal
//                               },
//                               child: const Text('Pay'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );


//                 },
//               ),
//             )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/scenes/price_tag.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'donation_progress.dart';

class DisasterDetails extends StatefulWidget {
  const DisasterDetails({super.key});

  @override
  State<DisasterDetails> createState() => _DisasterDetailsState();
}

class _DisasterDetailsState extends State<DisasterDetails> {

  Map<String, dynamic>? disaster_details;
  bool isLoading = true;

  void initState() {
    super.initState();
    _fetchDisasterDetails();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Returns null if not found
  }


  Future<void> _fetchDisasterDetails() async {
     String? token = await getToken(); 

    final response = await http.get(Uri.tryParse(
          'https://urcs-api.taufeeq.dev/api/disasters/1')!, headers: {
          'Authorization': "Bearer $token",
          'X-Requested-With': 'XMLHttpRequest'
          } );

    if (response.statusCode == 200) {
      // print( response.body );
      setState(() {
        disaster_details = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if( isLoading ) {
      return Container(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if( disaster_details == null ) {
      return Container(
        child: Center(child: Text('No Data Found About this Disaster!')),
      );
    }

    return Scaffold(
      backgroundColor:Color(0xFFF6F8FC),
      appBar: AppBar(
        title: Text(""),
        leading: BackButton() // Back button added here
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 15.0),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
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
            Padding(
              padding: EdgeInsets.symmetric( vertical: 5, horizontal: 20 ),
              child: Text( "${disaster_details!['name']}", style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black ), ),
            ),
            const SizedBox( height: 10 ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 20 ),
              child: Text( "${disaster_details!['summary']}",
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
                child: const Text("Donate"),
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
                            const Center(
                              child: Text( "Donation Amount", style: TextStyle( fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500 ), ),
                            ),
                            const SizedBox(height: 20 ),
                            const Center(
                              child: Text( "Enter Price Manually", style: TextStyle( fontSize: 16, color: Colors.grey )  ),
                            ),
                            const Row(
                              children: [
                                PriceTag( label: '100K', active: false ),
                                PriceTag( label: '250K', active: true ),
                                PriceTag( label: '350K', active: false),
                              ],
                            ),
                            const SizedBox(height: 10 ),
                            const Row(
                              children: [
                                PriceTag( label: '500K', active: false ),
                                PriceTag( label: '750K', active: false),
                                PriceTag( label: '1 million', active: false),
                              ],
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Get.toNamed( "/initiate-payment" ); // Close the modal
                              },
                              child: const Text('Pay'),
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