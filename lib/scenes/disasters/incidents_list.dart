import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncidentsList extends StatefulWidget {
  const IncidentsList({Key? key}) : super(key: key);

  @override
  State<IncidentsList> createState() => _IncidentReportsScreenState();
}

class _IncidentReportsScreenState extends State<IncidentsList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Incident Reports',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.red,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Active Reports'),
                Tab(text: 'Resolved'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildReportsList(false),
                _buildReportsList(true),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildReportsList(bool showResolved) {
    final reports = _getFilteredReports(showResolved);

    if (reports.isEmpty) {
      return Center(
        child: Text(
          showResolved ? 'No resolved reports' : 'No active reports',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return _buildReportCard(reports[index]);
      },
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    final hasMedia = (report['media'] as List).isNotEmpty;
    final imageUrl = hasMedia ? report['media'][0]['file_url'] : null;
    final isEmergency = report['is_emergency'] ?? false;
    final status = report['status'] ?? 'submitted';
    final timeSince = report['time_since_reported'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Handle tap
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image or placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  image: hasMedia
                      ? DecorationImage(
                          image: NetworkImage(imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: !hasMedia
                    ? Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.grey[400],
                        size: 40,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            report['title'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isEmergency)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'EMERGENCY',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      report['description'] ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            report['district'] ??
                                report['location_address'] ??
                                '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getStatusLabel(status),
                            style: TextStyle(
                              color: _getStatusColor(status),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeSince,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, 'Home', false),
              _buildNavItem(Icons.bloodtype_outlined, 'B. Donation', false),
              _buildNavItem(
                  Icons.medical_services_outlined, 'First Aid', false),
              _buildNavItem(Icons.person_outline, 'Profile', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.red : Colors.grey,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.red : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredReports(bool showResolved) {
    // Sample data from the payload
    final allReports = [
      {
        "id": 8,
        "title": "Lightning in Bunyangabu",
        "description": "Heavy Storms/ Hailstorms in Bunyangabu",
        "location_address": "Bunyagabu",
        "district": "Bunyangabu",
        "incident_type": "lightning",
        "severity_level": "serious",
        "status": "submitted",
        "is_emergency": true,
        "time_since_reported": "22 hours ago",
        "media": []
      },
      {
        "id": 7,
        "title": "Lightning in Bunyangabu",
        "description": "Heavy Storms/ Hailstorms in Bunyangabu",
        "location_address": "Bunyagabu",
        "district": "Bunyangabu",
        "incident_type": "lightning",
        "severity_level": "serious",
        "status": "resolved",
        "is_emergency": true,
        "time_since_reported": "5 days ago",
        "media": [
          {
            "file_url":
                "/storage/incident-reports/7/Jh96IgD0dXoUuk2qfhuD8naU7KdGA6Xg.jpg"
          }
        ]
      },
      {
        "id": 6,
        "title": "Heavy Storms/ Hailstorms in Bunyangabu",
        "description": "Heavy Storms/ Hailstorms in Bunyangabu",
        "location_address": "Bunyagabu",
        "district": "Bunyangabu",
        "incident_type": "heavy_storms_hailstorms",
        "severity_level": "serious",
        "status": "submitted",
        "is_emergency": true,
        "time_since_reported": "5 days ago",
        "media": [
          {
            "file_url":
                "/storage/incident-reports/6/HsJGq5lnhQWtT0Dqvxw9XXJJiXhAjId7.jpg"
          }
        ]
      },
    ];

    return allReports
        .where((report) => showResolved
            ? report['status'] == 'resolved'
            : report['status'] != 'resolved')
        .toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'in_progress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return 'Submitted';
      case 'resolved':
        return 'Resolved';
      case 'in_progress':
        return 'In Progress';
      default:
        return status;
    }
  }
}
