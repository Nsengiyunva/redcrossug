// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/models/blood_bank.dart';
import 'package:redcross/utils/storage_service.dart';

class BookAppointment extends StatefulWidget {
  final BloodBank bloodBank;

  const BookAppointment({super.key, required this.bloodBank});

  @override
  State<BookAppointment> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointment> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  DateTime? _preferredDate;
  String? _timePreference;
  bool _isLoading = false;

  final List<String> _timePreferences = [
    'Morning',
    'Afternoon',
    'Evening',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _preferredDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.red,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _preferredDate) {
      setState(() {
        _preferredDate = picked;
      });
    }
  }

  Future<void> _submitAppointment() async {
    if (!_formKey.currentState!.validate()) return;

    if (_preferredDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a preferred donation date'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final token = await StorageService.getToken();

      final appointmentData = {
        'preferred_blood_bank_id': widget.bloodBank.id,
        'preferred_donation_date':
            _preferredDate!.toIso8601String().split('T')[0],
        'time_preference': _timePreference,
        'notes': _notesController.text.isEmpty ? null : _notesController.text,
      };

      final response = await http.post(
        Uri.parse(
            'https://urcs-api.taufeeq.dev/api/blood-donation/appointments'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Requested-With": "XMLHttpRequest",
        },
        body: jsonEncode(appointmentData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment booked successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Navigate back after a short delay
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit appointment. Status: ${response.statusCode}',
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      print("Error submitting appointment: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error, please try again.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Book Appointment',
                        style: TextStyle(
                          fontSize: screenWidth * 0.09,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Schedule your blood donation',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Blood Bank Card
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.local_hospital,
                                color: Colors.red,
                                size: screenWidth * 0.08,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.bloodBank.name,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.042,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    widget.bloodBank.district,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Date Picker
                      Text(
                        'Preferred Donation Date',
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
                              const Icon(Icons.calendar_today,
                                  color: Colors.red),
                              SizedBox(width: screenWidth * 0.03),
                              Text(
                                _preferredDate == null
                                    ? 'Select date'
                                    : '${_preferredDate!.day}/${_preferredDate!.month}/${_preferredDate!.year}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: _preferredDate == null
                                      ? Colors.grey[400]
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      // Time Preference
                      Text(
                        'Time Preference',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      DropdownButtonFormField<String>(
                        initialValue: _timePreference,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Select time preference',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.02,
                          ),
                          prefixIcon:
                              const Icon(Icons.access_time, color: Colors.red),
                        ),
                        items: _timePreferences.map((String time) {
                          return DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _timePreference = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your time preference';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      // Notes
                      Text(
                        'Notes (Optional)',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: _notesController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          hintText:
                              'E.g., Regular donor, AB+ blood type. Last donation was 3 months ago.',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.02,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),

                      // Submit Button
                      // ElevatedButton(
                      //   onPressed: _isLoading ? null : _submitAppointment,
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.red,
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: screenHeight * 0.02),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //   ),
                      //   child: _isLoading
                      //       ? const CircularProgressIndicator(
                      //           color: Colors.white,
                      //         )
                      //       : Text(
                      //           'Confirm Appointment',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: screenWidth * 0.045,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      // ),
                      SizedBox(
                        width: double.infinity, // make button full width
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitAppointment,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal:
                                  screenWidth * 0.05, // horizontal padding
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: screenHeight * 0.03,
                                  width: screenHeight * 0.03,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  'Submit Appointment',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
