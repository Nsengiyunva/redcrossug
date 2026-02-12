import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/models/user.dart';
import 'package:redcross/scenes/default_home.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class Payment extends StatefulWidget {
  final int amount;
  final int disasterId;

  const Payment({super.key, required this.amount, required this.disasterId});

  @override
  _DonationPaymentScreenState createState() => _DonationPaymentScreenState();
}

class _DonationPaymentScreenState extends State<Payment> {
  String selectedPaymentMethod = 'mobile_money';
  bool hideYourName = false;
  final TextEditingController messageController = TextEditingController();

  final double serviceFee = 0;
  final double donationAmount = 450000;

  String? phoneNumber;
  String? mobileProvider;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final User? user = await StorageService.getUser();
    if (user == null) return;

    final String phone = user.phone_no; // use property, not []

    if (phone.isNotEmpty) {
      String provider = getMobileProvider(phone);

      setState(() {
        phoneNumber = phone;
        mobileProvider = provider;
        isSubmitting = true;
      });
    }
  }

  String getMobileProvider(String phone) {
    // Normalize phone number: remove spaces and +256 prefix if present
    String normalized = phone.replaceAll(' ', '');
    if (normalized.startsWith('+256')) {
      normalized = '0${normalized.substring(4)}';
    }

    if (normalized.startsWith('077') ||
        normalized.startsWith('074') ||
        normalized.startsWith('078') ||
        normalized.startsWith('076')) {
      return 'MTN';
    } else if (normalized.startsWith('075') || normalized.startsWith('070')) {
      return 'Airtel';
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "Inter"),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select payment method',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: "Inter"),
              ),
              SizedBox(height: 16),
              // _buildPaymentMethodCard(
              //   icon: Icons.credit_card,
              //   title: 'Credit Card',
              //   value: 'credit_card',
              // ),
              SizedBox(height: 12),
              _buildPaymentMethodCard(
                icon: Icons.phone_android,
                title: 'Mobile Money',
                value: 'mobile_money',
              ),
              SizedBox(height: 32),
              Text(
                'Payment summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              _buildSummaryRow(
                  false, "$phoneNumber", 'Mobile Number', serviceFee),
              SizedBox(height: 12),
              _buildSummaryRow(
                  false, "$mobileProvider", 'Mobile Provider', serviceFee),
              SizedBox(height: 12),
              _buildSummaryRow(true, "", 'Service fee', serviceFee),
              SizedBox(height: 12),
              _buildSummaryRow(
                  true, "", 'Donation amounts', widget.amount.toDouble()),
              SizedBox(height: 16),
              Divider(color: Colors.grey[300], thickness: 1),
              SizedBox(height: 16),
              _buildSummaryRow(
                true,
                "",
                'Total',
                serviceFee + widget.amount.toDouble(),
                isTotal: true,
              ),
              SizedBox(height: 32),
              Text(
                'Messages and support',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: "Inter"),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write your messages...',
                    hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontFamily: "Inter"),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: hideYourName,
                      onChanged: (value) {
                        setState(() {
                          hideYourName = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(color: Colors.grey[400]!),
                      activeColor: Color(0xFFFF0000),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Hide your name',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontFamily: "Inter"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.whiteColor,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _confirmDonation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryRedColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Confirm Payment Donation',
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter"),
                        ),
                      ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    bool isSelected = selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFFE5E5) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryRedColor : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFFFE5E5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryRedColor,
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: "Inter"),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryRedColor
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryRedColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
      bool isCurrency, String? value, String label, double amount,
      {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontFamily: "Inter",
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? Colors.black87 : Colors.grey[600],
          ),
        ),
        isCurrency
            ? Text(
                'UGX ${amount.toStringAsFixed(0).replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    )}',
                style: TextStyle(
                  fontSize: isTotal ? 16 : 14,
                  fontFamily: "Inter",
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
                  color: Colors.black87,
                ),
              )
            : Text("$value"),
      ],
    );
  }

  String normalizePhone(String phone) {
    String cleaned = phone.replaceAll(' ', '');

    if (cleaned.startsWith('+')) {
      cleaned = cleaned.substring(1); // remove +
    }

    return cleaned;
  }

  Future<void> _confirmDonation() async {
    if (phoneNumber == null || mobileProvider == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Phone number or Network Provider is missing.")),
      );
      return;
    }

    final payload = {
      "amount": widget.amount.toInt(),
      "phone_no": normalizePhone('$phoneNumber'), // force string
      "mobile_network": "$mobileProvider", // force string
    };

    int donate_id = widget.disasterId;
    final token = await StorageService.getToken();

    try {
      final response = await http.post(
        Uri.parse(
            'https://urcs-api.taufeeq.dev/api/disasters/$donate_id/donate'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-Requested-With': 'XMLHttpRequest'
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // Show the response message in a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? "Donation successful"),
            backgroundColor: Colors.green[800],
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DefaultHome(),
          ),
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? "Donation failed"),
            backgroundColor: AppColors.primaryRedColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      // print("error - $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          backgroundColor: AppColors.blackColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
