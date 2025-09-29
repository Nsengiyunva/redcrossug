import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/donations_controller.dart';
import 'package:redcross/controllers/registration_controller.dart';
import 'package:redcross/scenes/auth/profile.dart';
import 'package:redcross/scenes/blood_donations/blood_eligibility.dart';
import 'package:redcross/scenes/widgets/date_picker.dart';
import 'package:redcross/scenes/widgets/dropdown_field.dart';
import 'package:redcross/utils/colors.dart';

import '../widgets/form_textfield.dart';
import '../widgets/red_btn.dart';

class DonationRegister extends StatefulWidget {
  final Map<String, dynamic> payload;

  const DonationRegister({super.key, required this.payload});

  @override
  DonationRegisterState createState() => DonationRegisterState();
}

class DonationRegisterState extends State<DonationRegister> {
  String? selectedStatus;
  String? selectedOption;
  String? selectedHealth;

  final List<String> groups = ['O', 'AB', 'A'];
  final List<String> health_options = ['Yes', 'No'];

  final _formKey = GlobalKey<FormState>();
  final DonationsController _donation_controller =
      Get.put(DonationsController());

  void validateForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form is valid!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.payload);

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
            child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Register as a Donor",
                      style: TextStyle(
                          fontSize: 20.14,
                          color: AppColors.blackColorF,
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 50),
                  DropdownField<String>(
                    controller: _donation_controller.blood_group,
                    label: "Blood Group",
                    hint: "Choose a Blood Group",
                    items: groups,
                    selectedValue: selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                        // You can call your filtering logic here
                        // print("xxx: $selectedStatus");
                      });
                    },
                    validator: (value) =>
                        value == null ? "Choose a Blood Group" : null,
                  ),
                  const SizedBox(height: 30),
                  DatePicker(
                      question: 'Last Donation  Date',
                      controller: _donation_controller.last_donation_date),
                  const SizedBox(height: 30),
                  DropdownField<String>(
                    controller: _donation_controller.donated_yet,
                    label: "Have you donated in  the last 3 Months?",
                    hint: "Choose One",
                    items: health_options,
                    selectedValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                        // You can call your filtering logic here
                        print("x1: $selectedOption");
                      });
                    },
                    validator: (value) => value == null ? "Choose One" : null,
                  ),
                  const SizedBox(height: 30),
                  DropdownField<String>(
                    controller: _donation_controller.healthy_today,
                    label: "Do you feel Healthy today?",
                    hint: "Choose One",
                    items: health_options,
                    selectedValue: selectedHealth,
                    onChanged: (value) {
                      setState(() {
                        selectedHealth = value;
                        // You can call your filtering logic here
                        // print("xxx: $selectedStatus");
                      });
                    },
                    validator: (value) => value == null ? "Choose One" : null,
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: RedBtn(
                      label: 'Register',
                      onPressed: () {
                        _donation_controller.goToEligibility(context);
                        // _donation_controller
                        //     .registerDonor(widget.payload["id"]);
                        // Get.toNamed("/blood-donation-eligibility");
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (context) => const BloodEligibility()),
                        // );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Profile()),
                        );
                      },
                      child: const Text('Edit Donor Profile',
                          style: TextStyle(color: AppColors.primaryRedColor)),
                    ),
                  )
                ],
              )),
        )));
  }
}
