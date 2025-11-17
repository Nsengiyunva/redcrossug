import 'package:flutter/material.dart';
import 'package:redcross/models/incident.dart';
import 'package:redcross/models/incident_user.dart';
import 'package:redcross/scenes/incidents/create_incident_report.dart';
import 'package:redcross/scenes/incidents/incident_details.dart';

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

  final List<Incident> allReports = [
    Incident(
      id: 8,
      title: 'Lightning in Bunyangabu',
      description: 'Heavy Storms/ Hailstorms in Bunyangabu',
      incidentType: 'lightning',
      severityLevel: 'serious',
      status: 'submitted',
      district: 'Bunyangabu',
      locationAddress: 'Bunyagabu',
      contactPhone: '0762775625',
      latitude: 0.48710000,
      longitude: 30.20510000,
      timeSinceReported: '3 days ago',
      createdAt: DateTime.parse('2025-11-11T10:51:48.000000Z'),
      isEmergency: true,
      priorityScore: 130,
      additionalNotes: 'N/A',
      media: [],
      statusHistory: [],
      user: IncidentUser(
        id: 1,
        name: 'Joe Biden',
        email: 'nsambataufeeq@gmail.com',
        phoneNo: '+256751830778',
        membershipId: 'URCS-102/M/3768/2024',
      ),
    ),
    Incident(
      id: 7,
      title: 'Lightning in Bunyangabu',
      description: 'Heavy Storms/ Hailstorms in Bunyangabu',
      incidentType: 'lightning',
      severityLevel: 'serious',
      status: 'resolved',
      district: 'Bunyangabu',
      locationAddress: 'Bunyagabu',
      contactPhone: '0762775625',
      latitude: 0.48710000,
      longitude: 30.20510000,
      timeSinceReported: '1 week ago',
      createdAt: DateTime.parse('2025-11-06T14:37:18.000000Z'),
      isEmergency: true,
      priorityScore: 130,
      additionalNotes: 'N/A',
      media: [],
      statusHistory: [],
      user: IncidentUser(
        id: 1,
        name: 'Joe Biden',
        email: 'nsambataufeeq@gmail.com',
        phoneNo: '+256751830778',
        membershipId: 'URCS-102/M/3768/2024',
      ),
    ),
    Incident(
      id: 6,
      title: 'Heavy Storms/ Hailstorms in Bunyangabu',
      description: 'Heavy Storms/ Hailstorms in Bunyangabu',
      incidentType: 'heavy_storms_hailstorms',
      severityLevel: 'serious',
      status: 'submitted',
      district: 'Bunyangabu',
      locationAddress: 'Bunyagabu',
      contactPhone: '0762775625',
      latitude: 0.48710000,
      longitude: 30.20510000,
      timeSinceReported: '1 week ago',
      createdAt: DateTime.parse('2025-11-06T14:36:17.000000Z'),
      isEmergency: true,
      priorityScore: 130,
      additionalNotes: 'N/A',
      media: [],
      statusHistory: [],
      user: IncidentUser(
        id: 1,
        name: 'Joe Biden',
        email: 'nsambataufeeq@gmail.com',
        phoneNo: '+256751830778',
        membershipId: 'URCS-102/M/3768/2024',
      ),
    ),
  ];

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
        return Colors.red;
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
    final hasActiveFilters = selectedIncidentType != null ||
        selectedSeverity != null ||
        selectedStatus != null ||
        selectedDistrict != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {},
        ),
        title: const Text(
          'Incident Reports',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
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
                      color: !showFilters ? Colors.red : Colors.grey,
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
                    ),
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
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'View Reports',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      // bottomNavigationBar: _buildBottomNav(),
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
            ),
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
                    ),
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
                          ),
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
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  report.timeSinceReported,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              report.description,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.report_outlined), label: 'Reports'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services_outlined), label: 'First Aid'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
