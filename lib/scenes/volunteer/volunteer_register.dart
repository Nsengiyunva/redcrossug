// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:redcross/models/branch.dart';
// import 'package:redcross/models/district.dart';
// import 'package:redcross/models/specialization.dart';
// import 'package:redcross/scenes/volunteer/volunteer_home.dart';
// import 'package:redcross/utils/colors.dart';
// import 'package:redcross/utils/storage_service.dart';

// class VolunteerRegister extends StatefulWidget {
//   const VolunteerRegister({super.key});

//   @override
//   State<VolunteerRegister> createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<VolunteerRegister> {
//   int _currentStep = 0;
//   final _formKeys = List.generate(5, (_) => GlobalKey<FormState>());

//   // Bio Data Controllers
//   final _firstNameController = TextEditingController();
//   final _surnameController = TextEditingController();
//   final _otherNameController = TextEditingController();
//   final _nationalIdNumberController = TextEditingController();
//   final _dateOfBirthController = TextEditingController();

//   // Contact Information Controllers
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _alternativePhoneController = TextEditingController();

//   // Skills Controllers
//   final _otherSkillsController = TextEditingController();
//   final _primaryLanguageController = TextEditingController();
//   final _otherLanguageController = TextEditingController();

//   // References Controller
//   final _referencesController = TextEditingController();

//   // Password Controllers
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   // Dropdown and Selection Values
//   String _selectedGender = 'Male';
//   int? _selectedBranch;
//   String? _selectedDistrict;
//   int? _selectedSpecialization;
//   String? _selectedEducationLevel;
//   int? _selectedSpecializationId;

//   // File Variables
//   File? _highestQualificationFile;
//   File? _passportPhoto;
//   final ImagePicker _picker = ImagePicker();

//   List<Branch> branches = [
//     Branch.fromJson({
//       "id": 57,
//       "name": "Adjumani",
//       "districts": "d-066",
//       "latitude": 3.237128,
//       "longitude": 31.7858246
//     }),
//     Branch.fromJson({
//       "id": 97,
//       "name": "Apac",
//       "districts": "d-077 | d-107 | d-110 | d-038",
//       "latitude": 1.9337258,
//       "longitude": 32.5018028
//     }),
//   ];

//   List<District> districts = [
//     District.fromJson({"id": 1, "name": "Abim", "value": "Abim"}),
//     District.fromJson({"id": 2, "name": "Adjumani", "value": "Adjumani"}),
//   ];

//   List<Specialization> specializations = [
//     Specialization.fromJson({
//       "id": 9,
//       "name": "Accounting",
//       "date_created": "2023-01-10T08:45:14.677884+00:00",
//       "date_updated": "2023-01-10T08:46:27.936583+00:00"
//     }),
//     Specialization.fromJson({
//       "id": 11,
//       "name": "Administrator",
//       "date_created": "2023-01-10T08:45:38.884220+00:00",
//       "date_updated": "2023-01-10T08:45:38.884238+00:00"
//     })
//   ];

//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _selectedBranch ??= branches.isNotEmpty ? branches.first.id : null;
//     _selectedDistrict ??= districts.isNotEmpty ? districts.first.name : null;
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _surnameController.dispose();
//     _otherNameController.dispose();
//     _nationalIdNumberController.dispose();
//     _dateOfBirthController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _alternativePhoneController.dispose();
//     _otherSkillsController.dispose();
//     _primaryLanguageController.dispose();
//     _otherLanguageController.dispose();
//     _referencesController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickQualificationFile() async {
//     // Implement file picker for qualification document
//   }

//   Future<void> _pickPassportPhoto() async {
//     final XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 800,
//       maxHeight: 800,
//     );

