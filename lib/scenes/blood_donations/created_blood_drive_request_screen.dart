import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/models/blood_drive_request.dart';

// ==================== CREATE BLOOD DRIVE REQUEST SCREEN ====================

class CreateBloodDriveRequestScreen extends StatefulWidget {
  const CreateBloodDriveRequestScreen({Key? key}) : super(key: key);

  @override
  State<CreateBloodDriveRequestScreen> createState() =>
      _CreateBloodDriveRequestScreenState();
}

class _CreateBloodDriveRequestScreenState
    extends State<CreateBloodDriveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _organizationNameController = TextEditingController();
  final _expectedDonorsController = TextEditingController();
  final _districtController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _additionalNotesController = TextEditingController();

  DateTime? _requestedDate;
  bool _hasTents = false;
  bool _hasPublicAddress = false;
  bool _hasChairs = false;
  bool _hasTables = false;

  @override
  void dispose() {
    _organizationNameController.dispose();
    _expectedDonorsController.dispose();
    _districtController.dispose();
    _locationController.dispose();
    _contactPersonController.dispose();
    _contactNumberController.dispose();
    _contactEmailController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _requestedDate ?? DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
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
    if (picked != null && picked != _requestedDate) {
      setState(() {
        _requestedDate = picked;
      });
    }
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      if (_requestedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a requested date'),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final requestData = {
        'organization_name': _organizationNameController.text,
        'expected_donors': int.parse(_expectedDonorsController.text),
        'district': _districtController.text,
        'location': _locationController.text,
        'contact_person': _contactPersonController.text,
        'contact_number': _contactNumberController.text,
        'contact_email': _contactEmailController.text,
        'has_tents': _hasTents,
        'has_public_address': _hasPublicAddress,
        'has_chairs': _hasChairs,
        'has_tables': _hasTables,
        'requested_date': _requestedDate?.toIso8601String().split('T')[0],
        'additional_notes': _additionalNotesController.text.isEmpty
            ? null
            : _additionalNotesController.text,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Blood drive request submitted successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      print('Request Data: $requestData');

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
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
                  Text(
                    'Request Blood Drive',
                    style: TextStyle(
                      fontSize: screenWidth * 0.09,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Organize a blood donation campaign',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Organization Name
                  _buildLabel('Organization Name', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: _organizationNameController,
                    hintText: 'e.g., Kampala International University',
                    icon: Icons.business,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter organization name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Expected Donors
                  _buildLabel('Expected Donors', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: _expectedDonorsController,
                    hintText: 'e.g., 150',
                    icon: Icons.people,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter expected number of donors';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // District
                  _buildLabel('District', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: _districtController,
                    hintText: 'e.g., Kampala',
                    icon: Icons.location_city,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter district';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Location
                  _buildLabel('Location', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: _locationController,
                    hintText: 'e.g., KIU Main Campus, Medical Faculty Building',
                    icon: Icons.location_on,
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Contact Person
                  _buildLabel('Contact Person', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: _contactPersonController,
                    hintText: 'e.g., Dr. Sarah Nakamya',
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact person';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Contact Number
                  _buildLabel('Contact Number', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: _contactNumberController,
                    hintText: 'e.g., +256700123456',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Contact Email
                  _buildLabel('Contact Email', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  _buildTextField(
                    controller: _contactEmailController,
                    hintText: 'e.g., contact@organization.com',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter contact email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Requested Date
                  _buildLabel('Requested Date', screenWidth),
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
                            _requestedDate == null
                                ? 'Select date'
                                : DateFormat('yyyy-MM-dd')
                                    .format(_requestedDate!),
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: _requestedDate == null
                                  ? Colors.grey[400]
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Facilities Available
                  _buildLabel('Facilities Available', screenWidth),
                  SizedBox(height: screenHeight * 0.015),
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildCheckbox(
                          'Tents',
                          _hasTents,
                          (value) => setState(() => _hasTents = value!),
                          screenWidth,
                        ),
                        Divider(height: 1),
                        _buildCheckbox(
                          'Public Address System',
                          _hasPublicAddress,
                          (value) => setState(() => _hasPublicAddress = value!),
                          screenWidth,
                        ),
                        Divider(height: 1),
                        _buildCheckbox(
                          'Chairs',
                          _hasChairs,
                          (value) => setState(() => _hasChairs = value!),
                          screenWidth,
                        ),
                        Divider(height: 1),
                        _buildCheckbox(
                          'Tables',
                          _hasTables,
                          (value) => setState(() => _hasTables = value!),
                          screenWidth,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  // Additional Notes
                  _buildLabel('Additional Notes (Optional)', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: _additionalNotesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      hintText:
                          'Any additional information about the event, preferred time, or special requirements...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Submit Button
                  GestureDetector(
                    onTap: _submitRequest,
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
                          'Submit Request',
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

  Widget _buildLabel(String label, double screenWidth) {
    return Text(
      label,
      style: TextStyle(
        fontSize: screenWidth * 0.04,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(icon, color: Colors.red),
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildCheckbox(String label, bool value,
      void Function(bool?) onChanged, double screenWidth) {
    return CheckboxListTile(
      title: Text(
        label,
        style: TextStyle(fontSize: screenWidth * 0.04),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.red,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
