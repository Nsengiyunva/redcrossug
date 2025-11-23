import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/models/branch.dart';
import 'package:redcross/models/district.dart';
import 'package:redcross/models/specialization.dart';
import 'dart:io';
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class VolunteerRegister extends StatefulWidget {
  const VolunteerRegister({super.key});

  @override
  State<VolunteerRegister> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<VolunteerRegister> {
  int _currentStep = 0;
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  // Bio Data Controllers
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _otherNameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _nationalIdNumberController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  // Contact Information Controllers
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alternativePhoneController = TextEditingController();
  final _districtController = TextEditingController();

  // Skills Controllers
  final _keySpecializationController = TextEditingController();
  final _otherSkillsController = TextEditingController();
  final _primaryLanguageController = TextEditingController();
  final _otherLanguageController = TextEditingController();

  // References Controller
  final _referencesController = TextEditingController();

  // Password Controllers
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Dropdown and Selection Values
  String _selectedGender = 'Male';
  int? _selectedBranch;
  String? _selectedSpecialization;
  String? _selectedEducationLevel;

  // File Variables
  File? _highestQualificationFile;
  File? _passportPhoto;

  final ImagePicker _picker = ImagePicker();

  List<Branch> branches = [];
  List<District> districts = [];
  List<Specialization> specializations = [];
  // List<EducationLevel> educationLevels = [];

  bool isLoading = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _otherNameController.dispose();
    _nationalIdController.dispose();
    _nationalIdNumberController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _alternativePhoneController.dispose();
    _districtController.dispose();
    _keySpecializationController.dispose();
    _otherSkillsController.dispose();
    _primaryLanguageController.dispose();
    _otherLanguageController.dispose();
    _referencesController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadAllDropDowns();
  }

  Future<void> _loadAllDropDowns() async {
    setState(() {
      isLoading = true;
    });

    final token = await StorageService.getToken();

    // final cachedBranches = await StorageService.getCachedData("branches");
    // final cachedDistricts = await StorageService.getCachedData("districts");
    // final cachedSpecs = await StorageService.getCachedData("specializations");
    // final cachedEdu = await StorageService.getCachedData("educationLevels");

    // if (cachedBranches != null &&
    //     cachedDistricts != null &&
    //     cachedSpecs != null &&
    //     cachedEdu != null) {
    //   setState(() {
    //     branches = cachedBranches.map((e) => Branch.fromJson(e)).toList();
    //     districts = cachedDistricts.map((e) => District.fromJson(e)).toList();
    //     specializations =
    //         cachedSpecs.map((e) => Specialization.fromJson(e)).toList();
    //     isLoading = false;
    //   });
    //   return;
    // }

    try {
      final responses = await Future.wait([
        http.get(
          Uri.parse('https://urcs-api.taufeeq.dev/api/vms/branches'),
          headers: {"Authorization": "Bearer $token"},
        ),
        http.get(
          Uri.parse('https://urcs-api.taufeeq.dev/api/vms/districts'),
          headers: {"Authorization": "Bearer $token"},
        ),
        http.get(
          Uri.parse('https://urcs-api.taufeeq.dev/api/vms/specializations'),
          headers: {"Authorization": "Bearer $token"},
        ),
      ]);

      final branchesParsedJson = jsonDecode(responses[0].body)['data'];
      final districtsParsedJson = jsonDecode(responses[1].body)['data'];
      final specsParsedJson = jsonDecode(responses[2].body)['data'];

      final districtsJson = districtsParsedJson['choices']['districts'];
      final levelsJson = districtsParsedJson['choices']['qualifications'];
      // final languagesJson = districtsParsedJson['choices']['languages'];

      var x =
          branchesParsedJson.map<Branch>((e) => Branch.fromJson(e)).toList();

      print("branches $branchesParsedJson");
      print(x);

      // setState(() {
      //   branches =
      //       branchesParsedJson.map<Branch>((e) => Branch.fromJson(e)).toList();

      //   districts =
      //       districtsJson.map<District>((e) => District.fromJson(e)).toList();

      //   specializations = specsParsedJson
      //       .map<Specialization>((e) => Specialization.fromJson(e))
      //       .toList();
      // });

      // Cache for future fast loads
      // await StorageService.cacheData(
      //     "branches", branches.map((e) => e.toJson()).toList());
      // await StorageService.cacheData(
      //     "districts", districts.map((e) => e.toJson()).toList());
      // await StorageService.cacheData(
      //     "specializations", specializations.map((e) => e.toJson()).toList());

      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      print("Error loading dropdowns: $e");
    }
  }

  Future<void> _pickQualificationFile() async {
    // Implement file picker for qualification document
    // You'll need to add file_picker package
  }

  Future<void> _pickPassportPhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (image != null) {
      setState(() {
        _passportPhoto = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _submitForm() {
    if (_formKeys[_currentStep].currentState!.validate()) {
      // Process form data
      // print('First Name: ${_firstNameController.text}');
      // print('Surname: ${_surnameController.text}');
      // print('Other Name: ${_otherNameController.text}');
      // print('National ID: ${_nationalIdController.text}');
      // print('National ID Number: ${_nationalIdNumberController.text}');
      // print('Date of Birth: ${_dateOfBirthController.text}');
      // print('Gender: $_selectedGender');
      // print('Email: ${_emailController.text}');
      // print('Phone: ${_phoneController.text}');
      // print('Alternative Phone: ${_alternativePhoneController.text}');
      // print('Branch: $_selectedBranch');
      // print('District: ${_districtController.text}');
      // print('Key Specialization: ${_keySpecializationController.text}');
      // print('Other Skills: ${_otherSkillsController.text}');
      // print('Primary Language: ${_primaryLanguageController.text}');
      // print('Other Language: ${_otherLanguageController.text}');
      // print('Education Level: $_selectedEducationLevel');
      // print('References: ${_referencesController.text}');

      final payload = {
        "firstname": _firstNameController.text,
        "surname": _surnameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "password1": _passwordController.text,
        "password2": _passwordController.text,
        "dob": _dateOfBirthController.text,
        "gender": _selectedGender,
        "district": _districtController.text,
        "branch": _selectedBranch,
        "specialization": _keySpecializationController.text,
        "highest_qualification": _selectedEducationLevel,
        "relevant_skills": _otherSkillsController.text,
        "languages": _otherLanguageController.text,
        "availability": "Immediate",
      };

      print("payload $payload");

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Registration submitted successfully!')),
      // );
    }
  }

  void _onStepContinue() {
    if (_formKeys[_currentStep].currentState!.validate()) {
      if (_currentStep < 4) {
        setState(() {
          _currentStep += 1;
        });
      } else {
        _submitForm();
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  Widget shimmerDropdown() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('b $branches');
    // print('s $specializations');
    // print('districts $districts');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Volunteer Registration Form'),
          backgroundColor: AppColors.bgColor,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.deepGreenA,
            ),
          ),
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: _onStepContinue,
            onStepCancel: _onStepCancel,
            onStepTapped: _onStepTapped,
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(_currentStep == 4 ? 'SUBMIT' : 'CONTINUE'),
                    ),
                    const SizedBox(width: 8),
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('BACK'),
                      ),
                  ],
                ),
              );
            },
            steps: [
              Step(
                title: const Text('Bio Data'),
                isActive: _currentStep >= 0,
                state:
                    _currentStep > 0 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[0],
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _surnameController,
                        decoration: const InputDecoration(
                          labelText: 'Surname',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _otherNameController,
                        decoration: const InputDecoration(
                          labelText: 'Other Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _nationalIdController.text.isEmpty
                                  ? null
                                  : _nationalIdController.text,
                              decoration: const InputDecoration(
                                labelText: 'Identification Type',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                'National ID',
                                'Passport',
                                'Driver\'s License'
                              ]
                                  .map((id) => DropdownMenuItem(
                                      value: id, child: Text(id)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _nationalIdController.text = value ?? '';
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select ID type';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nationalIdNumberController,
                        decoration: const InputDecoration(
                          labelText: 'National ID Number',
                          hintText: 'e.g CF123456',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _dateOfBirthController,
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Sex (Male or Female)',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                              const Text('Male'),
                              Radio<String>(
                                value: 'Female',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                              const Text('Female'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Contact'),
                isActive: _currentStep >= 1,
                state:
                    _currentStep > 1 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[1],
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (!value.contains('@')) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          hintText: 'e.g 0777123456',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _alternativePhoneController,
                        decoration: const InputDecoration(
                          labelText: 'Alternative Phone (Optional)',
                          hintText: 'e.g 0752112123',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                              child: DropdownButtonFormField<int>(
                            initialValue: _selectedBranch,
                            decoration: const InputDecoration(
                              labelText: 'URCS Branch',
                              border: OutlineInputBorder(),
                            ),
                            isExpanded: true,
                            items: branches
                                .map((branch) => DropdownMenuItem(
                                      value: branch.id,
                                      child: Text(branch.name),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBranch = value;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Please select a branch' : null,
                          )

                              // child: DropdownButtonFormField<String>(
                              //   initialValue: _selectedBranch,
                              //   decoration: const InputDecoration(
                              //     labelText: 'URCS Branch',
                              //     hintText: 'Choose a Branch',
                              //     border: OutlineInputBorder(),
                              //   ),
                              //   items: ['Kampala', 'Entebbe', 'Jinja', 'Mbarara']
                              //       .map((branch) => DropdownMenuItem(
                              //           value: branch, child: Text(branch)))
                              //       .toList(),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       _selectedBranch = value;
                              //     });
                              //   },
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please select branch';
                              //     }
                              //     return null;
                              //   },
                              // ),
                              ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _districtController,
                        decoration: const InputDecoration(
                          labelText: 'District of Residence',
                          hintText: 'Abim',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Skills'),
                isActive: _currentStep >= 2,
                state:
                    _currentStep > 2 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[2],
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        initialValue: _selectedSpecialization,
                        decoration: const InputDecoration(
                          labelText: 'Key Specialization',
                          hintText: 'Choose Specialization',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'First Aid',
                          'Health',
                          'Disaster Management',
                          'Youth',
                          'Communication'
                        ]
                            .map((spec) => DropdownMenuItem(
                                value: spec, child: Text(spec)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSpecialization = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _otherSkillsController,
                        decoration: const InputDecoration(
                          labelText: 'Any Other Skills (Optional)',
                          hintText: 'Choose Skills',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _primaryLanguageController,
                        decoration: const InputDecoration(
                          labelText: 'Select primary language',
                          hintText: 'Acholi',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _otherLanguageController,
                        decoration: const InputDecoration(
                          labelText: 'Select other language',
                          hintText: 'Acholi',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Education'),
                isActive: _currentStep >= 3,
                state:
                    _currentStep > 3 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[3],
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        initialValue: _selectedEducationLevel,
                        decoration: const InputDecoration(
                          labelText: 'Choose Education Level',
                          hintText: 'Primary',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'Primary',
                          'Secondary',
                          'Certificate',
                          'Diploma',
                          'Degree',
                          'Masters',
                          'PhD'
                        ]
                            .map((level) => DropdownMenuItem(
                                value: level, child: Text(level)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedEducationLevel = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select education level';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            const Text(
                                'Attach your Highest Qualification (10mb max)'),
                            const SizedBox(height: 8),
                            Icon(Icons.cloud_upload,
                                size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            const Text('Drag and drop a file here or click',
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _pickQualificationFile,
                              child: const Text('Choose File'),
                            ),
                            if (_highestQualificationFile != null)
                              Text(
                                  'Selected: ${_highestQualificationFile!.path}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _referencesController,
                        decoration: const InputDecoration(
                          labelText: 'References',
                          hintText:
                              'Provide names of Referee, Profession and Phone number. Up to a maximum of 3 referees',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Password'),
                isActive: _currentStep >= 4,
                state:
                    _currentStep > 4 ? StepState.complete : StepState.indexed,
                content: Form(
                  key: _formKeys[4],
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (value.length < 6) {
                            return 'Min 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Passport Photo (10mb max)',
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: _passportPhoto != null
                                    ? Image.file(_passportPhoto!,
                                        fit: BoxFit.cover)
                                    : Icon(Icons.person,
                                        size: 60, color: Colors.grey[400]),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: _pickPassportPhoto,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('CHOOSE PHOTO'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:hive/hive.dart';
// import 'package:shimmer/shimmer.dart';

// /// ------------------------------------------------------
// /// MODELS
// /// ------------------------------------------------------

// class Branch {
//   final int id;
//   final String name;
//   final String districts;
//   final double? latitude;
//   final double? longitude;

//   Branch({
//     required this.id,
//     required this.name,
//     required this.districts,
//     required this.latitude,
//     required this.longitude,
//   });

//   factory Branch.fromJson(Map<String, dynamic> json) => Branch(
//         id: json['id'] ?? 0,
//         name: json['name'] ?? '',
//         districts: json['districts'] ?? '',
//         latitude: json['latitude'] == null
//             ? null
//             : (json['latitude'] as num).toDouble(),
//         longitude: json['longitude'] == null
//             ? null
//             : (json['longitude'] as num).toDouble(),
//       );
// }

// class District {
//   final int id;
//   final String name;

//   District({required this.id, required this.name});

//   factory District.fromJson(Map<String, dynamic> json, int id) =>
//       District(id: id, name: json['name'] ?? json['value'] ?? '');
// }

// class Qualification {
//   final int id;
//   final String name;

//   Qualification({required this.id, required this.name});

//   factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
//         id: json['id'] ?? 0,
//         name: json['name'] ?? '',
//       );
// }

// class LanguageModel {
//   final int id;
//   final String name;

//   LanguageModel({
//     required this.id,
//     required this.name,
//   });

//   factory LanguageModel.fromJson(Map<String, dynamic> json) =>
//       LanguageModel(id: json['id'] ?? 0, name: json['name'] ?? '');
// }

// class Specialization {
//   final int id;
//   final String name;

//   Specialization({
//     required this.id,
//     required this.name,
//   });

//   factory Specialization.fromJson(Map<String, dynamic> json) =>
//       Specialization(id: json['id'] ?? 0, name: json['name'] ?? '');
// }

// /// ------------------------------------------------------
// /// API SERVICE WITH CACHING
// /// ------------------------------------------------------

// class ApiService {
//   final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: "https://urcs-api.taufeeq.dev/api",
//       connectTimeout: const Duration(seconds: 60),
//       receiveTimeout: const Duration(seconds: 60),
//       sendTimeout: const Duration(seconds: 60),
//     ),
//   );

//   /// Generic fetch + cache
//   Future<List<T>> fetchAndCache<T>({
//     required String endpoint,
//     required String cacheKey,
//     required T Function(Map<String, dynamic>) map,
//     List<dynamic> Function(Map<String, dynamic>)? extractList,
//   }) async {
//     final box = await Hive.openBox(cacheKey);

//     // Return cached data if available
//     if (box.isNotEmpty) {
//       final cached = box.get('data') as List;
//       return cached.map((e) => map(Map<String, dynamic>.from(e))).toList();
//     }

//     // Fetch from API
//     final response = await dio.get(endpoint);
//     final rawData = response.data['data'];

//     final dataList =
//         extractList != null ? extractList(rawData) : rawData as List;

//     // Convert to Map<String, dynamic> before caching
//     final jsonSafeData =
//         dataList.map((e) => Map<String, dynamic>.from(e)).toList();

//     // Save to Hive
//     await box.put('data', jsonSafeData);

//     return jsonSafeData.map((e) => map(e)).toList();
//   }

//   Future<List<Branch>> getBranches() => fetchAndCache(
//         endpoint: "/vms/branches",
//         cacheKey: "branches_cache",
//         map: Branch.fromJson,
//       );

//   Future<List<District>> getDistricts() async {
//     final list = await fetchAndCache<District>(
//       endpoint: "/vms/districts",
//       cacheKey: "districts_cache",
//       map: (json) => District.fromJson(json, 0), // temporary ID
//       extractList: (data) => data['choices']['districts'] as List,
//     );

//     // Assign sequential unique IDs
//     for (int i = 0; i < list.length; i++) {
//       list[i] = District(id: i + 1, name: list[i].name);
//     }

//     return list;
//   }

//   Future<List<Qualification>> getQualifications() => fetchAndCache(
//         endpoint: "/vms/qualifications",
//         cacheKey: "qualifications_cache",
//         map: Qualification.fromJson,
//       );

//   Future<List<LanguageModel>> getLanguages() => fetchAndCache(
//         endpoint: "/vms/languages",
//         cacheKey: "languages_cache",
//         map: LanguageModel.fromJson,
//       );

//   Future<List<Specialization>> getSpecializations() => fetchAndCache(
//         endpoint: "/vms/specializations",
//         cacheKey: "specializations_cache",
//         map: Specialization.fromJson,
//       );
// }

// /// ------------------------------------------------------
// /// SHIMMER LOADER WIDGET
// /// ------------------------------------------------------

// class ShimmerDropdown extends StatelessWidget {
//   const ShimmerDropdown({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: Container(
//         height: 55,
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.grey,
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
// }

/// ------------------------------------------------------
/// SCREEN UI
/// ------------------------------------------------------

// class VolunteerRegister extends StatefulWidget {
//   const VolunteerRegister({super.key});

//   @override
//   State<VolunteerRegister> createState() => _VolunteerFormScreenState();
// }

// class _VolunteerFormScreenState extends State<VolunteerRegister> {
//   final ApiService api = ApiService();

//   List<Branch> branches = [];
//   List<District> districts = [];
//   List<Qualification> qualifications = [];
//   List<LanguageModel> languages = [];
//   List<Specialization> specializations = [];

//   int? selectedBranchId;
//   int? selectedDistrictId;
//   int? selectedQualificationId;
//   int? selectedLanguageId;
//   int? selectedSpecializationId;

//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadAllData();
//   }

//   Future<void> loadAllData() async {
//     loading = true;
//     setState(() {});

//     try {
//       branches = await api.getBranches();
//       districts = await api.getDistricts();
//       qualifications = await api.getQualifications();
//       languages = await api.getLanguages();
//       specializations = await api.getSpecializations();

//       print("districts: ${districts.map((d) => d.name).toList()}");
//     } catch (e) {
//       print("ERROR: $e");
//     }

//     loading = false;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Register Volunteer")),
//       body: loading
//           ? ListView(
//               padding: const EdgeInsets.all(16),
//               children: const [
//                 ShimmerDropdown(),
//                 ShimmerDropdown(),
//                 ShimmerDropdown(),
//                 ShimmerDropdown(),
//                 ShimmerDropdown(),
//               ],
//             )
//           : ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 buildDropdown<int>(
//                   label: "URCS Branch",
//                   items: branches
//                       .map((e) =>
//                           DropdownMenuItem(value: e.id, child: Text(e.name)))
//                       .toList(),
//                   value: selectedBranchId,
//                   onChanged: (v) => setState(() => selectedBranchId = v),
//                 ),
//                 buildDropdown<int>(
//                   label: "District",
//                   items: districts
//                       .map((e) =>
//                           DropdownMenuItem(value: e.id, child: Text(e.name)))
//                       .toList(),
//                   value: selectedDistrictId,
//                   onChanged: (v) => setState(() => selectedDistrictId = v),
//                 ),
//                 buildDropdown<int>(
//                   label: "Qualification",
//                   items: qualifications
//                       .map((e) =>
//                           DropdownMenuItem(value: e.id, child: Text(e.name)))
//                       .toList(),
//                   value: selectedQualificationId,
//                   onChanged: (v) => setState(() => selectedQualificationId = v),
//                 ),
//                 buildDropdown<int>(
//                   label: "Language",
//                   items: languages
//                       .map((e) =>
//                           DropdownMenuItem(value: e.id, child: Text(e.name)))
//                       .toList(),
//                   value: selectedLanguageId,
//                   onChanged: (v) => setState(() => selectedLanguageId = v),
//                 ),
//                 buildDropdown<int>(
//                   label: "Specialization",
//                   items: specializations
//                       .map((e) =>
//                           DropdownMenuItem(value: e.id, child: Text(e.name)))
//                       .toList(),
//                   value: selectedSpecializationId,
//                   onChanged: (v) =>
//                       setState(() => selectedSpecializationId = v),
//                 ),
//               ],
//             ),
//     );
//   }

//   Widget buildDropdown<T>({
//     required String label,
//     required List<DropdownMenuItem<T>> items,
//     required T? value,
//     required Function(T?) onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: DropdownButtonFormField<T>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
//         items: items,
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
