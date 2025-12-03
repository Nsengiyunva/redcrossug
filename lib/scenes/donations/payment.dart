// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/controllers/disasters_list_controller.dart';
// import 'package:redcross/scenes/widgets/payment_list_item.dart';
// import 'package:redcross/scenes/widgets/payment_summary_item.dart';
// import 'package:redcross/scenes/widgets/red_btn.dart';
// import 'package:redcross/scenes/widgets/text_box_area.dart';
// import 'package:redcross/utils/colors.dart';

// class Payment extends StatelessWidget {
//   Payment({super.key});

//   final DisastersListController disasterController =
//       Get.put(DisastersListController());

//   @override
//   Widget build(BuildContext context) {
//     var data = Get.arguments;

//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       appBar: AppBar(
//           title: const Text(""),
//           leading: const BackButton() // Back button added here
//           ),
//       body: Obx(() {
//         if (disasterController.isDonating.value) {
//           return const Center(
//             child: Column(
//               children: [CircularProgressIndicator(), Text("Processing...")],
//             ),
//           );
//         }

//         return SingleChildScrollView(
//           child: Container(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Center(
//                     child: Text(
//                       "Payment",
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: "Inter",
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.blackColorG),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text("Select Payment Method",
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontFamily: "Inter",
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.blackColorG)),
//                   const SizedBox(height: 10),
//                   // PaymentListItem(
//                   //   outline: true,
//                   //   text_label: 'Credit Card',
//                   //   icon_name: 'credit_card_rounded',
//                   // ),
//                   PaymentListItem(
//                     outline: true,
//                     text_label: 'Mobile Money',
//                     icon_name: 'phone_iphone_rounded',
//                   ),
//                   const SizedBox(height: 15),
//                   const PaymentSummaryItem(
//                       text_label: "Service Fee", price_label: "UGX 0"),
//                   const SizedBox(height: 10),
//                   const PaymentSummaryItem(
//                       text_label: "Donation Amount",
//                       price_label: "UGX 250,000"),
//                   const SizedBox(height: 25),
//                   const PaymentSummaryItem(
//                       text_label: "Total", price_label: "UGX 250,000"),
//                   const SizedBox(height: 30),
//                   const Text("Messages and Support",
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontFamily: "Inter",
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.blackColorG)),
//                   const SizedBox(height: 5),
//                   const TextBoxArea(),
//                   const SizedBox(height: 5),
//                   const Row(
//                     children: [
//                       Icon(Icons.check_box_outline_blank,
//                           color: AppColors.greyColorG, size: 20.0),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         child: Text("Hide your name",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontFamily: "Inter",
//                                 fontSize: 12,
//                                 color: AppColors.greyColorG)),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   RedBtn(
//                     squared: true,
//                     label: "Confirm Donation",
//                     onPressed: () {
//                       // Get.toNamed("/payment-successful");
//                       disasterController
//                           .makePayment(data['disasterId'].toString());
//                     },
//                   )
//                 ],
//               )),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  @override
  _DonationPaymentScreenState createState() => _DonationPaymentScreenState();
}

class _DonationPaymentScreenState extends State<Payment> {
  String selectedPaymentMethod = 'credit_card';
  bool hideYourName = false;
  final TextEditingController messageController = TextEditingController();

  final double serviceFee = 300;
  final double donationAmount = 450000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          ),
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
                ),
              ),
              SizedBox(height: 16),
              _buildPaymentMethodCard(
                icon: Icons.credit_card,
                title: 'Credit Card',
                value: 'credit_card',
              ),
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
              _buildSummaryRow('Service fee', serviceFee),
              SizedBox(height: 12),
              _buildSummaryRow('Donation amounts', donationAmount),
              SizedBox(height: 16),
              Divider(color: Colors.grey[300], thickness: 1),
              SizedBox(height: 16),
              _buildSummaryRow(
                'Total',
                serviceFee + donationAmount,
                isTotal: true,
              ),
              SizedBox(height: 32),
              Text(
                'Messages and support',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
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
                    ),
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    _confirmDonation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF0000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Confirm Donation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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
            color: isSelected ? Color(0xFFFF0000) : Colors.grey[200]!,
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
                color: Color(0xFFFF0000),
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
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Color(0xFFFF0000) : Colors.grey[400]!,
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
                          color: Color(0xFFFF0000),
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

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? Colors.black87 : Colors.grey[600],
          ),
        ),
        Text(
          'UGX ${amount.toStringAsFixed(0).replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},',
              )}',
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _confirmDonation() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFFFFE5E5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Color(0xFFFF0000),
                size: 40,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Donation Confirmed!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Thank you for your generous donation of UGX ${(serviceFee + donationAmount).toStringAsFixed(0)}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF0000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
