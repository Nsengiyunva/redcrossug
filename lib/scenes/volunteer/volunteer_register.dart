import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:redcross/utils/colors.dart';

class VolunteerRegister extends StatefulWidget {
  const VolunteerRegister({Key? key}) : super(key: key);

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
  String? _selectedBranch;
  String? _selectedSpecialization;
  String? _selectedEducationLevel;

  // File Variables
  File? _highestQualificationFile;
  File? _passportPhoto;

  final ImagePicker _picker = ImagePicker();

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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration submitted successfully!')),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration Form'),
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
                              value: _nationalIdController.text.isEmpty
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
                            child: DropdownButtonFormField<String>(
                              value: _selectedBranch,
                              decoration: const InputDecoration(
                                labelText: 'URCS Branch',
                                hintText: 'Choose a Branch',
                                border: OutlineInputBorder(),
                              ),
                              items: ['Kampala', 'Entebbe', 'Jinja', 'Mbarara']
                                  .map((branch) => DropdownMenuItem(
                                      value: branch, child: Text(branch)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedBranch = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select branch';
                                }
                                return null;
                              },
                            ),
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
                        value: _selectedSpecialization,
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
                        value: _selectedEducationLevel,
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
