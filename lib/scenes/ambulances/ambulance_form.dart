// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/controllers/ambulance_controller.dart';
// import 'package:redcross/scenes/ambulances/ambulance_success.dart';
// import 'package:redcross/scenes/widgets/form_textfield.dart';
// import 'package:redcross/scenes/widgets/red_btn.dart';
// import 'package:redcross/utils/colors.dart';

// class AmbulanceForm extends StatelessWidget {
//   AmbulanceForm({super.key});

//   final AmbulanceController ambulanceController =
//       Get.put(AmbulanceController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.bgColor,
//         appBar: AppBar(
//             title: const Text("Commercial Ambulance",
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: "Inter",
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.blackColor)),
//             leading: const BackButton() // Back button added here
//             ),
//         body: SingleChildScrollView(
//           child: Container(
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(vertical: 30.0),
//             padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Ambulance Information",
//                   style: TextStyle(
//                       fontSize: 20.14,
//                       fontFamily: "Manrope",
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF545454)),
//                 ),
//                 const SizedBox(height: 25),
//                 FormTextfield(
//                   no_question: true,
//                   isNumberField: true,
//                   question: 'Ambulance Type',
//                   textEditingController: ambulanceController.no_people_hurt,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 25),
//                 FormTextfield(
//                   no_question: true,
//                   isNumberField: true,
//                   question: 'Purpose of Ambulance',
//                   textEditingController: ambulanceController.no_ambulances,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 25),
//                 FormTextfield(
//                   no_question: true,
//                   isNumberField: true,
//                   question: 'Service Duration',
//                   textEditingController: ambulanceController.no_patients,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 25),
//                 FormTextfield(
//                   no_question: true,
//                   isNumberField: true,
//                   question: 'Service Timing',
//                   textEditingController: ambulanceController.no_patients,
//                   validator: (value) {
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 30),
//                 const Row(
//                   children: [
//                     Icon(
//                       Icons.check_box_outline_blank,
//                       color: AppColors.whiteColorB,
//                       size: 24.0,
//                     ),
//                     Text("By continuing, you accept our Ambulance Policy",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontFamily: "Inter",
//                             fontSize: 10,
//                             color: AppColors.greyColorC)),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 RedBtn(
//                     label: "Continue",
//                     onPressed: () {
//                       // ambulanceController.createAmbulanceRequest();
//                       // Get.toNamed('/ambulance-success-request');
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                             builder: (context) => const AmbulanceSuccess()),
//                       );
//                     })
//               ],
//             ),
//           ),
//         ));
//   }
// }

// ignore_for_file: unused_element, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/scenes/ambulances/ambulance_list.dart';
import 'dart:convert';

import 'package:redcross/utils/storage_service.dart';

class AmbulanceForm extends StatefulWidget {
  @override
  _CommercialAmbulanceScreenState createState() =>
      _CommercialAmbulanceScreenState();
}

