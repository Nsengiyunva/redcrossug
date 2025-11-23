// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:redcross/utils/colors.dart';

// class CreateIncidentReport extends StatefulWidget {
//   const CreateIncidentReport({super.key});

//   @override
//   State<CreateIncidentReport> createState() =>
//       _CreateIncidentReportScreenState();
// }

// class _CreateIncidentReportScreenState extends State<CreateIncidentReport> {
//   final _formKey = GlobalKey<FormState>();
//   final _descriptionController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _contactController = TextEditingController();
//   final _titleController = TextEditingController();
//   final _latitudeController = TextEditingController();
//   final _longitudeController = TextEditingController();
//   final _districtController = TextEditingController();
//   final _notesController = TextEditingController();

//   String? selectedIncidentType;
//   String? selectedSeverity;
//   List<File> selectedMedia = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Report Incident',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             _buildTextField(
//               controller: _titleController,
//               label: 'Title',
//               hint: 'Lightning in Bunyangabu',
//               required: true,
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               controller: _descriptionController,
//               label: 'Description',
//               hint: 'Heavy Storms/ Hailstorms in Bunyangabu',
//               maxLines: 3,
//               required: true,
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               controller: _locationController,
//               label: 'Location Address',
//               hint: 'Bunyagabu',
//               required: true,
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               controller: _contactController,
//               label: 'Contact Phone',
//               hint: '0762775625',
//               keyboardType: TextInputType.phone,
//               required: true,
//             ),
//             const SizedBox(height: 16),
//             _buildDropdownField(
//               label: 'Incident Type',
//               value: selectedIncidentType,
//               items: [
//                 'lightning',
//                 'heavy_storms_hailstorms',
//                 'flood',
//                 'earthquake',
//                 'fire'
//               ],
//               onChanged: (value) =>
//                   setState(() => selectedIncidentType = value),
//             ),
//             const SizedBox(height: 16),
//             _buildDropdownField(
//               label: 'Severity Level',
//               value: selectedSeverity,
//               items: ['critical', 'serious', 'moderate', 'minor'],
//               onChanged: (value) => setState(() => selectedSeverity = value),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildTextField(
//                     controller: _latitudeController,
//                     label: 'Latitude',
//                     hint: '0.4871',
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     required: true,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: _buildTextField(
//                     controller: _longitudeController,
//                     label: 'Longitude',
//                     hint: '30.2051',
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     required: true,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               controller: _districtController,
//               label: 'District',
//               hint: 'Bunyangabu',
//               required: true,
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               controller: _notesController,
//               label: 'Additional Notes',
//               hint: 'Optional notes',
//               maxLines: 3,
//             ),
//             const SizedBox(height: 24),
//             _buildMediaSection(),
//             const SizedBox(height: 32),
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: _submitReport,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryRedColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Submit Report',
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.whiteColor),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     int maxLines = 1,
//     TextInputType? keyboardType,
//     bool required = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: label,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//             children: [
//               if (required)
//                 const TextSpan(
//                   text: ' *',
//                   style: TextStyle(color: Colors.red),
//                 ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           maxLines: maxLines,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             hintText: hint,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Colors.red),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           ),
//           validator: required
//               ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return '$label is required';
//                   }
//                   return null;
//                 }
//               : null,
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownField({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: label,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//             children: const [
//               TextSpan(
//                 text: ' *',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               isExpanded: true,
//               hint: Text('Select $label'),
//               value: value,
//               items: items.map((String item) {
//                 return DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(item.replaceAll('_', ' ').toUpperCase()),
//                 );
//               }).toList(),
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMediaSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Media',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             children: [
//               Icon(Icons.cloud_upload_outlined,
//                   size: 48, color: Colors.grey.shade400),
//               const SizedBox(height: 8),
//               TextButton(
//                 onPressed: () {
//                   // File picker would go here
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('File picker would open here')),
//                   );
//                 },
//                 child: const Text(
//                   'Upload Image/Video',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//               Text(
//                 'Tap to select files',
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _submitReport() {
//     if (_formKey.currentState!.validate()) {
//       if (selectedIncidentType == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please select incident type')),
//         );
//         return;
//       }
//       if (selectedSeverity == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please select severity level')),
//         );
//         return;
//       }

//       // Submit logic would go here
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Report submitted successfully')),
//       );
//       Navigator.pop(context);
//     }
//   }
// }

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/scenes/incidents/incident_list.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class CreateIncidentReport extends StatefulWidget {
  const CreateIncidentReport({super.key});

  @override
  State<CreateIncidentReport> createState() =>
      _CreateIncidentReportScreenState();
}

class _CreateIncidentReportScreenState extends State<CreateIncidentReport> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();
  final _titleController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _districtController = TextEditingController();
  final _notesController = TextEditingController();

  String? selectedIncidentType;
  String? selectedSeverity;
  List<File> selectedMedia = [];

  bool _isLoading = false;

  // Incident types mapping
  final Map<String, String> incidentTypes = {
    "drought": "Drought",
    "floods": "Floods",
    "heavy_storms_hailstorms": "Heavy Storms/ Hailstorms",
    "lightning": "Lightning",
    "earthquakes": "Earthquakes",
    "landslides_and_mudslides": "Landslides and Mudslides",
    "collapsed_structure_buildings_earth_quarry":
        "Collapsed Structure/Buildings/ Earth.Quarry",
    "human_epidemics": "Human Epidemics",
    "pandemics": "Pandemics",
    "disease_outbreak_suspected": "Disease Outbreak (Suspected)",
    "food_poisoning": "Food Poisoning",
    "famine_food_insecurity": "Famine / Food Insecurity",
    "crop_and_animal_disease": "Crop and Animal Disease",
    "pests_infestation_worm_locusts": "Pests Infestation (Worm/ Locusts)",
    "fires": "Fires",
    "transport_related_accidents": "Transport Related Accidents",
    "boating_accident": "Boating Accident",
    "plane_crash": "Plane Crash",
    "internal_armed_conflicts_and_internal_displacement":
        "Internal Armed Conflicts and Internal Displacement of Persons",
    "mines_and_unexploded_ordinances":
        "Mines and Un Exploded Ordinances (UXOs)",
    "land_conflicts": "Land Conflicts",
    "terrorism": "Terrorism",
    "cattle_rustling": "Cattle Rustling",
    "public_riots": "Public Riots",
    "industrial_and_technological_hazards":
        "Industrial and Technological Hazards",
    "other_retrogressive_cultural_practices":
        "Other Retrogressive Cultural Practices",
    "environmental_degradation": "Environmental Degradation",
    "unknown": "Not Sure / Unknown",
    "other": "Other"
  };

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    _titleController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _districtController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Report Incident',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildTextField(
                  controller: _titleController,
                  label: 'Title',
                  hint: 'Lightning in Bunyangabu',
                  required: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'Heavy Storms/ Hailstorms in Bunyangabu',
                  maxLines: 3,
                  required: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _locationController,
                  label: 'Location Address',
                  hint: 'Bunyagabu',
                  required: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _contactController,
                  label: 'Contact Phone',
                  hint: '0762775625',
                  keyboardType: TextInputType.phone,
                  required: true,
                ),
                const SizedBox(height: 16),
                _buildDropdownField(
                  label: 'Incident Type',
                  value: selectedIncidentType,
                  items: incidentTypes.keys.toList(),
                  onChanged: (value) =>
                      setState(() => selectedIncidentType = value),
                  itemLabelMapper: (key) => incidentTypes[key]!,
                ),
                const SizedBox(height: 16),
                _buildDropdownField(
                  label: 'Severity Level',
                  value: selectedSeverity,
                  items: ['critical', 'serious', 'moderate', 'minor'],
                  onChanged: (value) =>
                      setState(() => selectedSeverity = value),
                  itemLabelMapper: (key) =>
                      key[0].toUpperCase() + key.substring(1),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _latitudeController,
                        label: 'Latitude',
                        hint: '0.4871',
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        required: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _longitudeController,
                        label: 'Longitude',
                        hint: '30.2051',
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        required: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _districtController,
                  label: 'District',
                  hint: 'Bunyangabu',
                  required: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _notesController,
                  label: 'Additional Notes',
                  hint: 'Optional notes',
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                _buildMediaSection(),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitReport,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit Report',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: [
              if (required)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
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
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: required
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '$label is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required String Function(String) itemLabelMapper,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select $label'),
              value: value,
              items: items.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(itemLabelMapper(key)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Media',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(Icons.cloud_upload_outlined,
                  size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // File picker integration goes here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('File picker would open here')),
                  );
                },
                child: const Text(
                  'Upload Image/Video',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Text(
                'Tap to select files',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedIncidentType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select incident type')),
      );
      return;
    }

    if (selectedSeverity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select severity level')),
      );
      return;
    }

    final token = await StorageService.getToken();

    setState(() => _isLoading = true);

    final requestData = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "location_address": _locationController.text,
      "contact_number": _contactController.text,
      "incident_type": selectedIncidentType,
      "severity": selectedSeverity,
      "latitude": _latitudeController.text,
      "longitude": _longitudeController.text,
      "district": _districtController.text,
      "additional_notes":
          _notesController.text.isEmpty ? null : _notesController.text,
      // For now, media upload is not integrated
    };

    // print("payload $requestData");

    try {
      final response = await http.post(
        Uri.parse('https://urcs-api.taufeeq.dev/api/incident-reports'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Requested-With": "XMLHttpRequest"
        },
        body: jsonEncode(requestData),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Incident report submitted successfully!'),
              backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const IncidentList()),
        );
      } else {
        print("here $json");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Failed to submit report: ${response.statusCode} ${json["message"]}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting report: $e')),
      );

      print("error $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

// Replace this with your actual list screen
class IncidentReportsListScreen extends StatelessWidget {
  const IncidentReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Incident Reports')),
      body: const Center(child: Text('List of submitted incidents here')),
    );
  }
}
