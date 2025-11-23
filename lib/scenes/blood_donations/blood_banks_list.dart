import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/models/blood_bank.dart';

import 'package:redcross/scenes/blood_donations/appointments.dart';
import 'package:redcross/scenes/blood_donations/book_appointment.dart';

class BloodBanksList extends StatefulWidget {
  const BloodBanksList({super.key});

  @override
  State<BloodBanksList> createState() => _BloodBanksScreenState();
}

class _BloodBanksScreenState extends State<BloodBanksList> {
  List<BloodBank> bloodBanks = [];
  List<BloodBank> filteredBloodBanks = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  late Future<List<BloodBank>> _bloodBankFuture;

  @override
  void initState() {
    super.initState();
    _loadBloodBanks();
    _searchController.addListener(_filterBloodBanks);
    _bloodBankFuture = _fetchBloodBanks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<BloodBank>> _fetchBloodBanks() async {
    const url = "https://urcs-api.taufeeq.dev/api/blood-donation/blood-banks";

    try {
      final response = await http.get(Uri.parse(url));

      final jsonBody = jsonDecode(response.body);
      if (response.statusCode == 200 && jsonBody["success"] == true) {
        final List data = jsonBody["data"];
        return data.map((e) => BloodBank.fromJson(e)).toList();
      } else {
        throw Exception(jsonBody["message"] ?? "Failed to load blood banks");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  void _loadBloodBanks() {
    // Simulating API call - replace this with your actual API call
    final sampleData = {
      "success": true,
      "message": "Blood banks retrieved successfully",
      "data": [
        {
          "id": 6,
          "name": "Arua Regional Blood Bank",
          "district": "Arua",
          "address": "Arua Regional Referral Hospital",
          "phone": "+256-476-420607",
          "affiliated_hospital": "Arua Regional Referral Hospital",
          "latitude": "3.01944400",
          "longitude": "30.91250000"
        },
        {
          "id": 5,
          "name": "Fort Portal Regional Blood Bank",
          "district": "Kabarole",
          "address": "Fort Portal Regional Referral Hospital",
          "phone": "+256-483-422250",
          "affiliated_hospital": "Fort Portal Regional Referral Hospital",
          "latitude": "0.65527800",
          "longitude": "30.28138900"
        },
        {
          "id": 2,
          "name": "Gulu Regional Blood Bank",
          "district": "Gulu",
          "address": "Gulu Regional Referral Hospital",
          "phone": "+256-471-432059",
          "affiliated_hospital": "Gulu Regional Referral Hospital",
          "latitude": "2.77777800",
          "longitude": "32.29777800"
        },
        {
          "id": 7,
          "name": "Lira Blood Collection Centre",
          "district": "Lira",
          "address": "Lira Regional Referral Hospital",
          "phone": "+256-473-420141",
          "affiliated_hospital": "Lira Regional Referral Hospital",
          "latitude": "2.25166700",
          "longitude": "32.90194400"
        },
        {
          "id": 4,
          "name": "Mbale Regional Blood Bank",
          "district": "Mbale",
          "address": "Mbale Regional Referral Hospital",
          "phone": "+256-454-433572",
          "affiliated_hospital": "Mbale Regional Referral Hospital",
          "latitude": "1.07666700",
          "longitude": "34.17638900"
        },
        {
          "id": 3,
          "name": "Mbarara Regional Blood Bank",
          "district": "Mbarara",
          "address": "Mbarara Regional Referral Hospital",
          "phone": "+256-485-421317",
          "affiliated_hospital": "Mbarara Regional Referral Hospital",
          "latitude": "-0.61638900",
          "longitude": "30.65888900"
        },
        {
          "id": 1,
          "name": "Nakaseero Blood Bank",
          "district": "Kampala",
          "address": "Uganda Blood Transfusion Service, Nakasero",
          "phone": "+256-414-346576",
          "email": "info@ubts.go.ug",
          "affiliated_hospital": "Uganda Blood Transfusion Service",
          "latitude": "0.31750000",
          "longitude": "32.58580000"
        },
        {
          "id": 8,
          "name": "Soroti Regional Blood Bank",
          "district": "Soroti",
          "address": "Soroti Regional Referral Hospital",
          "phone": "+256-454-461122",
          "affiliated_hospital": "Soroti Regional Referral Hospital",
          "latitude": "1.71611100",
          "longitude": "33.61305600"
        }
      ]
    };

    setState(() {
      bloodBanks = (sampleData['data'] as List)
          .map((json) => BloodBank.fromJson(json))
          .toList();
      filteredBloodBanks = bloodBanks;
      isLoading = false;
    });
  }

  void _filterBloodBanks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredBloodBanks = bloodBanks;
      } else {
        filteredBloodBanks = bloodBanks.where((bank) {
          return bank.name.toLowerCase().contains(query) ||
              bank.district.toLowerCase().contains(query) ||
              bank.address.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _showBloodBankDetails(BloodBank bank) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBloodBankDetails(bank),
    );
  }

  void _showBookAppointmentForm(BloodBank bank) {
    Navigator.pop(context); // Close the details sheet
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookAppointment(bloodBank: bank),
      ),
    );
  }

  Widget _buildBloodBankDetails(BloodBank bank) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            bank.name,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          _buildDetailRow(
              Icons.location_city, 'District', bank.district, screenWidth),
          SizedBox(height: screenHeight * 0.015),
          _buildDetailRow(
              Icons.location_on, 'Address', bank.address, screenWidth),
          SizedBox(height: screenHeight * 0.015),
          _buildDetailRow(Icons.phone, 'Phone', bank.phone, screenWidth),
          if (bank.email != null) ...[
            SizedBox(height: screenHeight * 0.015),
            _buildDetailRow(Icons.email, 'Email', bank.email!, screenWidth),
          ],
          SizedBox(height: screenHeight * 0.015),
          _buildDetailRow(Icons.local_hospital, 'Hospital',
              bank.affiliatedHospital, screenWidth),
          const Spacer(),

          // Action Buttons
          GestureDetector(
            onTap: () => _showBookAppointmentForm(bank),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Book Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Open phone dialer
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Call',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Open map with coordinates
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Directions',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.red, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _bloodBankFuture = _fetchBloodBanks();
    });
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Blood Banks',
                style: TextStyle(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                '${bloodBanks.length} blood banks across Uganda',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: screenHeight * 0.025),

              // View Appointments Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Appointments()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.018,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.event_note,
                          color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'View My Appointments',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name, district, or address',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.018,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),

              // Blood Banks List
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : filteredBloodBanks.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: screenWidth * 0.2,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'No blood banks found',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : FutureBuilder<List<BloodBank>>(
                            future: _bloodBankFuture,
                            builder: (context, snapshot) {
                              // LOADING
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.red));
                              }

