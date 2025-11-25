// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/utils/colors.dart';
// import 'package:redcross/utils/storage_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// // Controller
// class MembershipController extends GetxController {
//   var isLoading = false.obs;
//   var isEditing = false.obs;
//   var profile = Rxn<MemberProfile>();
//   var activeMembership = Rxn<ActiveMembership>();

//   // Editable fields
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final alternativePhoneController = TextEditingController();
//   final districtController = TextEditingController();
//   final subcountyController = TextEditingController();
//   final parishController = TextEditingController();
//   final villageController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchMemberProfile();
//   }

//   Future<void> fetchMemberProfile() async {
//     final token = await StorageService.getToken();

//     try {
//       isLoading.value = true;

//       final response = await http.get(
//         Uri.parse('https://urcs-api.taufeeq.dev/api/vms/membership/profile'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         profile.value = MemberProfile.fromJson(data['profile']);

//         if (data['active_membership'] != null) {
//           activeMembership.value =
//               ActiveMembership.fromJson(data['active_membership']);
//         }

//         // Initialize controllers
//         emailController.text = profile.value?.email ?? '';
//         phoneController.text = profile.value?.phone ?? '';
//         alternativePhoneController.text = profile.value?.alternativePhone ?? '';
//         districtController.text = profile.value?.district ?? '';
//         subcountyController.text = profile.value?.memberSubcounty ?? '';
//         parishController.text = profile.value?.memberParish ?? '';
//         villageController.text = profile.value?.memberVillage ?? '';
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load profile: $e',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> updateProfile() async {
//     try {
//       isLoading.value = true;
//       final token = await StorageService.getToken();

//       final response = await http.patch(
//         Uri.parse('https://urcs-api.taufeeq.dev/api/vms/membership/profile'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'email': emailController.text,
//           'phone': phoneController.text,
//           'alternative_phone': alternativePhoneController.text,
//           'district': districtController.text,
//           'member_subcounty': subcountyController.text,
//           'member_parish': parishController.text,
//           'member_village': villageController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         Get.snackbar('Success', 'Profile updated successfully',
//             backgroundColor: Colors.green, colorText: Colors.white);
//         isEditing.value = false;
//         await fetchMemberProfile();
//       } else {
//         Get.snackbar('Error', 'Failed to update profile',
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update profile: $e',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     phoneController.dispose();
//     alternativePhoneController.dispose();
//     districtController.dispose();
//     subcountyController.dispose();
//     parishController.dispose();
//     villageController.dispose();
//     super.onClose();
//   }
// }

// // Models
// class MemberProfile {
//   final String membershipId;
//   final String name;
//   final String firstname;
//   final String surname;
//   final String othername;
//   final String email;
//   final String phone;
//   final String alternativePhone;
//   final String gender;
//   final String dob;
//   final String nin;
//   final String district;
//   final String memberSubcounty;
//   final String memberParish;
//   final String memberVillage;
//   final Branch branch;
//   final bool isMember;
//   final bool membershipActive;
//   final bool accountVerified;

//   MemberProfile({
//     required this.membershipId,
//     required this.name,
//     required this.firstname,
//     required this.surname,
//     required this.othername,
//     required this.email,
//     required this.phone,
//     required this.alternativePhone,
//     required this.gender,
//     required this.dob,
//     required this.nin,
//     required this.district,
//     required this.memberSubcounty,
//     required this.memberParish,
//     required this.memberVillage,
//     required this.branch,
//     required this.isMember,
//     required this.membershipActive,
//     required this.accountVerified,
//   });

//   factory MemberProfile.fromJson(Map<String, dynamic> json) {
//     return MemberProfile(
//       membershipId: json['membership_id'] ?? '',
//       name: json['name'] ?? '',
//       firstname: json['firstname'] ?? '',
//       surname: json['surname'] ?? '',
//       othername: json['othername'] ?? '',
//       email: json['email'] ?? '',
//       phone: json['phone'] ?? '',
//       alternativePhone: json['alternative_phone'] ?? '',
//       gender: json['gender'] ?? '',
//       dob: json['dob'] ?? '',
//       nin: json['nin'] ?? '',
//       district: json['district'] ?? '',
//       memberSubcounty: json['member_subcounty'] ?? '',
//       memberParish: json['member_parish'] ?? '',
//       memberVillage: json['member_village'] ?? '',
//       branch: Branch.fromJson(json['branch'] ?? {}),
//       isMember: json['is_member'] ?? false,
//       membershipActive: json['membership_active'] ?? false,
//       accountVerified: json['account_verified'] ?? false,
//     );
//   }
// }

// class Branch {
//   final int id;
//   final String name;

//   Branch({required this.id, required this.name});

//   factory Branch.fromJson(Map<String, dynamic> json) {
//     return Branch(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//     );
//   }
// }

// class ActiveMembership {
//   final String category;
//   final String tier;
//   final String startDate;
//   final String endDate;
//   final bool active;
//   final String status;
//   final String paymentStatus;
//   final bool isExpired;