//     if (image != null) {
//       setState(() => _passportPhoto = File(image.path));
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null) {
//       setState(() {
//         _dateOfBirthController.text =
//             "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
//       });
//     }
//   }

//   Future<void> _submitForm() async {
//     setState(() => isLoading = true);

//     final token = await StorageService.getToken();

//     final uri = Uri.parse('https://urcs-api.taufeeq.dev/api/vms/volunteers');

//     DateTime parsedDate =
//         DateFormat("dd/MM/yyyy").parse(_dateOfBirthController.text);

//     try {
//       var request = http.MultipartRequest('POST', uri);

//       // Required headers
//       request.headers.addAll({
//         "Authorization": "Bearer $token",
//         "Accept": "application/json",
//         "Content-Type": "multipart/form-data",
//       });

//       // Add all fields
//       request.fields['firstname'] = _firstNameController.text;
//       request.fields['surname'] = _surnameController.text;
//       request.fields['email'] = _emailController.text;
//       request.fields['phone'] = _phoneController.text;
//       request.fields['password1'] = _passwordController.text;
//       request.fields['password2'] = _passwordController.text;

//       // Format DOB
//       request.fields['dob'] = DateFormat("yyyy-MM-dd").format(parsedDate);

//       request.fields['gender'] = _selectedGender ?? "";
//       request.fields['district'] = _selectedDistrict.toString();
//       request.fields['branch'] = _selectedBranch.toString();

//       request.fields['specialization'] = _selectedSpecializationId.toString();

//       request.fields['highest_qualification'] =
//           _selectedEducationLevel.toString();
//       request.fields['relevant_skills'] = _otherSkillsController.text;

//       request.fields['languages'] =
//           "${_primaryLanguageController.text}, ${_otherLanguageController.text}";

//       request.fields['availability'] = "Immediate";

//       print("Multipart fields: ${request.fields}");

//       // ---- SEND REQUEST ----
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       final json = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Volunteer registered successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const VolunteerHome()),
//         );
//       } else {
//         // print("Error response: $json");

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Failed to submit volunteer registration: '
//               '${response.statusCode} ${json["message"]}',
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting volunteer registration: $e')),
//       );
//       print("Exception: $e");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   void _onStepContinue() {
//     if (_formKeys[_currentStep].currentState!.validate()) {
//       if (_currentStep < 4) {
//         setState(() => _currentStep += 1);
//       } else {
//         _submitForm();
//       }
//     }
//   }

//   void _onStepCancel() {
//     if (_currentStep > 0) setState(() => _currentStep -= 1);
//   }

