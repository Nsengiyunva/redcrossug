// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/models/incident.dart';
import 'package:redcross/scenes/disasters/disaster_list.dart';
// import 'package:redcross/models/incident_user.dart';
import 'package:redcross/scenes/incidents/create_incident_report.dart';
import 'package:redcross/scenes/incidents/incident_details.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class IncidentList extends StatefulWidget {
  const IncidentList({super.key});

  @override
  State<IncidentList> createState() => _IncidentReportsListScreenState();
}

class _IncidentReportsListScreenState extends State<IncidentList> {
  bool showFilters = false;
  String? selectedIncidentType;
  String? selectedSeverity;
  String? selectedStatus;
  String? selectedDistrict;

  bool isLoading = true;

  List<Incident> allReports = [];

  @override
  void initState() {
    super.initState();
    fetchIncidents();
  }

  Future<void> fetchIncidents() async {
    final token = await StorageService.getToken();

    if (token == null || token.isEmpty) {
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("https://urcs-api.taufeeq.dev/api/incident-reports"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'X-Requested-With': 'XMLHttpRequest'
        },
      );

      // print("STATUS: ${response.statusCode}");
      // print("BODY: ${response.body}"); // 👀 See the response here

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final List incidentList = decoded["data"]["data"];

        setState(() {
          allReports =
              incidentList.map((json) => Incident.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      // print("FETCH ERROR: $e");
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch incidents'),
          backgroundColor: AppColors.primaryRedColor,
        ),
      );
    }
  }

  List<Incident> get filteredReports {
    return allReports.where((report) {
      bool matchesType = selectedIncidentType == null ||
          report.incidentType == selectedIncidentType;

      bool matchesSeverity =
          selectedSeverity == null || report.severityLevel == selectedSeverity;

      bool matchesStatus =
          selectedStatus == null || report.status == selectedStatus;

      bool matchesDistrict =
          selectedDistrict == null || report.district == selectedDistrict;

      return matchesType && matchesSeverity && matchesStatus && matchesDistrict;
    }).toList();
  }

  void _clearFilters() {
    setState(() {
      selectedIncidentType = null;
      selectedSeverity = null;
      selectedStatus = null;
      selectedDistrict = null;
    });
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return AppColors.primaryRedColor;
      case 'serious':
        return Colors.orange;
      case 'moderate':
        return Colors.yellow.shade700;
      case 'minor':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return Colors.blue;
      case 'in_progress':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryRedColor),
        ),
      );
    }

    final hasActiveFilters = selectedIncidentType != null ||
        selectedSeverity != null ||
        selectedStatus != null ||
        selectedDistrict != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DisasterList()),
            );
          },
        ),
        title: const Text(
          'Incident Reports',
          style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter"),
        ),
        actions: const [
          // IconButton(
          //   icon: const Icon(Icons.search, color: Colors.black),
          //   onPressed: () {

          //   },
          // ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      showFilters = false;
                      _clearFilters();
                    });
                  },
                  child: Text(
                    'ALL REPORTS',
                    style: TextStyle(
                      color: !showFilters
                          ? AppColors.primaryRedColor
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showFilters = true;
                    });
                  },
                  child: Text(
                    'FILTER',
                    style: TextStyle(
                        color: showFilters ? Colors.red : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: "Inter"),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment:
                  showFilters ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 100,
                height: 2,
                color: Colors.red,
              ),
            ),
          ),

          // Filter UI or Active Filters
          if (showFilters && !hasActiveFilters)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildFilterDropdown(
                      'Incident Type',
                      selectedIncidentType,
                      [
                        'lightning',
                        'heavy_storms_hailstorms',
                        'flood',
                        'earthquake',
                        'fire'
                      ],
                      (value) => setState(() => selectedIncidentType = value),
                    ),
                    const SizedBox(height: 16),
                    _buildFilterDropdown(
                      'Severity Level',
                      selectedSeverity,
                      ['critical', 'serious', 'moderate', 'minor'],
                      (value) => setState(() => selectedSeverity = value),
                    ),
                    const SizedBox(height: 16),
                    _buildFilterDropdown(
                      'Status',
                      selectedStatus,
                      ['submitted', 'in_progress', 'resolved', 'closed'],
                      (value) => setState(() => selectedStatus = value),
                    ),
                    const SizedBox(height: 16),
                    _buildFilterDropdown(
                      'District',
                      selectedDistrict,
                      ['Bunyangabu', 'Kampala', 'Kasese', 'Mbale', 'Mbarara'],
                      (value) => setState(() => selectedDistrict = value),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryRedColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'View Reports',
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
            )
          else
            Expanded(
              child: Column(
                children: [
                  if (hasActiveFilters)
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (selectedIncidentType != null)
                            _buildFilterChip(selectedIncidentType!, () {
                              setState(() => selectedIncidentType = null);
                            }),
                          if (selectedSeverity != null)
                            _buildFilterChip(selectedSeverity!, () {
                              setState(() => selectedSeverity = null);
                            }),
                          if (selectedStatus != null)
                            _buildFilterChip(selectedStatus!, () {
                              setState(() => selectedStatus = null);
                            }),
                          if (selectedDistrict != null)
                            _buildFilterChip(selectedDistrict!, () {
                              setState(() => selectedDistrict = null);
                            }),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredReports.length,
                      itemBuilder: (context, index) {
                        return _buildReportCard(filteredReports[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateIncidentReport(),
            ),
          );
        },
        backgroundColor: AppColors.primaryRedColor,
        child: const Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String? value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(label),
          value: value,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option.replaceAll('_', ' ').toUpperCase()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.replaceAll('_', ' ').toUpperCase(),
            style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter"),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.cancel,
              color: Colors.red,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(Incident report) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IncidentDetails(report: report),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getSeverityColor(report.severityLevel)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    report.severityLevel.toUpperCase(),
                    style: TextStyle(
                        color: _getSeverityColor(report.severityLevel),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter"),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(report.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    report.status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(report.status),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                if (report.isEmergency)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'EMERGENCY',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter"),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              report.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  report.district,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontFamily: "Inter"),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  report.timeSinceReported,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontFamily: "Inter"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              report.description,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontFamily: "Inter"),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
