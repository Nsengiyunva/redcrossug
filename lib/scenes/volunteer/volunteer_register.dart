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

  // Dropdown and Selection Values
  String _selectedGender = 'Male';
  int? _selectedBranch;
  int? _selectedDistrict;
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
    _selectedDistrict ??= districts.isNotEmpty ? districts.first.id : null;
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
    if (_formKeys[_currentStep].currentState!.validate()) {
      setState(() => isLoading = true);

      DateTime parsedDate =
          DateFormat("dd/MM/yyyy").parse(_dateOfBirthController.text);

      final payload = {
        "firstname": _firstNameController.text,
        "surname": _surnameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "password1": _passwordController.text,
        "password2": _passwordController.text,
        "dob": DateFormat("yyyy-MM-dd").format(parsedDate),
        "gender": _selectedGender,
        "district": _selectedDistrict,
        "branch": _selectedBranch,
        "specialization": _selectedSpecializationId,
        "highest_qualification": "Bachelors",
        "relevant_skills": _otherSkillsController.text,
        "languages":
            "${_primaryLanguageController.text}, ${_otherLanguageController.text}",
        "availability": "Immediate",
      };

      print("payload $payload");

      final token = await StorageService.getToken();

      try {
        final response = await http.post(
          Uri.parse('https://urcs-api.taufeeq.dev/api/vms/volunteers'),
          headers: {
            "Authorization": "Bearer $token",
            "X-Requested-With": "XMLHttpRequest"
          },
          body: jsonEncode(payload),
        );

        final json = jsonDecode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Volunteer registered successfully!'),
                backgroundColor: Colors.green),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VolunteerHome()),
          );
        } else {
          print("json $json");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Failed to submit volunteer registration: ${response.statusCode} ${json["message"]}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error submitting volunteer registration: $e')),
        );
        print("xx $e");
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  void _onStepContinue() {
    if (_formKeys[_currentStep].currentState!.validate()) {
      if (_currentStep < 4) {
        setState(() => _currentStep += 1);
      } else {
        _submitForm();
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) setState(() => _currentStep -= 1);
  }

  void _onStepTapped(int step) {
    setState(() => _currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColors.redColorD,
        body: SizedBox(
          height: size.height,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primaryRedColor),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Registration Form'),
        backgroundColor: AppColors.bgColor,
      ),
      body: SingleChildScrollView(
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
            // Step 0: Bio Data
            Step(
              title: const Text('Bio Data'),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
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
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _surnameController,
                      decoration: const InputDecoration(
                        labelText: 'Surname',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
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
                    TextFormField(
                      controller: _nationalIdNumberController,
                      decoration: const InputDecoration(
                        labelText: 'National ID Number',
                        hintText: 'e.g CF123456',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
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
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please select date'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sex (Male or Female)',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Male',
                              groupValue: _selectedGender,
                              onChanged: (value) =>
                                  setState(() => _selectedGender = value!),
                            ),
                            const Text('Male'),
                            Radio<String>(
                              value: 'Female',
                              groupValue: _selectedGender,
                              onChanged: (value) =>
                                  setState(() => _selectedGender = value!),
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
            // Step 1: Contact
            Step(
              title: const Text('Contact'),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
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
                        if (value == null || value.isEmpty) return 'Required';
                        if (!value.contains('@')) return 'Invalid email';
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
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
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
                      onChanged: (value) =>
                          setState(() => _selectedBranch = value),
                      validator: (value) =>
                          value == null ? 'Please select a branch' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      initialValue: _selectedDistrict,
                      decoration: const InputDecoration(
                        labelText: 'District',
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      items: districts
                          .map((district) => DropdownMenuItem(
                                value: district.id,
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
              title: const Text('Skills'),
              isActive: _currentStep >= 2,
              state: _currentStep > 2 ? StepState.complete : StepState.indexed,
              content: Form(
                key: _formKeys[2],
                child: Column(
                  children: [
                    DropdownButtonFormField<int>(
                      initialValue: _selectedSpecializationId,
                      decoration: const InputDecoration(
                        labelText: 'Key Specialization',
                        border: OutlineInputBorder(),
                      ),
                      items: specializations
                          .map((spec) => DropdownMenuItem<int>(
                                value: spec.id, // int
                                child: Text(spec.name),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _selectedSpecializationId = value),
                      validator: (value) =>
                          value == null ? 'Please select specialization' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _otherSkillsController,
                      decoration: const InputDecoration(
                        labelText: 'Other Skills (Optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _primaryLanguageController,
                      decoration: const InputDecoration(
                        labelText: 'Primary Language',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _otherLanguageController,
                      decoration: const InputDecoration(
                        labelText: 'Other Language',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Step 3: Education
            Step(
              title: const Text('Education'),
              isActive: _currentStep >= 3,
              state: _currentStep > 3 ? StepState.complete : StepState.indexed,
              content: Form(
                key: _formKeys[3],
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _selectedEducationLevel,
                      decoration: const InputDecoration(
                        labelText: 'Education Level',
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
                      decoration: const InputDecoration(
                        labelText: 'References',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            // Step 4: Password
            Step(
              title: const Text('Password'),
              isActive: _currentStep >= 4,
              state: _currentStep > 4 ? StepState.complete : StepState.indexed,
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
                        if (value == null || value.isEmpty) return 'Required';
                        if (value.length < 6) return 'Min 6 characters';
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
    );
  }
}
