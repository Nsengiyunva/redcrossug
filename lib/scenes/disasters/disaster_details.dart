import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/scenes/widgets/donation_progress.dart';
import 'package:redcross/scenes/widgets/form_textfield.dart';
import 'package:redcross/scenes/widgets/link_field.dart';
import 'package:redcross/scenes/widgets/price_tag.dart';
import 'package:redcross/scenes/widgets/red_btn.dart';
import 'package:redcross/scenes/widgets/tag_item.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';
import 'dart:convert';

class DisasterDetails extends StatefulWidget {
  DisasterDetails({super.key});

  final DisastersListController disasterController =
      Get.put(DisastersListController());

  @override
  State<DisasterDetails> createState() => _DisasterDetailsState();
}

class _DisasterDetailsState extends State<DisasterDetails> {
  Map<String, dynamic>? disaster_details;
  bool isLoading = true;
  String amount_tab = "250K";
  int flagId = 2;

  @override
  void initState() {
    super.initState();
    _fetchDisasterDetails();
  }

  Future<void> _fetchDisasterDetails() async {
    String? token = await StorageService.getToken();

    final response = await http.get(
        Uri.tryParse('https://urcs-api.taufeeq.dev/api/disasters/1')!,
        headers: {
          'Authorization': "Bearer $token",
          'X-Requested-With': 'XMLHttpRequest'
        });

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

  void updateAmount(int flagId, String amount) {
    print("flag $flagId");
    // setState(() {
    //   amount_tab = amount;
    //   flagId = flagId;
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }

    if (disaster_details == null) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child:
                const Center(child: Text('No Data Found About this Disaster!')),
          ),
        ),
      );
    }

    var disasterImage = disaster_details!['banner_photo'];
    var fatalities = disaster_details!['fatalities'].toString() ?? "0";
    var amountNeeded = disaster_details!['funding_target'].toString() ?? "0";
    var currency = disaster_details!['currency'].toString() ?? "UGX";

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(title: const Text(""), leading: const BackButton()),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            ExactAssetImage("assets/images/kasese_floods.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 250,
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        width: 80,
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 1),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        decoration: BoxDecoration(
                            color: AppColors.primaryRedColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              color: AppColors.whiteColor,
                              size: 6,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Disaster',
                                  style: TextStyle(
                                      fontSize: 11.54,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.whiteColor)),
                            )
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: Text(
                  StorageService.truncateString(disaster_details!['name'], 25),
                  style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 26.33,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Text(
                  "${disaster_details!['summary']}",
                  style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 11.37,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: AppColors.primaryRedColor,
                                        width: 1))),
                            child: Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text("$fatalities lives lost",
                                      style: const TextStyle(
                                          fontSize: 13.64,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Inter",
                                          color: AppColors.primaryRedColor))),
                              Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: AppColors.primaryRedColor,
                                              width: 1))),
                                  child: Text(
                                      "${StorageService.formatCurrency(double.parse(disaster_details!['funding_target']))} Needed",
                                      style: const TextStyle(
                                          fontSize: 13.64,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Inter",
                                          color: AppColors.primaryRedColor)))
                            ])),
                        const SizedBox(height: 10),
                        const TagItem(
                            label: "Emergency Support",
                            height: 23.35,
                            width: 132),
                        const SizedBox(height: 10),
                        const LinkField(label: 'Nearby Hospitals'),
                        const SizedBox(height: 10),
                        const LinkField(label: 'Local Shelters'),
                        const SizedBox(height: 10),
                        const LinkField(
                            label: 'Food & Clothing Distribution Points'),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: DonationProgress(
                              amount: StorageService.formatCurrency(
                                      double.parse(
                                          disaster_details!['funds_raised'])) ??
                                  "500,000",
                              target: StorageService.formatCurrency(
                                      double.parse(disaster_details![
                                          'funding_target'])) ??
                                  "2,000,000",
                              currency: disaster_details!['currency'] ?? "UGX"),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RedBtn(
                              squared: true,
                              label: 'Donate to Emergency',
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(0)),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      height: 500,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                            child: Text(
                                              "Donation Amount",
                                              style: TextStyle(
                                                  fontSize: 16.85,
                                                  fontFamily: "Inter",
                                                  color: AppColors.blackColorG,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(height: 25),
                                          Center(
                                            child: FormTextfield(
                                              isNumberField: false,
                                              no_question: false,
                                              question: "Enter Price Manually",
                                              textEditingController: widget
                                                  .disasterController
                                                  .donationAmount,
                                              validator: (String? value) {
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 25),
                                          Row(
                                            children: [
                                              PriceTag(
                                                  label: '100K',
                                                  active:
                                                      widget.disasterController
                                                                  .flagId ==
                                                              1
                                                          ? true
                                                          : false,
                                                  onPressed: () {
                                                    widget.disasterController
                                                        .setAmountActive(
                                                            1, "100K");
                                                  }),
                                              PriceTag(
                                                  label: '250K',
                                                  active:
                                                      widget.disasterController
                                                                  .flagId ==
                                                              2
                                                          ? true
                                                          : false,
                                                  onPressed: () {
                                                    widget.disasterController
                                                        .setAmountActive(
                                                            2, "250K");
                                                  }),
                                              PriceTag(
                                                  label: '350K',
                                                  active:
                                                      widget.disasterController
                                                                  .flagId ==
                                                              3
                                                          ? true
                                                          : false,
                                                  onPressed: () {
                                                    widget.disasterController
                                                        .setAmountActive(
                                                            3, "350K");
                                                    // updateAmount(3, "350K");
                                                  }),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              PriceTag(
                                                  label: '500K',
                                                  active:
                                                      widget.disasterController
                                                                  .flagId ==
                                                              4
                                                          ? true
                                                          : false,
                                                  onPressed: () {
                                                    // updateAmount(4, "500K");
                                                    widget.disasterController
                                                        .setAmountActive(
                                                            4, "500K");
                                                  }),
                                              PriceTag(
                                                  label: '750K',
                                                  active:
                                                      widget.disasterController
                                                                  .flagId ==
                                                              5
                                                          ? true
                                                          : false,
                                                  onPressed: () {
                                                    // updateAmount(5, "750K");
                                                    widget.disasterController
                                                        .setAmountActive(
                                                            5, "750K");
                                                  }),
                                              PriceTag(
                                                  label: '1 million',
                                                  active:
                                                      widget.disasterController
                                                                  .flagId ==
                                                              6
                                                          ? true
                                                          : false,
                                                  onPressed: () {
                                                    // updateAmount(6, "1M");
                                                    widget.disasterController
                                                        .setAmountActive(
                                                            6, "1M");
                                                  }),
                                            ],
                                          ),
                                          const Spacer(),
                                          RedBtn(
                                              squared: true,
                                              label: 'Continue to Payment',
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Get.toNamed("/initiate-payment",
                                                    arguments: {
                                                      "disasterId":
                                                          disaster_details![
                                                              'id']
                                                    });
                                              })
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }),
                        )
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
