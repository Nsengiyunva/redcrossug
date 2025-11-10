// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/controllers/donations_controller.dart';
// import 'package:redcross/scenes/auth/profile.dart';
// import 'package:redcross/scenes/widgets/date_picker.dart';
// import 'package:redcross/scenes/widgets/dropdown_field.dart';
// import 'package:redcross/utils/colors.dart';

// import '../widgets/red_btn.dart';

// class DonationRegister extends StatefulWidget {
//   final Map<String, dynamic> payload;

//   const DonationRegister({super.key, required this.payload});

//   @override
//   DonationRegisterState createState() => DonationRegisterState();
// }

// class DonationRegisterState extends State<DonationRegister> {
//   String? selectedStatus;
//   String? selectedOption;
//   String? selectedHealth;

//   final List<String> groups = ['O', 'AB', 'A'];
//   final List<String> health_options = ['Yes', 'No'];

//   final _formKey = GlobalKey<FormState>();
//   final DonationsController _donation_controller =
//       Get.put(DonationsController());

//   void validateForm() {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Form is valid!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.whiteColor,
//         body: SingleChildScrollView(
//             child: Container(
//           width: double.maxFinite,
//           margin: const EdgeInsets.symmetric(vertical: 30.0),
//           padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
//           child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Register as a Donor",
//                       style: TextStyle(
//                           fontSize: 20.14,
//                           color: AppColors.blackColorF,
//                           fontFamily: "Manrope",
//                           fontWeight: FontWeight.w600)),
//                   const SizedBox(height: 50),
//                   DropdownField<String>(
//                     controller: _donation_controller.blood_group,
//                     label: "Blood Group",
//                     hint: "Choose a Blood Group",
//                     items: groups,
//                     selectedValue: selectedStatus,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedStatus = value;
//                         // You can call your filtering logic here
//                         // print("xxx: $selectedStatus");
//                       });
//                     },
//                     validator: (value) =>
//                         value == null ? "Choose a Blood Group" : null,
//                   ),
//                   const SizedBox(height: 30),
//                   DatePicker(
//                       question: 'Last Donation  Date',
//                       controller: _donation_controller.last_donation_date),
//                   const SizedBox(height: 30),
//                   DropdownField<String>(
//                     controller: _donation_controller.donated_yet,
//                     label: "Have you donated in  the last 3 Months?",
//                     hint: "Choose One",
//                     items: health_options,
//                     selectedValue: selectedOption,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedOption = value;
//                         // You can call your filtering logic here
//                         print("x1: $selectedOption");
//                       });
//                     },
//                     validator: (value) => value == null ? "Choose One" : null,
//                   ),
//                   const SizedBox(height: 30),
//                   DropdownField<String>(
//                     controller: _donation_controller.healthy_today,
//                     label: "Do you feel Healthy today?",
//                     hint: "Choose One",
//                     items: health_options,
//                     selectedValue: selectedHealth,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedHealth = value;
//                         // You can call your filtering logic here
//                         // print("xxx: $selectedStatus");
//                       });
//                     },
//                     validator: (value) => value == null ? "Choose One" : null,
//                   ),
//                   const SizedBox(height: 25),
//                   Center(
//                     child: RedBtn(
//                       label: 'Register',
//                       onPressed: () {
//                         _donation_controller
//                             .registerDonor(widget.payload["id"]);
//                         // Get.toNamed("/blood-donation-eligibility");
//                         // Navigator.of(context).push(
//                         //   MaterialPageRoute(
//                         //       builder: (context) => const BloodEligibility()),
//                         // );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Center(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => const Profile()),
//                         );
//                       },
//                       child: const Text('Edit Donor Profile',
//                           style: TextStyle(color: AppColors.primaryRedColor)),
//                     ),
//                   )
//                 ],
//               )),
//         )));
//   }
// }
import 'package:flutter/material.dart';

class DonationRegister extends StatefulWidget {
  const DonationRegister({Key? key}) : super(key: key);

  @override
  State<DonationRegister> createState() => _RegisterDonorFormState();
}

class _RegisterDonorFormState extends State<DonationRegister> {
  final _formKey = GlobalKey<FormState>();
  final _serialNoController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedBloodType;
  DateTime? _lastDonationDate;

  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  void dispose() {
    _serialNoController.dispose();
    _phoneNoController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _lastDonationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _lastDonationDate) {
      setState(() {
        _lastDonationDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create the data object
      final donorData = {
        'blood_type': _selectedBloodType,
        'serial_no': _serialNoController.text,
        'location': _locationController.text,
        'phone_no': _phoneNoController.text,
        'last_donation_date':
            _lastDonationDate?.toIso8601String().split('T')[0],
      };

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration Successful!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      print('Donor Data: $donorData');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  // Title
                  Text(
                    'Register as a Donor',
                    style: TextStyle(
                      fontSize: screenWidth * 0.09,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Please fill in your details to register',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Blood Type Dropdown
                  Text(
                    'Blood Type',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  DropdownButtonFormField<String>(
                    value: _selectedBloodType,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Select your blood type',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                    items: _bloodTypes.map((String bloodType) {
                      return DropdownMenuItem<String>(
                        value: bloodType,
                        child: Text(bloodType),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBloodType = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your blood type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Serial Number
                  Text(
                    'Serial Number',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: _serialNoController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter your serial number',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your serial number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Phone Number
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: _phoneNoController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      hintText: '+256XXXXXXXXX',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                      prefixIcon: Icon(Icons.phone, color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (!value.startsWith('+256')) {
                        return 'Phone number must start with +256';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Location
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: _locationController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter your location',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                      prefixIcon: Icon(Icons.location_on, color: Colors.red),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Last Donation Date
                  Text(
                    'Last Donation Date',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.red),
                          SizedBox(width: screenWidth * 0.03),
                          Text(
                            _lastDonationDate == null
                                ? 'Select date'
                                : '${_lastDonationDate!.day}/${_lastDonationDate!.month}/${_lastDonationDate!.year}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: _lastDonationDate == null
                                  ? Colors.grey[400]
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Submit Button
                  GestureDetector(
                    onTap: _submitForm,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Register as Donor',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
