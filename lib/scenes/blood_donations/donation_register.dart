// ignore_for_file: use_build_context_synchronously, avoid_print, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/utils/storage_service.dart';

class DonationRegister extends StatefulWidget {
  const DonationRegister({super.key});

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
  bool _isDonor = false;

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

  late Future<void> _loadDonorFuture;

  @override
  void initState() {
    super.initState();
    _loadDonorFuture = _checkAndPrefillDonor();
  }

  @override
  void dispose() {
    _serialNoController.dispose();
    _phoneNoController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _checkAndPrefillDonor() async {
    String? token = await StorageService.getToken();

    try {
      final response = await http.get(
        Uri.parse(
            "https://urcs-api.taufeeq.dev/api/blood-donation/user/blood-donor-profile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['success'] == true && json['data'] != null) {
          final donor = json['data'];

          setState(() {
            _selectedBloodType = donor['blood_type'];
            _serialNoController.text = donor['serial_no'] ?? '';
            _locationController.text = donor['location'] ?? '';
            _phoneNoController.text = donor['phone_no'] ?? '';
            _lastDonationDate =
                DateTime.tryParse(donor['last_donation_date'] ?? '');
            _isDonor = true;
          });
        }
      } else if (response.statusCode == 404) {
        // Not a donor → leave form empty
      }
    } catch (e) {
      print("Error checking donor: $e");
    }
  }

  // ===================== DATE PICKER ======================
  Future<void> _selectDate(BuildContext context) async {
    if (_isDonor) return; // disable for registered donors

    final picked = await showDatePicker(
      context: context,
      initialDate: _lastDonationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _lastDonationDate = picked);
    }
  }

  // ===================== SUBMIT ======================
  void _submitForm() async {
    if (_isDonor) return; // cannot submit again
    if (!_formKey.currentState!.validate()) return;

    var token = await StorageService.getToken();

    final donorData = {
      "blood_type": _selectedBloodType,
      "serial_no": _serialNoController.text,
      "location": _locationController.text,
      "phone_no": _phoneNoController.text,
      "last_donation_date": _lastDonationDate?.toIso8601String().split('T')[0],
    };

    try {
      final response = await http.post(
        Uri.parse('https://urcs-api.taufeeq.dev/api/blood-donation/donors'),
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(donorData),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                result['message'] ?? 'Failed to register. Please try again!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: _loadDonorFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  Text(
                    _isDonor
                        ? "You're already registered"
                        : "Register as a Donor",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    _isDonor ? "Your donor details" : "Fill the form below",
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 30),

                  // =================== BLOOD TYPE ===================
                  Text("Blood Type", style: titleStyle()),
                  const SizedBox(height: 6),

                  AbsorbPointer(
                    absorbing: _isDonor,
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedBloodType,
                      decoration: inputStyle(),
                      items: _bloodTypes.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (v) => setState(() => _selectedBloodType = v),
                      validator: (value) {
                        if (!_isDonor && (value == null || value.isEmpty)) {
                          return "Please select a blood type";
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================== SERIAL NUMBER ===================
                  Text("Serial Number", style: titleStyle()),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _serialNoController,
                    readOnly: _isDonor,
                    decoration: inputStyle(),
                    validator: (value) {
                      if (!_isDonor && (value == null || value.isEmpty)) {
                        return "Enter serial number";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // =================== PHONE ===================
                  Text("Phone Number", style: titleStyle()),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _phoneNoController,
                    readOnly: _isDonor,
                    keyboardType: TextInputType.phone,
                    decoration: inputStyle().copyWith(
                      prefixIcon: const Icon(Icons.phone, color: Colors.red),
                    ),
                    validator: (value) {
                      if (!_isDonor && (value == null || value.isEmpty)) {
                        return "Enter phone number";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // =================== LOCATION ===================
                  Text("Location", style: titleStyle()),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _locationController,
                    readOnly: _isDonor,
                    maxLines: 2,
                    decoration: inputStyle().copyWith(
                      prefixIcon:
                          const Icon(Icons.location_on, color: Colors.red),
                    ),
                    validator: (value) {
                      if (!_isDonor && (value == null || value.isEmpty)) {
                        return "Enter your location";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // =================== LAST DONATION DATE ===================
                  Text("Last Donation Date", style: titleStyle()),
                  const SizedBox(height: 6),

                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      absorbing: true,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.red),
                            const SizedBox(width: 10),
                            Text(
                              _lastDonationDate == null
                                  ? "Select date"
                                  : "${_lastDonationDate!.day}/${_lastDonationDate!.month}/${_lastDonationDate!.year}",
                              style: TextStyle(
                                color: _isDonor ? Colors.grey : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // =================== SUBMIT BUTTON ===================
                  GestureDetector(
                    onTap: _isDonor ? null : _submitForm,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: _isDonor ? Colors.grey : Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          _isDonor ? "Already Registered" : "Register as Donor",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // =================== Reusable Styles ===================
  InputDecoration inputStyle() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  TextStyle titleStyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.grey[800],
    );
  }
}