class _CommercialAmbulanceScreenState extends State<AmbulanceForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool acceptPolicy = false;

  // Form Controllers
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController numberOfPeopleController =
      TextEditingController();
  final TextEditingController numberOfChildrenController =
      TextEditingController();
  final TextEditingController criticallyIllController = TextEditingController();

  // Dropdown values
  String? selectedAmbulanceType;
  String? selectedPurpose;
  String? selectedServiceDuration;
  String? selectedServiceTiming;

  final List<String> ambulanceTypes = [
    'Basic Life Support',
    'Advanced Life Support',
    'Critical Care',
    'Neonatal',
  ];

  final List<String> purposes = [
    'Event Ambulance Standby',
    'Emergency Transport',
    'Inter-facility Transfer',
    'Medical Event Coverage',
  ];

  final List<String> serviceDurations = [
    '1 day',
    '2 days',
    '3 days',
    '1 week',
  ];

  final List<String> serviceTimings = [
    'Now / Immediate Dispatch',
    'Schedule for Later',
    'Recurring Service',
  ];

  @override
  void initState() {
    super.initState();
    selectedAmbulanceType = ambulanceTypes[0];
    selectedPurpose = purposes[0];
    selectedServiceDuration = serviceDurations[0];
    selectedServiceTiming = serviceTimings[0];
  }

  Future<void> _submitBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!acceptPolicy) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please accept the Ambulance Policy to continue'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final token = await StorageService.getToken();

    try {
      final response = await http.post(
        Uri.parse(
            'https://urcs-api.taufeeq.dev/api/ambulance-requests'), // Replace with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },

        body: json.encode({
          'location': locationController.text,
          'phone_number': phoneController.text,
          'number_of_people': int.parse(numberOfPeopleController.text),
          'number_of_children': int.parse(numberOfChildrenController.text),
          'number_of_critically_ill': int.parse(criticallyIllController.text),
        }),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        _showSuccessDialog();
      } else {
        // Error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFFFFE5E5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Color(0xFFFF0000),
                size: 40,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Ambulance Request Submitted!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Your ambulance request has been successfully submitted. You will be alerted when the status is confirmed.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                // Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AmbulanceList()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF0000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;
    final bool isDesktop = screenWidth >= 1024;

    final double horizontalPadding = isDesktop ? 40 : (isTablet ? 30 : 20);
    final double maxContentWidth =
        isDesktop ? 800 : (isTablet ? 700 : screenWidth);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Commercial Ambulance',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(horizontalPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Ambulance Information',
                    style: TextStyle(
                      fontSize: isDesktop ? 20 : 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Ambulance Type
                  // _buildLabel('Ambulance Type'),
                  // _buildDropdown(
                  //   value: selectedAmbulanceType,
                  //   items: ambulanceTypes,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedAmbulanceType = value;
                  //     });
                  //   },
                  // ),
                  // SizedBox(height: 20),

                  // // Purpose of Ambulance
                  // _buildLabel('Purpose of Ambulance'),
                  // _buildDropdown(
                  //   value: selectedPurpose,
                  //   items: purposes,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedPurpose = value;
                  //     });
                  //   },
                  // ),
                  // SizedBox(height: 20),

                  // // Service Duration
                  // _buildLabel('Service Duration'),
                  // _buildDropdown(
                  //   value: selectedServiceDuration,
                  //   items: serviceDurations,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedServiceDuration = value;
                  //     });
                  //   },
                  // ),
                  // SizedBox(height: 20),

                  // // Service Timing
                  // _buildLabel('Service Timing'),
                  // _buildDropdown(
                  //   value: selectedServiceTiming,
                  //   items: serviceTimings,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedServiceTiming = value;
                  //     });
                  //   },
                  // ),
                  // SizedBox(height: 24),

                  // Location
                  _buildLabel('Location'),
                  _buildTextField(
                    controller: locationController,
                    hintText: 'Enter location',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Phone Number
                  _buildLabel('Phone Number'),
                  _buildTextField(
                    controller: phoneController,
                    hintText: 'Enter phone number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Number of People
                  _buildLabel('Number of People'),
                  _buildTextField(
                    controller: numberOfPeopleController,
                    hintText: 'Enter number of people',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of people';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Number of Children
                  _buildLabel('Number of Children'),
                  _buildTextField(
                    controller: numberOfChildrenController,
                    hintText: 'Enter number of children',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of children';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Number of Critically Ill
                  _buildLabel('Number of Critically Ill'),
                  _buildTextField(
                    controller: criticallyIllController,
                    hintText: 'Enter number of critically ill',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of critically ill';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),

                  // Policy Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: acceptPolicy,
                          onChanged: (value) {
                            setState(() {
                              acceptPolicy = value ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(color: Colors.grey[400]!),
                          activeColor: Color(0xFFFF0000),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'By continuing you accept our Ambulance Policy',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF0000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
    phoneController.dispose();
    numberOfPeopleController.dispose();
    numberOfChildrenController.dispose();
    criticallyIllController.dispose();
    super.dispose();
  }
}