//   void _onStepTapped(int step) {
//     setState(() => _currentStep = step);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: AppColors.redColorD,
//         body: SizedBox(
//           height: size.height,
//           child: const Center(
//             child: CircularProgressIndicator(color: AppColors.primaryRedColor),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Volunteer Registration Form'),
//         backgroundColor: AppColors.bgColor,
//       ),
//       body: SingleChildScrollView(
//         child: Stepper(
//           type: StepperType.vertical,
//           currentStep: _currentStep,
//           onStepContinue: _onStepContinue,
//           onStepCancel: _onStepCancel,
//           onStepTapped: _onStepTapped,
//           controlsBuilder: (context, details) {
//             return Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: details.onStepContinue,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: Text(_currentStep == 4 ? 'SUBMIT' : 'CONTINUE'),
//                   ),
//                   const SizedBox(width: 8),
//                   if (_currentStep > 0)
//                     TextButton(
//                       onPressed: details.onStepCancel,
//                       child: const Text('BACK'),
//                     ),
//                 ],
//               ),
//             );
//           },
//           steps: [
//             // Step 0: Bio Data
//             Step(
//               title:
//                   const Text('Bio Data', style: TextStyle(fontFamily: "Inter")),
//               isActive: _currentStep >= 0,
//               state: _currentStep > 0 ? StepState.complete : StepState.indexed,
//               content: Form(
//                 key: _formKeys[0],
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _firstNameController,
//                       decoration: const InputDecoration(
//                         labelText: 'First Name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) =>
//                           value == null || value.isEmpty ? 'Required' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _surnameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Surname',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) =>
//                           value == null || value.isEmpty ? 'Required' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _otherNameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Other Name',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _nationalIdNumberController,
//                       decoration: const InputDecoration(
//                         labelText: 'National ID Number',
//                         hintText: 'e.g CF123456',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) =>
//                           value == null || value.isEmpty ? 'Required' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _dateOfBirthController,
//                       decoration: const InputDecoration(
//                         labelText: 'Date of Birth',
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.calendar_today),
//                       ),
//                       readOnly: true,
//                       onTap: () => _selectDate(context),
//                       validator: (value) => value == null || value.isEmpty
//                           ? 'Please select date'
//                           : null,
//                     ),
//                     const SizedBox(height: 16),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Sex (Male or Female)',
//                             style: TextStyle(fontSize: 12, color: Colors.grey)),
//                         Row(
//                           children: [
//                             Radio<String>(
//                               value: 'Male',
//                               groupValue: _selectedGender,
//                               onChanged: (value) =>
//                                   setState(() => _selectedGender = value!),
//                             ),
//                             const Text('Male'),
//                             Radio<String>(
//                               value: 'Female',
//                               groupValue: _selectedGender,
//                               onChanged: (value) =>
//                                   setState(() => _selectedGender = value!),
//                             ),
//                             const Text('Female'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Step 1: Contact
//             Step(
//               title: const Text('Contact'),
//               isActive: _currentStep >= 1,
//               state: _currentStep > 1 ? StepState.complete : StepState.indexed,
//               content: Form(
//                 key: _formKeys[1],
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) return 'Required';
//                         if (!value.contains('@')) return 'Invalid email';
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _phoneController,
//                       decoration: const InputDecoration(
//                         labelText: 'Phone',
//                         hintText: 'e.g 0777123456',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.phone,
//                       validator: (value) =>
//                           value == null || value.isEmpty ? 'Required' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     DropdownButtonFormField<int>(
//                       initialValue: _selectedBranch,
//                       decoration: const InputDecoration(
//                         labelText: 'URCS Branch',
//                         border: OutlineInputBorder(),
//                       ),
//                       isExpanded: true,
//                       items: branches
//                           .map((branch) => DropdownMenuItem(
//                                 value: branch.id,
//                                 child: Text(branch.name),
//                               ))
//                           .toList(),
//                       onChanged: (value) =>
//                           setState(() => _selectedBranch = value),
//                       validator: (value) =>
//                           value == null ? 'Please select a branch' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     DropdownButtonFormField<String>(
//                       initialValue: _selectedDistrict,
//                       decoration: const InputDecoration(
//                         labelText: 'District',
//                         border: OutlineInputBorder(),
//                       ),
//                       isExpanded: true,
//                       items: districts
//                           .map((district) => DropdownMenuItem(
//                                 value: district.name,
//                                 child: Text(district.name),
//                               ))
//                           .toList(),
//                       onChanged: (value) =>
//                           setState(() => _selectedDistrict = value),
//                       validator: (value) =>
//                           value == null ? 'Please select a district' : null,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Step 2: Skills
//             Step(
//               title: const Text('Skills'),
//               isActive: _currentStep >= 2,
//               state: _currentStep > 2 ? StepState.complete : StepState.indexed,
//               content: Form(
//                 key: _formKeys[2],
//                 child: Column(
//                   children: [
//                     DropdownButtonFormField<int>(
//                       initialValue: _selectedSpecializationId,
//                       decoration: const InputDecoration(
//                         labelText: 'Key Specialization',
//                         border: OutlineInputBorder(),
//                       ),
//                       items: specializations
//                           .map((spec) => DropdownMenuItem<int>(
//                                 value: spec.id, // int
//                                 child: Text(spec.name),
//                               ))
//                           .toList(),
//                       onChanged: (value) =>
//                           setState(() => _selectedSpecializationId = value),
//                       validator: (value) =>
//                           value == null ? 'Please select specialization' : null,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _otherSkillsController,
//                       decoration: const InputDecoration(
//                         labelText: 'Other Skills (Optional)',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _primaryLanguageController,
//                       decoration: const InputDecoration(
//                         labelText: 'Primary Language',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _otherLanguageController,
//                       decoration: const InputDecoration(
//                         labelText: 'Other Language',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Step 3: Education
//             Step(
//               title: const Text('Education'),
//               isActive: _currentStep >= 3,
//               state: _currentStep > 3 ? StepState.complete : StepState.indexed,
//               content: Form(
//                 key: _formKeys[3],
//                 child: Column(
//                   children: [
//                     DropdownButtonFormField<String>(
//                       initialValue: _selectedEducationLevel,
//                       decoration: const InputDecoration(
//                         labelText: 'Education Level',
//                         border: OutlineInputBorder(),
//                       ),
//                       items: [
//                         "Primary",
//                         "Secondary(O-Level)",
//                         "Secondary(A-Level)",
//                         "Technical",
//                         "Diploma",
//                         "Bachelors Degree",
//                         "Post Graduate Diploma",
//                         "Post Graduate Degree(Masters)",
//                         "PHD"
//                       ]
//                           .map((level) => DropdownMenuItem(
//                                 value: level,
//                                 child: Text(level),
//                               ))
//                           .toList(),
//                       onChanged: (value) =>
//                           setState(() => _selectedEducationLevel = value),
//                       validator: (value) => value == null
//                           ? 'Please select education level'
//                           : null,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _referencesController,
//                       decoration: const InputDecoration(
//                         labelText: 'References',
//                         border: OutlineInputBorder(),
//                       ),
//                       maxLines: 3,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Step 4: Password
//             Step(
//               title: const Text('Password'),
//               isActive: _currentStep >= 4,
//               state: _currentStep > 4 ? StepState.complete : StepState.indexed,
//               content: Form(
//                 key: _formKeys[4],
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _passwordController,
//                       decoration: const InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(),
//                       ),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) return 'Required';
//                         if (value.length < 6) return 'Min 6 characters';
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _confirmPasswordController,
//                       decoration: const InputDecoration(
//                         labelText: 'Confirm Password',
//                         border: OutlineInputBorder(),
//                       ),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value != _passwordController.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redcross/models/branch.dart';
import 'package:redcross/models/district.dart';
import 'package:redcross/models/specialization.dart';
import 'package:redcross/scenes/volunteer/volunteer_home.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class VolunteerRegister extends StatefulWidget {
  const VolunteerRegister({super.key});

  @override
  State<VolunteerRegister> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<VolunteerRegister> {
  int _currentStep = 0;
  final _formKeys = List.generate(5, (_) => GlobalKey<FormState>());

  // Bio Data Controllers
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _otherNameController = TextEditingController();
  final _nationalIdNumberController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  // Contact Information Controllers
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alternativePhoneController = TextEditingController();

  // Skills Controllers
  final _otherSkillsController = TextEditingController();
  final _primaryLanguageController = TextEditingController();
  final _otherLanguageController = TextEditingController();

  // References Controller
  final _referencesController = TextEditingController();

  // Password Controllers
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Password visibility toggles
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Dropdown and Selection Values
  String _selectedGender = 'Male';
  int? _selectedBranch;
  String? _selectedDistrict;
  int? _selectedSpecialization;
  String? _selectedEducationLevel;
  int? _selectedSpecializationId;

  // File Variables
  File? _highestQualificationFile;
  File? _passportPhoto;
  final ImagePicker _picker = ImagePicker();

  List<Branch> branches = [
    Branch.fromJson({
      "id": 57,
      "name": "Adjumani",
      "districts": "d-066",
      "latitude": 3.237128,
      "longitude": 31.7858246
    }),
    Branch.fromJson({
      "id": 97,
      "name": "Apac",
      "districts": "d-077 | d-107 | d-110 | d-038",
      "latitude": 1.9337258,
      "longitude": 32.5018028
    }),
  ];

  List<District> districts = [
    District.fromJson({"id": 1, "name": "Abim", "value": "Abim"}),
    District.fromJson({"id": 2, "name": "Adjumani", "value": "Adjumani"}),
  ];

  List<Specialization> specializations = [
    Specialization.fromJson({
      "id": 9,
      "name": "Accounting",
      "date_created": "2023-01-10T08:45:14.677884+00:00",
      "date_updated": "2023-01-10T08:46:27.936583+00:00"
    }),
    Specialization.fromJson({
      "id": 11,
      "name": "Administrator",
      "date_created": "2023-01-10T08:45:38.884220+00:00",
      "date_updated": "2023-01-10T08:45:38.884238+00:00"
    })
  ];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedBranch ??= branches.isNotEmpty ? branches.first.id : null;
    _selectedDistrict ??= districts.isNotEmpty ? districts.first.name : null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _otherNameController.dispose();
    _nationalIdNumberController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _alternativePhoneController.dispose();
    _otherSkillsController.dispose();
    _primaryLanguageController.dispose();
    _otherLanguageController.dispose();
    _referencesController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Input decoration theme for consistent styling
  InputDecoration _buildInputDecoration(String label,
      {String? hint, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontFamily: "Inter",
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hintText: hint,
      hintStyle: const TextStyle(
        fontFamily: "Inter",
        fontSize: 13,
        color: Colors.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: AppColors.primaryRedColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      suffixIcon: suffixIcon,
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters';
    }
    return null;
  }

  String? _validateNationalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'National ID is required';
    }
    if (!RegExp(r'^[A-Z]{2}[A-Z0-9]{5,12}$', caseSensitive: false)
        .hasMatch(value)) {
      return 'Invalid format (e.g., CF123456)';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^0[0-9]{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid format (e.g., 0777123456)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Must contain at least one number';
    }
    return null;
  }

  Future<void> _pickQualificationFile() async {
    // Implement file picker for qualification document
  }

  Future<void> _pickPassportPhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (image != null) {
      setState(() => _passportPhoto = File(image.path));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _submitForm() async {
    setState(() => isLoading = true);

    final token = await StorageService.getToken();

    final uri = Uri.parse('https://urcs-api.taufeeq.dev/api/vms/volunteers');

    DateTime parsedDate =
        DateFormat("dd/MM/yyyy").parse(_dateOfBirthController.text);

    try {
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "multipart/form-data",
      });

      request.fields['firstname'] = _firstNameController.text;
      request.fields['surname'] = _surnameController.text;
      request.fields['email'] = _emailController.text;
      request.fields['phone'] = _phoneController.text;
      request.fields['password1'] = _passwordController.text;
      request.fields['password2'] = _passwordController.text;
      request.fields['dob'] = DateFormat("yyyy-MM-dd").format(parsedDate);
      request.fields['gender'] = _selectedGender ?? "";
      request.fields['district'] = _selectedDistrict.toString();
      request.fields['branch'] = _selectedBranch.toString();
      request.fields['specialization'] = _selectedSpecializationId.toString();
      request.fields['highest_qualification'] =
          _selectedEducationLevel.toString();
      request.fields['relevant_skills'] = _otherSkillsController.text;
      request.fields['languages'] =
          "${_primaryLanguageController.text}, ${_otherLanguageController.text}";
      request.fields['availability'] = "Immediate";

      // print("Multipart fields: ${request.fields}");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Volunteer registered successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VolunteerHome()),
        );
      } else {
        print(json);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit volunteer registration: '
              '${response.statusCode} ${json["message"]} ${json["errors"] ?? json['error']}',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting volunteer registration: $e')),
      );
      print("xx: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _onStepContinue() {
    // Validate current step before proceeding
    if (_formKeys[_currentStep].currentState!.validate()) {
      if (_currentStep < 4) {
        setState(() => _currentStep += 1);
      } else {
        _submitForm();
      }
    } else {
      // Show error message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) setState(() => _currentStep -= 1);
  }

  void _onStepTapped(int step) {
    // Only allow tapping to previous completed steps
    if (step < _currentStep) {
      setState(() => _currentStep = step);
    } else if (step == _currentStep) {
      // Allow tapping current step (do nothing)
      return;
    } else {
      // Prevent jumping ahead without validation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete the current step first'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final contentPadding = isTablet ? 32.0 : 16.0;

    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SizedBox(
          height: size.height,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColors.primaryRedColor),
                SizedBox(height: 16),
                Text(
                  'Submitting your registration...',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text(
          'Volunteer Registration',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.bgColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: contentPadding),
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: _onStepContinue,
            onStepCancel: _onStepCancel,
            onStepTapped: _onStepTapped,
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryRedColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentStep == 4 ? 'SUBMIT' : 'CONTINUE',
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    if (_currentStep > 0) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: details.onStepCancel,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(
                                color: AppColors.primaryRedColor),
                          ),
                          child: const Text(
                            'BACK',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: AppColors.primaryRedColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
            steps: [
              // Step 0: Bio Data
              Step(
                title: const Text(
                  'Bio Data',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep > 0 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[0],
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        decoration: _buildInputDecoration('First Name'),
                        style: const TextStyle(fontFamily: "Inter"),
                        validator: _validateName,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _surnameController,
                        decoration: _buildInputDecoration('Surname'),
                        style: const TextStyle(fontFamily: "Inter"),
                        validator: _validateName,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _otherNameController,
                        decoration:
                            _buildInputDecoration('Other Name (Optional)'),
                        style: const TextStyle(fontFamily: "Inter"),
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nationalIdNumberController,
                        decoration: _buildInputDecoration(
                          'National ID Number',
                          hint: 'e.g CF123456',
                        ),
                        style: const TextStyle(fontFamily: "Inter"),
                        validator: _validateNationalId,
                        textCapitalization: TextCapitalization.characters,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _dateOfBirthController,
                        decoration: _buildInputDecoration(
                          'Date of Birth',
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                        style: const TextStyle(fontFamily: "Inter"),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please select your date of birth'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gender',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text(
                                    'Male',
                                    style: TextStyle(fontFamily: "Inter"),
                                  ),
                                  value: 'Male',
                                  groupValue: _selectedGender,
                                  onChanged: (value) =>
                                      setState(() => _selectedGender = value!),
                                  activeColor: AppColors.primaryRedColor,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text(
                                    'Female',
                                    style: TextStyle(fontFamily: "Inter"),
                                  ),
                                  value: 'Female',
                                  groupValue: _selectedGender,
                                  onChanged: (value) =>
                                      setState(() => _selectedGender = value!),
                                  activeColor: AppColors.primaryRedColor,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Step 1: Contact
              Step(
                title: const Text(
                  'Contact Information',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                isActive: _currentStep >= 1,
                state:
                    _currentStep > 1 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[1],
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: _buildInputDecoration('Email Address'),
                        style: const TextStyle(fontFamily: "Inter"),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: _buildInputDecoration(
                          'Phone Number',
                          hint: 'e.g 0777123456',
                        ),
                        style: const TextStyle(fontFamily: "Inter"),
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        value: _selectedBranch,
                        decoration: _buildInputDecoration('URCS Branch'),
                        style: const TextStyle(
                          fontFamily: "Inter",
                          color: Colors.black,
                        ),
                        isExpanded: true,
                        items: branches
                            .map((branch) => DropdownMenuItem(
                                  value: branch.id,
                                  child: Text(branch.name),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedBranch = value),
                        validator: (value) =>
                            value == null ? 'Please select a branch' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedDistrict,
                        decoration: _buildInputDecoration('District'),
                        style: const TextStyle(
                          fontFamily: "Inter",
                          color: Colors.black,
                        ),
                        isExpanded: true,
                        items: districts
                            .map((district) => DropdownMenuItem(
                                  value: district.name,
                                  child: Text(district.name),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedDistrict = value),
                        validator: (value) =>
                            value == null ? 'Please select a district' : null,
                      ),
                    ],
                  ),
                ),
              ),

              // Step 2: Skills
              Step(
                title: const Text(
                  'Skills & Languages',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                isActive: _currentStep >= 2,
                state:
                    _currentStep > 2 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[2],
                  child: Column(
                    children: [
                      DropdownButtonFormField<int>(
                        value: _selectedSpecializationId,
                        decoration: _buildInputDecoration('Key Specialization'),
                        style: const TextStyle(
                          fontFamily: "Inter",
                          color: Colors.black,
                        ),
                        items: specializations
                            .map((spec) => DropdownMenuItem<int>(
                                  value: spec.id,
                                  child: Text(spec.name),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedSpecializationId = value),
                        validator: (value) => value == null
                            ? 'Please select specialization'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _otherSkillsController,
                        decoration:
                            _buildInputDecoration('Other Skills (Optional)'),
                        style: const TextStyle(fontFamily: "Inter"),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _primaryLanguageController,
                        decoration: _buildInputDecoration('Primary Language'),
                        style: const TextStyle(fontFamily: "Inter"),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Primary language is required'
                                : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _otherLanguageController,
                        decoration:
                            _buildInputDecoration('Other Languages (Optional)'),
                        style: const TextStyle(fontFamily: "Inter"),
                      ),
                    ],
                  ),
                ),
              ),

              // Step 3: Education
              Step(
                title: const Text(
                  'Education',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                isActive: _currentStep >= 3,
                state:
                    _currentStep > 3 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[3],
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedEducationLevel,
                        decoration:
                            _buildInputDecoration('Highest Education Level'),
                        style: const TextStyle(
                          fontFamily: "Inter",
                          color: Colors.black,
                        ),
                        items: [
                          "Primary",
                          "Secondary(O-Level)",
                          "Secondary(A-Level)",
                          "Technical",
                          "Diploma",
                          "Bachelors Degree",
                          "Post Graduate Diploma",
                          "Post Graduate Degree(Masters)",
                          "PHD"
                        ]
                            .map((level) => DropdownMenuItem(
                                  value: level,
                                  child: Text(level),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedEducationLevel = value),
                        validator: (value) => value == null
                            ? 'Please select education level'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _referencesController,
                        decoration: _buildInputDecoration(
                          'References (Optional)',
                          hint: 'Name, relationship, contact',
                        ),
                        style: const TextStyle(fontFamily: "Inter"),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),

              // Step 4: Password
              Step(
                title: const Text(
                  'Create Password',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                isActive: _currentStep >= 4,
                state:
                    _currentStep > 4 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[4],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        decoration: _buildInputDecoration(
                          'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(fontFamily: "Inter"),
                        obscureText: !_isPasswordVisible,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Password must contain:',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '• At least 8 characters\n• One uppercase letter\n• One lowercase letter\n• One number',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 11,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: _buildInputDecoration(
                          'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(fontFamily: "Inter"),
                        obscureText: !_isConfirmPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
