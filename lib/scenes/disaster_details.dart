import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/scenes/price_tag.dart';
import 'package:redcross/scenes/red_btn.dart';
import 'package:redcross/scenes/widgets/link_field.dart';
import 'package:redcross/scenes/widgets/tag_item.dart';
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

  @override
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
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }

    if( disaster_details == null ) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: const Center(child: Text('No Data Found About this Disaster!')),
          ),
        ),
      );
    }


    // print( disaster_details );
    var disaster_image = disaster_details!['banner_photo'];

    return Scaffold(
      backgroundColor:const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(""),
        leading: const BackButton() // Back button added here
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
                      // image: DecorationImage(
                      //   image: NetworkImage( "https://urcs-api.taufeeq.dev/storage/disasters/0SRTnGIQ1MEUhGJSn9JrVzFDzQFqjv0gsQwfBKdB.jpg" ),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 80,
                      height: 30,
                      padding: const EdgeInsets.symmetric( horizontal: 1, vertical: 1 ),
                      margin: const EdgeInsets.symmetric( horizontal: 10, vertical: 25 ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFED1C24),
                        borderRadius: BorderRadius.circular( 5 )

                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle_rounded,
                            color: Color(0xFFFFFFFF),
                            size: 6,
                          ),
                          Padding(
                            padding: EdgeInsets.only( left: 5 ),
                            child: Text( 'Disaster', style: TextStyle( fontSize: 11.54, fontFamily: "Inter", fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF) ) ),
                          )
                        ],
                      )
                    ),
                  ),
                ],
              ),
              SizedBox( height: 5 ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),
                child: Text( "${disaster_details!['name']}", style: TextStyle( fontFamily: "Inter", fontSize: 26.33, fontWeight: FontWeight.w700, color: Color(0xFF000000) ), ),
              ),
              SizedBox( height: 10 ),
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 10 ),
                child: Text( "${disaster_details!['summary']}",
                style: TextStyle( fontFamily: "Inter", fontSize: 11.37, fontWeight: FontWeight.w400, color: Color(0xFF000000) ), ),
              ),
              SizedBox( height: 10 ),
              TagItem( label: "Emergency Support" ),
              SizedBox( height: 10 ),
              LinkField(label: 'Nearby Hospitals'),
              SizedBox( height: 10 ),
              LinkField(label: 'Local Shelters'),
              SizedBox( height: 10 ),
              LinkField(label: 'Food & Clothing Distribution Points'),
              SizedBox( height: 20 ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric( horizontal: 15 ), 
                    child: Text( "Fatalities:" )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric( horizontal: 5 ),
                    child: Text( disaster_details!['fatalities'].toString() ?? "0" )
                  )
                ],
              ),
              SizedBox( height: 10 ),
              Padding(
              padding: EdgeInsets.symmetric( horizontal: 20.0 ),
              child: DonationProgress(
                amount: disaster_details!['funds_raised'] ?? "500,000", 
                target: disaster_details!['funding_target'] ?? "2,000,000",
                currency: disaster_details!['currency'] ?? "UGX"
              ),
            ),
            const SizedBox( height: 25 ),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
              child: RedBtn(squared: true, label: 'Donate to Emergency', onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular( 0 )),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        height: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text( 
                                "Donation Amount", 
                                style: TextStyle( 
                                  fontSize: 16.85, 
                                  fontFamily: "Inter",
                                  color: Color(0xFF221105), 
                                  fontWeight: FontWeight.w500 
                                ), 
                              ),
                            ),
                            SizedBox(height: 25 ),
                            Center(
                              child: Text( 
                                "Enter Price Manually", 
                                style: TextStyle( 
                                  fontSize: 14.75, 
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFC1C0BF),
                                  fontFamily: "Inter"
                                )  ),
                            ),
                            SizedBox(height: 25 ),
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
                            RedBtn( squared: true, label: 'Continue to Payment', onPressed: () {
                                Navigator.of(context).pop();
                                Get.toNamed( "/initiate-payment" ); 
                            } )
                          ],
                        ),
                      );
                    },
                  );
              } ),
            )

            ],
          ),
        ),
      ),
    );
  }
}