                              // ERROR
                              if (snapshot.hasError) {
                                return Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.error,
                                          color: Colors.red, size: 40),
                                      const SizedBox(height: 10),
                                      Text(snapshot.error.toString()),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: _refresh,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        child: const Text("Retry"),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              final banks = snapshot.data ?? [];

                              // EMPTY STATE
                              if (banks.isEmpty) {
                                return const Center(
                                    child: Text("No blood banks available."));
                              }

                              return RefreshIndicator(
                                color: Colors.red,
                                onRefresh: _refresh,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(12),
                                  itemCount: banks.length,
                                  itemBuilder: (context, index) {
                                    final bank = banks[index];

                                    // final bank = filteredBloodBanks[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.015,
                                      ),
                                      child: _buildBloodBankCard(
                                          bank, screenWidth, screenHeight),
                                    );
                                  },
                                ),
                              );
                            },
                          ),

                // ListView.builder(
                //     itemCount: filteredBloodBanks.length,
                //     itemBuilder: (context, index) {
                //       final bank = filteredBloodBanks[index];
                //       return Padding(
                //         padding: EdgeInsets.only(
                //           bottom: screenHeight * 0.015,
                //         ),
                //         child: _buildBloodBankCard(
                //             bank, screenWidth, screenHeight),
                //       );
                //     },
                //   ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBloodBankCard(
      BloodBank bank, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () => _showBloodBankDetails(bank),
      child: Container(
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
                    bank.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: screenWidth * 0.04,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          bank.district,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.003),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: screenWidth * 0.04,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        bank.phone,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: screenWidth * 0.06,
            ),
          ],
        ),
      ),
    );
  }
}