//   ActiveMembership({
//     required this.category,
//     required this.tier,
//     required this.startDate,
//     required this.endDate,
//     required this.active,
//     required this.status,
//     required this.paymentStatus,
//     required this.isExpired,
//   });

//   factory ActiveMembership.fromJson(Map<String, dynamic> json) {
//     return ActiveMembership(
//       category: json['category'] ?? '',
//       tier: json['tier'] ?? '',
//       startDate: json['start_date'] ?? '',
//       endDate: json['end_date'] ?? '',
//       active: json['active'] ?? false,
//       status: json['status'] ?? '',
//       paymentStatus: json['payment_status'] ?? '',
//       isExpired: json['is_expired'] ?? false,
//     );
//   }
// }

// // Main Screen
// class MembershipCard extends StatelessWidget {
//   final MembershipController controller = Get.put(MembershipController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       appBar: AppBar(
//         title: Text('Membership Card'),
//         elevation: 0,
//         actions: [
//           Obx(() => IconButton(
//                 icon:
//                     Icon(controller.isEditing.value ? Icons.close : Icons.edit),
//                 onPressed: () {
//                   controller.isEditing.value = !controller.isEditing.value;
//                 },
//               )),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//               child:
//                   CircularProgressIndicator(color: AppColors.primaryRedColor));
//         }

//         if (controller.profile.value == null) {
//           return Center(child: Text('No membership data available'));
//         }

//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               // Red Cross Card Design
//               _buildMembershipCard(controller.profile.value!),

//               SizedBox(height: 20),

//               // Profile Details
//               _buildProfileDetails(context),

//               SizedBox(height: 20),

//               // Membership Status
//               if (controller.activeMembership.value != null)
//                 _buildMembershipStatus(controller.activeMembership.value!),

//               SizedBox(height: 20),

//               // Update Button (only in edit mode)
//               Obx(() => controller.isEditing.value
//                   ? Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: controller.updateProfile,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFFE31E24),
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text('Update Profile',
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.white)),
//                         ),
//                       ),
//                     )
//                   : SizedBox()),

//               SizedBox(height: 30),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildMembershipCard(MemberProfile profile) {
//     return Container(
//       margin: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFFE31E24), Color(0xFFB01519)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 15,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Stack(
//           children: [
//             // Background pattern
//             Positioned(
//               right: -30,
//               top: -30,
//               child: Icon(Icons.local_hospital,
//                   size: 200, color: Colors.white.withOpacity(0.1)),
//             ),

//             Padding(
//               padding: EdgeInsets.all(25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'UGANDA RED CROSS',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                           Text(
//                             'SOCIETY',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child:
//                             Icon(Icons.add, color: Color(0xFFE31E24), size: 40),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundColor: Colors.white,
//                         child: Text(
//                           profile.firstname[0].toUpperCase(),
//                           style: TextStyle(
//                               fontSize: 32,
//                               color: Color(0xFFE31E24),
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               profile.name.toUpperCase(),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               profile.membershipId,
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.9),
//                                 fontSize: 14,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 25),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: profile.membershipActive
//                           ? Colors.green
//                           : Colors.orange,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       profile.membershipActive ? 'ACTIVE MEMBER' : 'INACTIVE',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileDetails(BuildContext context) {
//     final profile = controller.profile.value!;

//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Personal Information',
//             style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFE31E24)),
//           ),
//           SizedBox(height: 20),
//           _buildInfoRow('Full Name', profile.name, false),
//           _buildInfoRow('Gender', profile.gender, false),
//           _buildInfoRow('Date of Birth', profile.dob, false),
//           _buildInfoRow('NIN', profile.nin, false),
//           Divider(height: 30),
//           Text(
//             'Contact Information',
//             style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFE31E24)),
//           ),
//           SizedBox(height: 20),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Email', controller.emailController)
//               : _buildInfoRow('Email', profile.email, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Phone', controller.phoneController)
//               : _buildInfoRow('Phone', profile.phone, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField(
//                   'Alternative Phone', controller.alternativePhoneController)
//               : _buildInfoRow(
//                   'Alternative Phone', profile.alternativePhone, false)),
//           Divider(height: 30),
//           Text(
//             'Address Information',
//             style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFE31E24)),
//           ),
//           SizedBox(height: 20),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('District', controller.districtController)
//               : _buildInfoRow('District', profile.district, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Subcounty', controller.subcountyController)
//               : _buildInfoRow('Subcounty', profile.memberSubcounty, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Parish', controller.parishController)
//               : _buildInfoRow('Parish', profile.memberParish, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Village', controller.villageController)
//               : _buildInfoRow('Village', profile.memberVillage, false)),
//           _buildInfoRow('Branch', profile.branch.name, false),
//         ],
//       ),
//     );
//   }

//   Widget _buildMembershipStatus(ActiveMembership membership) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Membership Status',
//             style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFE31E24)),
//           ),
//           SizedBox(height: 20),
//           _buildInfoRow('Category', membership.category, false),
//           _buildInfoRow('Tier', membership.tier, false),
//           _buildInfoRow('Start Date', membership.startDate, false),
//           _buildInfoRow('End Date', membership.endDate, false),
//           _buildInfoRow('Payment Status', membership.paymentStatus, false),
//           SizedBox(height: 15),
//           Row(
//             children: [
//               _buildStatusChip(
//                 membership.isExpired ? 'EXPIRED' : 'VALID',
//                 membership.isExpired ? Colors.red : Colors.green,
//               ),
//               SizedBox(width: 10),
//               _buildStatusChip(
//                 membership.active ? 'ACTIVE' : 'INACTIVE',
//                 membership.active ? Colors.blue : Colors.grey,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value, bool isEditable) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 140,
//             child: Text(
//               label,
//               style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value.isEmpty ? 'N/A' : value,
//               style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black87,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEditableField(String label, TextEditingController controller) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500),
//           ),
//           SizedBox(height: 5),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               isDense: true,
//               contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Color(0xFFE31E24)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusChip(String text, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Controller
class MembershipController extends GetxController {
  var isLoading = false.obs;
  var isEditing = false.obs;
  var profile = Rxn<MemberProfile>();
  var activeMembership = Rxn<ActiveMembership>();
  var isCardFixed = false.obs;

  // Editable fields
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final alternativePhoneController = TextEditingController();
  final districtController = TextEditingController();
  final subcountyController = TextEditingController();
  final parishController = TextEditingController();
  final villageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchMemberProfile();
  }

  Future<void> fetchMemberProfile() async {
    final token = await StorageService.getToken();

    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse('https://urcs-api.taufeeq.dev/api/vms/membership/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        profile.value = MemberProfile.fromJson(data['profile']);

        if (data['active_membership'] != null) {
          activeMembership.value =
              ActiveMembership.fromJson(data['active_membership']);
        }

        // Initialize controllers
        emailController.text = profile.value?.email ?? '';
        phoneController.text = profile.value?.phone ?? '';
        alternativePhoneController.text = profile.value?.alternativePhone ?? '';
        districtController.text = profile.value?.district ?? '';
        subcountyController.text = profile.value?.memberSubcounty ?? '';
        parishController.text = profile.value?.memberParish ?? '';
        villageController.text = profile.value?.memberVillage ?? '';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      final token = await StorageService.getToken();

      final response = await http.patch(
        Uri.parse('https://urcs-api.taufeeq.dev/api/vms/membership/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': emailController.text,
          'phone': phoneController.text,
          'alternative_phone': alternativePhoneController.text,
          'district': districtController.text,
          'member_subcounty': subcountyController.text,
          'member_parish': parishController.text,
          'member_village': villageController.text,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile updated successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
        isEditing.value = false;
        await fetchMemberProfile();
      } else {
        Get.snackbar('Error', 'Failed to update profile',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    alternativePhoneController.dispose();
    districtController.dispose();
    subcountyController.dispose();
    parishController.dispose();
    villageController.dispose();
    super.onClose();
  }
}

// Models
class MemberProfile {
  final String membershipId;
  final String name;
  final String firstname;
  final String surname;
  final String othername;
  final String email;
  final String phone;
  final String alternativePhone;
  final String gender;
  final String dob;
  final String nin;
  final String district;
  final String memberSubcounty;
  final String memberParish;
  final String memberVillage;
  final Branch branch;
  final bool isMember;
  final bool membershipActive;
  final bool accountVerified;

  MemberProfile({
    required this.membershipId,
    required this.name,
    required this.firstname,
    required this.surname,
    required this.othername,
    required this.email,
    required this.phone,
    required this.alternativePhone,
    required this.gender,
    required this.dob,
    required this.nin,
    required this.district,
    required this.memberSubcounty,
    required this.memberParish,
    required this.memberVillage,
    required this.branch,
    required this.isMember,
    required this.membershipActive,
    required this.accountVerified,
  });

  factory MemberProfile.fromJson(Map<String, dynamic> json) {
    return MemberProfile(
      membershipId: json['membership_id'] ?? '',
      name: json['name'] ?? '',
      firstname: json['firstname'] ?? '',
      surname: json['surname'] ?? '',
      othername: json['othername'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      alternativePhone: json['alternative_phone'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      nin: json['nin'] ?? '',
      district: json['district'] ?? '',
      memberSubcounty: json['member_subcounty'] ?? '',
      memberParish: json['member_parish'] ?? '',
      memberVillage: json['member_village'] ?? '',
      branch: Branch.fromJson(json['branch'] ?? {}),
      isMember: json['is_member'] ?? false,
      membershipActive: json['membership_active'] ?? false,
      accountVerified: json['account_verified'] ?? false,
    );
  }
}

class Branch {
  final int id;
  final String name;

  Branch({required this.id, required this.name});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class ActiveMembership {
  final String category;
  final String tier;
  final String startDate;
  final String endDate;
  final bool active;
  final String status;
  final String paymentStatus;
  final bool isExpired;

  ActiveMembership({
    required this.category,
    required this.tier,
    required this.startDate,
    required this.endDate,
    required this.active,
    required this.status,
    required this.paymentStatus,
    required this.isExpired,
  });

  factory ActiveMembership.fromJson(Map<String, dynamic> json) {
    return ActiveMembership(
      category: json['category'] ?? '',
      tier: json['tier'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      active: json['active'] ?? false,
      status: json['status'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      isExpired: json['is_expired'] ?? false,
    );
  }
}

// Main Screen
class MembershipCard extends StatefulWidget {
  @override
  _MembershipCardState createState() => _MembershipCardState();
}

class _MembershipCardState extends State<MembershipCard> {
  final MembershipController controller = Get.put(MembershipController());
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _cardKey = GlobalKey();
  double _cardHeight = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCardHeight();
    });
  }

  void _updateCardHeight() {
    final RenderBox? renderBox =
        _cardKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _cardHeight = renderBox.size.height;
      });
    }
  }

  void _onScroll() {
    final RenderBox? renderBox =
        _cardKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      controller.isCardFixed.value = position.dy <= 0;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child:
                  CircularProgressIndicator(color: AppColors.primaryRedColor));
        }

        if (controller.profile.value == null) {
          return Center(child: Text('No membership data available'));
        }

        return Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  title: Text('Membership Card'),
                  elevation: 0,
                  pinned: false,
                  floating: false,
                  actions: [
                    Obx(() => IconButton(
                          icon: Icon(controller.isEditing.value
                              ? Icons.close
                              : Icons.edit),
                          onPressed: () {
                            controller.isEditing.value =
                                !controller.isEditing.value;
                          },
                        )),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Red Cross Card Design with Key
                      Container(
                        key: _cardKey,
                        child: _buildMembershipCard(controller.profile.value!),
                      ),

                      SizedBox(height: 20),

                      // Profile Details
                      _buildProfileDetails(context),

                      SizedBox(height: 20),

                      // Membership Status
                      if (controller.activeMembership.value != null)
                        _buildMembershipStatus(
                            controller.activeMembership.value!),

                      SizedBox(height: 20),

                      // Update Button (only in edit mode)
                      Obx(() => controller.isEditing.value
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: controller.updateProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFE31E24),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text('Update Profile',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ),
                              ),
                            )
                          : SizedBox()),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),

            // Fixed Card Overlay
            Obx(() => controller.isCardFixed.value
                ? Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Material(
                      elevation: 8,
                      child: Container(
                        color: AppColors.bgColor,
                        child: Column(
                          children: [
                            AppBar(
                              title: Text('Membership Card'),
                              elevation: 0,
                              actions: [
                                IconButton(
                                  icon: Icon(controller.isEditing.value
                                      ? Icons.close
                                      : Icons.edit),
                                  onPressed: () {
                                    controller.isEditing.value =
                                        !controller.isEditing.value;
                                  },
                                ),
                              ],
                            ),
                            _buildMembershipCard(controller.profile.value!),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox()),
          ],
        );
      }),
    );
  }

  Widget _buildMembershipCard(MemberProfile profile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive sizing
        final screenWidth = MediaQuery.of(context).size.width;
        final cardMargin = screenWidth > 600 ? 40.0 : 20.0;
        final cardPadding = screenWidth > 600 ? 30.0 : 20.0;
        final titleFontSize = screenWidth > 600 ? 18.0 : 14.0;
        final nameFontSize = screenWidth > 600 ? 20.0 : 16.0;
        final avatarRadius = screenWidth > 600 ? 50.0 : 40.0;
        final iconSize = screenWidth > 600 ? 50.0 : 40.0;

        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: cardMargin,
              vertical: controller.isCardFixed.value ? 10 : 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE31E24), Color(0xFFB01519)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Background pattern
                Positioned(
                  right: -30,
                  top: -30,
                  child: Icon(Icons.local_hospital,
                      size: screenWidth > 600 ? 250 : 200,
                      color: Colors.white.withOpacity(0.1)),
                ),

                Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'UGANDA RED CROSS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  'SOCIETY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.add,
                                color: Color(0xFFE31E24), size: iconSize),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth > 600 ? 35 : 25),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: avatarRadius,
                            backgroundColor: Colors.white,
                            child: Text(
                              profile.firstname.isNotEmpty
                                  ? profile.firstname[0].toUpperCase()
                                  : 'U',
                              style: TextStyle(
                                  fontSize: avatarRadius * 0.8,
                                  color: Color(0xFFE31E24),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: screenWidth > 600 ? 25 : 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.name.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: nameFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  profile.membershipId,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: screenWidth > 600 ? 14.0 : 12.0,
                                    letterSpacing: 1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: profile.membershipActive
                              ? Colors.green
                              : Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          profile.membershipActive
                              ? 'ACTIVE MEMBER'
                              : 'INACTIVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth > 600 ? 13.0 : 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    final profile = controller.profile.value!;
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalMargin = screenWidth > 600 ? 40.0 : 20.0;
    final containerPadding = screenWidth > 600 ? 25.0 : 20.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
                fontSize: screenWidth > 600 ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE31E24)),
          ),
          SizedBox(height: 20),
          _buildInfoRow('Full Name', profile.name, false),
          _buildInfoRow('Gender', profile.gender, false),
          _buildInfoRow('Date of Birth', profile.dob, false),
          _buildInfoRow('NIN', profile.nin, false),
          Divider(height: 30),
          Text(
            'Contact Information',
            style: TextStyle(
                fontSize: screenWidth > 600 ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE31E24)),
          ),
          SizedBox(height: 20),
          Obx(() => controller.isEditing.value
              ? _buildEditableField('Email', controller.emailController)
              : _buildInfoRow('Email', profile.email, false)),
          Obx(() => controller.isEditing.value
              ? _buildEditableField('Phone', controller.phoneController)
              : _buildInfoRow('Phone', profile.phone, false)),
          Obx(() => controller.isEditing.value
              ? _buildEditableField(
                  'Alternative Phone', controller.alternativePhoneController)
              : _buildInfoRow(
                  'Alternative Phone', profile.alternativePhone, false)),
          Divider(height: 30),
          Text(
            'Address Information',
            style: TextStyle(
                fontSize: screenWidth > 600 ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE31E24)),
          ),
          SizedBox(height: 20),
          Obx(() => controller.isEditing.value
              ? _buildEditableField('District', controller.districtController)
              : _buildInfoRow('District', profile.district, false)),
          Obx(() => controller.isEditing.value
              ? _buildEditableField('Subcounty', controller.subcountyController)
              : _buildInfoRow('Subcounty', profile.memberSubcounty, false)),
          Obx(() => controller.isEditing.value
              ? _buildEditableField('Parish', controller.parishController)
              : _buildInfoRow('Parish', profile.memberParish, false)),
          Obx(() => controller.isEditing.value
              ? _buildEditableField('Village', controller.villageController)
              : _buildInfoRow('Village', profile.memberVillage, false)),
          _buildInfoRow('Branch', profile.branch.name, false),
        ],
      ),
    );
  }

  Widget _buildMembershipStatus(ActiveMembership membership) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalMargin = screenWidth > 600 ? 40.0 : 20.0;
    final containerPadding = screenWidth > 600 ? 25.0 : 20.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Membership Status',
            style: TextStyle(
                fontSize: screenWidth > 600 ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE31E24)),
          ),
          SizedBox(height: 20),
          _buildInfoRow('Category', membership.category, false),
          _buildInfoRow('Tier', membership.tier, false),
          _buildInfoRow('Start Date', membership.startDate, false),
          _buildInfoRow('End Date', membership.endDate, false),
          _buildInfoRow('Payment Status', membership.paymentStatus, false),
          SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildStatusChip(
                membership.isExpired ? 'EXPIRED' : 'VALID',
                membership.isExpired ? Colors.red : Colors.green,
              ),
              _buildStatusChip(
                membership.active ? 'ACTIVE' : 'INACTIVE',
                membership.active ? Colors.blue : Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isEditable) {
    final screenWidth = MediaQuery.of(context).size.width;
    final labelWidth = screenWidth > 600 ? 160.0 : 130.0;

    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: screenWidth > 400
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: labelWidth,
                  child: Text(
                    label,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    value.isEmpty ? 'N/A' : value,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  value.isEmpty ? 'N/A' : value,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFE31E24)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

///this is responsive and clean for membership card.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/utils/colors.dart';
// import 'package:redcross/utils/storage_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// // Controller
// class MembershipController extends GetxController {
//   var isLoading = false.obs;
//   var isEditing = false.obs;
//   var profile = Rxn<MemberProfile>();
//   var activeMembership = Rxn<ActiveMembership>();
//   var isCardFixed = false.obs;

//   // Editable fields
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final alternativePhoneController = TextEditingController();
//   final districtController = TextEditingController();
//   final subcountyController = TextEditingController();
//   final parishController = TextEditingController();
//   final villageController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchMemberProfile();
//   }

//   Future<void> fetchMemberProfile() async {
//     final token = await StorageService.getToken();

//     try {
//       isLoading.value = true;

//       final response = await http.get(
//         Uri.parse('https://urcs-api.taufeeq.dev/api/vms/membership/profile'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         profile.value = MemberProfile.fromJson(data['profile']);

//         if (data['active_membership'] != null) {
//           activeMembership.value =
//               ActiveMembership.fromJson(data['active_membership']);
//         }

//         // Initialize controllers
//         emailController.text = profile.value?.email ?? '';
//         phoneController.text = profile.value?.phone ?? '';
//         alternativePhoneController.text = profile.value?.alternativePhone ?? '';
//         districtController.text = profile.value?.district ?? '';
//         subcountyController.text = profile.value?.memberSubcounty ?? '';
//         parishController.text = profile.value?.memberParish ?? '';
//         villageController.text = profile.value?.memberVillage ?? '';
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load profile: $e',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> updateProfile() async {
//     try {
//       isLoading.value = true;
//       final token = await StorageService.getToken();

//       final response = await http.patch(
//         Uri.parse('https://urcs-api.taufeeq.dev/api/vms/membership/profile'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'email': emailController.text,
//           'phone': phoneController.text,
//           'alternative_phone': alternativePhoneController.text,
//           'district': districtController.text,
//           'member_subcounty': subcountyController.text,
//           'member_parish': parishController.text,
//           'member_village': villageController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         Get.snackbar('Success', 'Profile updated successfully',
//             backgroundColor: Colors.green, colorText: Colors.white);
//         isEditing.value = false;
//         await fetchMemberProfile();
//       } else {
//         Get.snackbar('Error', 'Failed to update profile',
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update profile: $e',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     phoneController.dispose();
//     alternativePhoneController.dispose();
//     districtController.dispose();
//     subcountyController.dispose();
//     parishController.dispose();
//     villageController.dispose();
//     super.onClose();
//   }
// }

// // Models
// class MemberProfile {
//   final String membershipId;
//   final String name;
//   final String firstname;
//   final String surname;
//   final String othername;
//   final String email;
//   final String phone;
//   final String alternativePhone;
//   final String gender;
//   final String dob;
//   final String nin;
//   final String district;
//   final String memberSubcounty;
//   final String memberParish;
//   final String memberVillage;
//   final Branch branch;
//   final bool isMember;
//   final bool membershipActive;
//   final bool accountVerified;

//   MemberProfile({
//     required this.membershipId,
//     required this.name,
//     required this.firstname,
//     required this.surname,
//     required this.othername,
//     required this.email,
//     required this.phone,
//     required this.alternativePhone,
//     required this.gender,
//     required this.dob,
//     required this.nin,
//     required this.district,
//     required this.memberSubcounty,
//     required this.memberParish,
//     required this.memberVillage,
//     required this.branch,
//     required this.isMember,
//     required this.membershipActive,
//     required this.accountVerified,
//   });

//   factory MemberProfile.fromJson(Map<String, dynamic> json) {
//     return MemberProfile(
//       membershipId: json['membership_id'] ?? '',
//       name: json['name'] ?? '',
//       firstname: json['firstname'] ?? '',
//       surname: json['surname'] ?? '',
//       othername: json['othername'] ?? '',
//       email: json['email'] ?? '',
//       phone: json['phone'] ?? '',
//       alternativePhone: json['alternative_phone'] ?? '',
//       gender: json['gender'] ?? '',
//       dob: json['dob'] ?? '',
//       nin: json['nin'] ?? '',
//       district: json['district'] ?? '',
//       memberSubcounty: json['member_subcounty'] ?? '',
//       memberParish: json['member_parish'] ?? '',
//       memberVillage: json['member_village'] ?? '',
//       branch: Branch.fromJson(json['branch'] ?? {}),
//       isMember: json['is_member'] ?? false,
//       membershipActive: json['membership_active'] ?? false,
//       accountVerified: json['account_verified'] ?? false,
//     );
//   }
// }

// class Branch {
//   final int id;
//   final String name;

//   Branch({required this.id, required this.name});

//   factory Branch.fromJson(Map<String, dynamic> json) {
//     return Branch(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//     );
//   }
// }

// class ActiveMembership {
//   final String category;
//   final String tier;
//   final String startDate;
//   final String endDate;
//   final bool active;
//   final String status;
//   final String paymentStatus;
//   final bool isExpired;

//   ActiveMembership({
//     required this.category,
//     required this.tier,
//     required this.startDate,
//     required this.endDate,
//     required this.active,
//     required this.status,
//     required this.paymentStatus,
//     required this.isExpired,
//   });

//   factory ActiveMembership.fromJson(Map<String, dynamic> json) {
//     return ActiveMembership(
//       category: json['category'] ?? '',
//       tier: json['tier'] ?? '',
//       startDate: json['start_date'] ?? '',
//       endDate: json['end_date'] ?? '',
//       active: json['active'] ?? false,
//       status: json['status'] ?? '',
//       paymentStatus: json['payment_status'] ?? '',
//       isExpired: json['is_expired'] ?? false,
//     );
//   }
// }

// // Main Screen
// class MembershipCard extends StatefulWidget {
//   @override
//   _MembershipCardState createState() => _MembershipCardState();
// }

// class _MembershipCardState extends State<MembershipCard> {
//   final MembershipController controller = Get.put(MembershipController());
//   final ScrollController _scrollController = ScrollController();
//   final GlobalKey _cardKey = GlobalKey();
//   double _cardHeight = 0;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _updateCardHeight();
//     });
//   }

//   void _updateCardHeight() {
//     final RenderBox? renderBox =
//         _cardKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox != null) {
//       setState(() {
//         _cardHeight = renderBox.size.height;
//       });
//     }
//   }

//   void _onScroll() {
//     final RenderBox? renderBox =
//         _cardKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox != null) {
//       final position = renderBox.localToGlobal(Offset.zero);
//       controller.isCardFixed.value = position.dy <= 0;
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//               child:
//                   CircularProgressIndicator(color: AppColors.primaryRedColor));
//         }

//         if (controller.profile.value == null) {
//           return Center(child: Text('No membership data available'));
//         }

//         return Stack(
//           children: [
//             CustomScrollView(
//               controller: _scrollController,
//               slivers: [
//                 SliverAppBar(
//                   title: Text('Membership Card'),
//                   elevation: 0,
//                   pinned: false,
//                   floating: false,
//                   actions: [
//                     Obx(() => IconButton(
//                           icon: Icon(controller.isEditing.value
//                               ? Icons.close
//                               : Icons.edit),
//                           onPressed: () {
//                             controller.isEditing.value =
//                                 !controller.isEditing.value;
//                           },
//                         )),
//                   ],
//                 ),
//                 SliverToBoxAdapter(
//                   child: Column(
//                     children: [
//                       // Red Cross Card Design with Key
//                       Container(
//                         key: _cardKey,
//                         child: _buildMembershipCard(controller.profile.value!),
//                       ),

//                       SizedBox(height: 20),

//                       // Profile Details
//                       _buildProfileDetails(context),

//                       SizedBox(height: 20),

//                       // Membership Status
//                       if (controller.activeMembership.value != null)
//                         _buildMembershipStatus(
//                             controller.activeMembership.value!),

//                       SizedBox(height: 20),

//                       // Update Button (only in edit mode)
//                       Obx(() => controller.isEditing.value
//                           ? Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: controller.updateProfile,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Color(0xFFE31E24),
//                                     padding: EdgeInsets.symmetric(vertical: 15),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: Text('Update Profile',
//                                       style: TextStyle(
//                                           fontSize: 16, color: Colors.white)),
//                                 ),
//                               ),
//                             )
//                           : SizedBox()),

//                       SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             // Fixed Card Overlay
//             Obx(() => controller.isCardFixed.value
//                 ? Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     child: Material(
//                       elevation: 8,
//                       child: Container(
//                         color: AppColors.bgColor,
//                         child: Column(
//                           children: [
//                             AppBar(
//                               title: Text('Membership Card'),
//                               elevation: 0,
//                               actions: [
//                                 IconButton(
//                                   icon: Icon(controller.isEditing.value
//                                       ? Icons.close
//                                       : Icons.edit),
//                                   onPressed: () {
//                                     controller.isEditing.value =
//                                         !controller.isEditing.value;
//                                   },
//                                 ),
//                               ],
//                             ),
//                             _buildMembershipCard(controller.profile.value!),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 : SizedBox()),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildMembershipCard(MemberProfile profile) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Responsive sizing
//         final screenWidth = MediaQuery.of(context).size.width;
//         final cardMargin = screenWidth > 600 ? 40.0 : 20.0;
//         final cardPadding = screenWidth > 600 ? 30.0 : 20.0;
//         final titleFontSize = screenWidth > 600 ? 18.0 : 14.0;
//         final nameFontSize = screenWidth > 600 ? 20.0 : 16.0;
//         final avatarRadius = screenWidth > 600 ? 50.0 : 40.0;
//         final iconSize = screenWidth > 600 ? 50.0 : 40.0;

//         return Container(
//           margin: EdgeInsets.symmetric(
//               horizontal: cardMargin, vertical: controller.isCardFixed.value ? 10 : 20),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFE31E24), Color(0xFFB01519)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 blurRadius: 15,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Stack(
//               children: [
//                 // Background pattern
//                 Positioned(
//                   right: -30,
//                   top: -30,
//                   child: Icon(Icons.local_hospital,
//                       size: screenWidth > 600 ? 250 : 200,
//                       color: Colors.white.withOpacity(0.1)),
//                 ),

//                 Padding(
//                   padding: EdgeInsets.all(cardPadding),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'UGANDA RED CROSS',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: titleFontSize,
//                                     fontWeight: FontWeight.bold,
//                                     letterSpacing: 1.2,
//                                   ),
//                                 ),
//                                 Text(
//                                   'SOCIETY',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: titleFontSize,
//                                     fontWeight: FontWeight.bold,
//                                     letterSpacing: 1.2,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Icon(Icons.add,
//                                 color: Color(0xFFE31E24), size: iconSize),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: screenWidth > 600 ? 35 : 25),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: avatarRadius,
//                             backgroundColor: Colors.white,
//                             child: Text(
//                               profile.firstname.isNotEmpty
//                                   ? profile.firstname[0].toUpperCase()
//                                   : 'U',
//                               style: TextStyle(
//                                   fontSize: avatarRadius * 0.8,
//                                   color: Color(0xFFE31E24),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(width: screenWidth > 600 ? 25 : 15),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   profile.name.toUpperCase(),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: nameFontSize,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                 ),
//                                 SizedBox(height: 5),
//                                 Text(
//                                   profile.membershipId,
//                                   style: TextStyle(
//                                     color: Colors.white.withOpacity(0.9),
//                                     fontSize: screenWidth > 600 ? 14.0 : 12.0,
//                                     letterSpacing: 1,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: profile.membershipActive
//                               ? Colors.green
//                               : Colors.orange,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           profile.membershipActive
//                               ? 'ACTIVE MEMBER'
//                               : 'INACTIVE',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: screenWidth > 600 ? 13.0 : 11.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProfileDetails(BuildContext context) {
//     final profile = controller.profile.value!;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final horizontalMargin = screenWidth > 600 ? 40.0 : 20.0;
//     final containerPadding = screenWidth > 600 ? 25.0 : 20.0;

//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
//       padding: EdgeInsets.all(containerPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Personal Information',
//             style: TextStyle(
//                 fontSize: screenWidth > 600 ? 20 : 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFE31E24)),
//           ),
//           SizedBox(height: 20),
//           _buildInfoRow('Full Name', profile.name, false),
//           _buildInfoRow('Gender', profile.gender, false),
//           _buildInfoRow('Date of Birth', profile.dob, false),
//           _buildInfoRow('NIN', profile.nin, false),
//           Divider(height: 30),
//           Text(
//             'Contact Information',
//             style: TextStyle(
//                 fontSize: screenWidth > 600 ? 20 : 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFE31E24)),
//           ),
//           SizedBox(height: 20),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Email', controller.emailController)
//               : _buildInfoRow('Email', profile.email, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Phone', controller.phoneController)
//               : _buildInfoRow('Phone', profile.phone, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField(
//                   'Alternative Phone', controller.alternativePhoneController)
//               : _buildInfoRow(
//                   'Alternative Phone', profile.alternativePhone, false)),
//           Divider(height: 30),
//           Text(
//             'Address Information',
//             style: TextStyle(
//                 fontSize: screenWidth > 600 ? 20 : 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFE31E24)),
//           ),
//           SizedBox(height: 20),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('District', controller.districtController)
//               : _buildInfoRow('District', profile.district, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Subcounty', controller.subcountyController)
//               : _buildInfoRow('Subcounty', profile.memberSubcounty, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Parish', controller.parishController)
//               : _buildInfoRow('Parish', profile.memberParish, false)),
//           Obx(() => controller.isEditing.value
//               ? _buildEditableField('Village', controller.villageController)
//               : _buildInfoRow('Village', profile.memberVillage, false)),
//           _buildInfoRow('Branch', profile.branch.name, false),
//         ],
//       ),
//     );
//   }

//   Widget _buildMembershipStatus(ActiveMembership membership) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final horizontalMargin = screenWidth > 600 ? 40.0 : 20.0;
//     final containerPadding = screenWidth > 600 ? 25.0 : 20.0;

//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
//       padding: EdgeInsets.all(containerPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Membership Status',
//             style: TextStyle(
//                 fontSize: screenWidth > 600 ? 20 : 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFE31E24)),
//           ),
//           SizedBox(height: 20),
//           _buildInfoRow('Category', membership.category, false),
//           _buildInfoRow('Tier', membership.tier, false),
//           _buildInfoRow('Start Date', membership.startDate, false),
//           _buildInfoRow('End Date', membership.endDate, false),
//           _buildInfoRow('Payment Status', membership.paymentStatus, false),
//           SizedBox(height: 15),
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: [
//               _buildStatusChip(
//                 membership.isExpired ? 'EXPIRED' : 'VALID',
//                 membership.isExpired ? Colors.red : Colors.green,
//               ),
//               _buildStatusChip(
//                 membership.active ? 'ACTIVE' : 'INACTIVE',
//                 membership.active ? Colors.blue : Colors.grey,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value, bool isEditable) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final labelWidth = screenWidth > 600 ? 160.0 : 130.0;

//     return Padding(
//       padding: EdgeInsets.only(bottom: 15),
//       child: screenWidth > 400
//           ? Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: labelWidth,
//                   child: Text(
//                     label,
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     value.isEmpty ? 'N/A' : value,
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ],
//             )
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   value.isEmpty ? 'N/A' : value,
//                   style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//     );
//   }

//   Widget _buildEditableField(String label, TextEditingController controller) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500),
//           ),
//           SizedBox(height: 5),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               isDense: true,
//               contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Color(0xFFE31E24)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusChip(String text, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
