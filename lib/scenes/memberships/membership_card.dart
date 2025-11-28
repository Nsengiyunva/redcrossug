// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/utils/colors.dart';
// import 'package:redcross/utils/storage_service.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class MembershipController extends GetxController {
//   var isLoading = false.obs;
//   var isEditing = false.obs;
//   var profile = Rxn<MemberProfile>();
//   var activeMembership = Rxn<ActiveMembership>();
//   var isCardFixed = false.obs;

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
//           'X-Requested-With': 'XMLHttpRequest'
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
//           'X-Requested-With': 'XMLHttpRequest'
//         },
//         body: json.encode({
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
//   const MembershipCard({super.key});

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
//           return const Center(
//               child:
//                   CircularProgressIndicator(color: AppColors.primaryRedColor));
//         }

//         if (controller.profile.value == null) {
//           return const Center(child: Text('No membership data available'));
//         }

//         return Stack(
//           children: [
//             CustomScrollView(
//               controller: _scrollController,
//               slivers: [
//                 SliverAppBar(
//                   title: const Text('Membership Card'),
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

//                       const SizedBox(height: 20),

//                       // Profile Details
//                       _buildProfileDetails(context),

//                       const SizedBox(height: 20),

//                       // Membership Status
//                       if (controller.activeMembership.value != null)
//                         _buildMembershipStatus(
//                             controller.activeMembership.value!),

//                       const SizedBox(height: 20),

//                       // Update Button (only in edit mode)
//                       Obx(() => controller.isEditing.value
//                           ? Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20),
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: controller.updateProfile,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFFE31E24),
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 15),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: const Text('Update Profile',
//                                       style: TextStyle(
//                                           fontSize: 16, color: Colors.white)),
//                                 ),
//                               ),
//                             )
//                           : const SizedBox()),

//                       const SizedBox(height: 30),
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
//                               title: const Text('Membership Card'),
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
//                 : const SizedBox()),
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
//               horizontal: cardMargin,
//               vertical: controller.isCardFixed.value ? 10 : 20),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFFE31E24), Color(0xFFB01519)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 blurRadius: 15,
//                 offset: const Offset(0, 5),
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
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Icon(Icons.add,
//                                 color: const Color(0xFFE31E24), size: iconSize),
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
//                                   color: const Color(0xFFE31E24),
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
//                                 const SizedBox(height: 5),
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
//                       const SizedBox(height: 20),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
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
//             offset: const Offset(0, 2),
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
//                 color: const Color(0xFFE31E24)),
//           ),
//           const SizedBox(height: 20),
//           _buildInfoRow('Full Name', profile.name, false),
//           _buildInfoRow('Gender', profile.gender, false),
//           _buildInfoRow('Date of Birth', profile.dob, false),
//           _buildInfoRow('NIN', profile.nin, false),
//           const Divider(height: 30),
//           Text(
//             'Contact Information',
//             style: TextStyle(
//                 fontSize: screenWidth > 600 ? 20 : 18,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFFE31E24)),
//           ),
//           const SizedBox(height: 20),
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
//           const Divider(height: 30),
//           Text(
//             'Address Information',
//             style: TextStyle(
//                 fontSize: screenWidth > 600 ? 20 : 18,
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFFE31E24)),
//           ),
//           const SizedBox(height: 20),
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
//             offset: const Offset(0, 2),
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
//                 color: const Color(0xFFE31E24)),
//           ),
//           const SizedBox(height: 20),
//           _buildInfoRow('Category', membership.category, false),
//           _buildInfoRow('Tier', membership.tier, false),
//           _buildInfoRow('Start Date', membership.startDate, false),
//           _buildInfoRow('End Date', membership.endDate, false),
//           _buildInfoRow('Payment Status', membership.paymentStatus, false),
//           const SizedBox(height: 15),
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
//       padding: const EdgeInsets.only(bottom: 15),
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
//                     style: const TextStyle(
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
//                 const SizedBox(height: 5),
//                 Text(
//                   value.isEmpty ? 'N/A' : value,
//                   style: const TextStyle(
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
//       padding: const EdgeInsets.only(bottom: 15),
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
//           const SizedBox(height: 5),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               isDense: true,
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: Color(0xFFE31E24)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusChip(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

//this is responsive and clean for membership card.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/utils/colors.dart';
// import 'package:redcross/utils/storage_service.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
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
//               horizontal: cardMargin,
//               vertical: controller.isCardFixed.value ? 10 : 20),
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
//---end of new responsive
// membership_card.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';
import 'package:http/http.dart' as http;

class MembershipController extends GetxController {
  var isLoading = false.obs;
  var isEditing = false.obs;
  var profile = Rxn<MemberProfile>();
  var activeMembership = Rxn<ActiveMembership>();
  var isCardFixed = false.obs;

  // Contact controllers
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final alternativePhoneController = TextEditingController();

  // Locations data
  var locations = <String, dynamic>{}.obs;
  var districts = <dynamic>[].obs;
  var counties = <dynamic>[].obs;
  var subcounties = <dynamic>[].obs;
  var parishes = <dynamic>[].obs;
  var villages = <dynamic>[].obs;

  // Selected ids (we store IDs, but when updating we send names to the server)
  var selectedDistrict = ''.obs;
  var selectedCounty = ''.obs;
  var selectedSubcounty = ''.obs;
  var selectedParish = ''.obs;
  var selectedVillage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocations();
    fetchMemberProfile();
  }

  Future<void> loadLocations() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/data/locations.json');
      final data = json.decode(jsonStr) as Map<String, dynamic>;
      locations.value = data;
      districts.value = List.from(data['districts'] ?? []);
      // counties/subcounties/parishes/villages will be populated on selection
    } catch (e) {
      // If the asset is missing or invalid, notify developer/user
      debugPrint('Failed to load locations.json: $e');
    }
  }

  // Utility helpers
  String nameFromListById(List list, String id) {
    if (id.isEmpty) return '';
    try {
      final found = list.firstWhere((el) => (el['id']?.toString() ?? '') == id,
          orElse: () => null);
      if (found != null) return (found['name'] ?? '').toString();
      return '';
    } catch (_) {
      return '';
    }
  }

  String idFromListByName(List list, String name) {
    if (name.isEmpty) return '';
    try {
      final found = list.firstWhere(
          (el) =>
              (el['name'] ?? '').toString().toLowerCase() == name.toLowerCase(),
          orElse: () => null);
      if (found != null) return (found['id'] ?? '').toString();
      return '';
    } catch (_) {
      return '';
    }
  }

  void onDistrictSelected(String id) {
    selectedDistrict.value = id;
    // populate counties for this district
    final allCounties = List.from(locations['counties'] ?? []);
    counties.value = allCounties
        .where((c) => (c['district']?.toString() ?? '') == id)
        .toList();

    // reset downstream selections
    selectedCounty.value = '';
    selectedSubcounty.value = '';
    selectedParish.value = '';
    selectedVillage.value = '';
    subcounties.clear();
    parishes.clear();
    villages.clear();
  }

  void onCountySelected(String id) {
    selectedCounty.value = id;
    final allSub = List.from(locations['subcounties'] ?? []);
    subcounties.value =
        allSub.where((s) => (s['county']?.toString() ?? '') == id).toList();

    selectedSubcounty.value = '';
    selectedParish.value = '';
    selectedVillage.value = '';
    parishes.clear();
    villages.clear();
  }

  void onSubcountySelected(String id) {
    selectedSubcounty.value = id;
    final allPar = List.from(locations['parishes'] ?? []);
    parishes.value =
        allPar.where((p) => (p['subcounty']?.toString() ?? '') == id).toList();

    selectedParish.value = '';
    selectedVillage.value = '';
    villages.clear();
  }

  void onParishSelected(String id) {
    selectedParish.value = id;
    final allVill = List.from(locations['villages'] ?? []);
    villages.value =
        allVill.where((v) => (v['parish']?.toString() ?? '') == id).toList();

    selectedVillage.value = '';
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
          'X-Requested-With': 'XMLHttpRequest'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        profile.value = MemberProfile.fromJson(data['profile']);

        if (data['active_membership'] != null) {
          activeMembership.value =
              ActiveMembership.fromJson(data['active_membership']);
        }

        // Initialize contact controllers
        emailController.text = profile.value?.email ?? '';
        phoneController.text = profile.value?.phone ?? '';
        alternativePhoneController.text = profile.value?.alternativePhone ?? '';

        // Try to preselect location dropdowns using names from profile
        // district
        final districtName = profile.value?.district ?? '';
        if (districtName.isNotEmpty && districts.isNotEmpty) {
          final dId = idFromListByName(districts, districtName);
          if (dId.isNotEmpty) {
            onDistrictSelected(dId);

            // subcounty (profile stores name; find id in subcounties for the district)
            final subName = profile.value?.memberSubcounty ?? '';
            if (subName.isNotEmpty) {
              // ensure subcounties list is populated (onDistrictSelected did this)
              final sId = idFromListByName(subcounties, subName);
              if (sId.isNotEmpty) {
                onCountySelected(
                    selectedCounty.value); // ensure county list is set
                // Actually we don't have county name in profile; attempt to find county by checking which county contains this subcounty
                if (sId.isEmpty) {
                  // fallback: scan all subcounties to find the matching subcounty and pick its county
                  final allSub = List.from(locations['subcounties'] ?? []);
                  final foundSub = allSub.firstWhere(
                      (s) =>
                          (s['name'] ?? '').toString().toLowerCase() ==
                          subName.toLowerCase(),
                      orElse: () => null);
                  if (foundSub != null) {
                    final countyIdFromSub =
                        (foundSub['county'] ?? '').toString();
                    if (countyIdFromSub.isNotEmpty) {
                      onCountySelected(countyIdFromSub);
                      // now populate subcounties and select
                      final sId2 = idFromListByName(subcounties, subName);
                      if (sId2.isNotEmpty) {
                        onSubcountySelected(sId2);
                      }
                    }
                  }
                } else {
                  onSubcountySelected(sId);
                }
              } else {
                // try global search for subcounty and infer county/district
                final allSub = List.from(locations['subcounties'] ?? []);
                final foundSub = allSub.firstWhere(
                    (s) =>
                        (s['name'] ?? '').toString().toLowerCase() ==
                        subName.toLowerCase(),
                    orElse: () => null);
                if (foundSub != null) {
                  final countyIdFromSub = (foundSub['county'] ?? '').toString();
                  if (countyIdFromSub.isNotEmpty) {
                    // find the county and its district
                    final allCounties = List.from(locations['counties'] ?? []);
                    final foundCounty = allCounties.firstWhere(
                        (c) => (c['id']?.toString() ?? '') == countyIdFromSub,
                        orElse: () => null);
                    if (foundCounty != null) {
                      final districtIdFromCounty =
                          (foundCounty['district'] ?? '').toString();
                      if (districtIdFromCounty.isNotEmpty) {
                        onDistrictSelected(districtIdFromCounty);
                        onCountySelected(countyIdFromSub);
                        final sId2 = idFromListByName(subcounties, subName);
                        if (sId2.isNotEmpty) {
                          onSubcountySelected(sId2);
                        }
                      }
                    }
                  }
                }
              }
            }

            // parish
            final parishName = profile.value?.memberParish ?? '';
            if (parishName.isNotEmpty) {
              // try to find parish id among loaded parishes
              final pId = idFromListByName(parishes, parishName);
              if (pId.isNotEmpty) {
                onParishSelected(pId);
              } else {
                // attempt global search and infer upstreams
                final allPar = List.from(locations['parishes'] ?? []);
                final foundPar = allPar.firstWhere(
                    (p) =>
                        (p['name'] ?? '').toString().toLowerCase() ==
                        parishName.toLowerCase(),
                    orElse: () => null);
                if (foundPar != null) {
                  final subIdFromPar = (foundPar['subcounty'] ?? '').toString();
                  if (subIdFromPar.isNotEmpty) {
                    // infer county and district as well
                    final allSub = List.from(locations['subcounties'] ?? []);
                    final foundSub = allSub.firstWhere(
                        (s) => (s['id']?.toString() ?? '') == subIdFromPar,
                        orElse: () => null);
                    if (foundSub != null) {
                      final countyIdFromSub =
                          (foundSub['county'] ?? '').toString();
                      final allCounties =
                          List.from(locations['counties'] ?? []);
                      final foundCounty = allCounties.firstWhere(
                          (c) => (c['id']?.toString() ?? '') == countyIdFromSub,
                          orElse: () => null);
                      if (foundCounty != null) {
                        final districtIdFromCounty =
                            (foundCounty['district'] ?? '').toString();
                        if (districtIdFromCounty.isNotEmpty) {
                          onDistrictSelected(districtIdFromCounty);
                          onCountySelected(countyIdFromSub);
                          onSubcountySelected(subIdFromPar);
                          onParishSelected((foundPar['id'] ?? '').toString());
                        }
                      }
                    }
                  }
                }
              }
            }

            // village
            final villageName = profile.value?.memberVillage ?? '';
            if (villageName.isNotEmpty) {
              final vId = idFromListByName(villages, villageName);
              if (vId.isNotEmpty) {
                selectedVillage.value = vId;
              } else {
                // global search
                final allVill = List.from(locations['villages'] ?? []);
                final foundVill = allVill.firstWhere(
                    (v) =>
                        (v['name'] ?? '').toString().toLowerCase() ==
                        villageName.toLowerCase(),
                    orElse: () => null);
                if (foundVill != null) {
                  final parishFromVill = (foundVill['parish'] ?? '').toString();
                  if (parishFromVill.isNotEmpty) {
                    onParishSelected(parishFromVill);
                    selectedVillage.value = (foundVill['id'] ?? '').toString();
                  }
                }
              }
            }
          } // dId not empty
        } // districtName not empty
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

      // Convert selected IDs back to names to send to API (backend likely expects names)
      final districtName = nameFromListById(
          List.from(locations['districts'] ?? []), selectedDistrict.value);
      final countyName = nameFromListById(
          List.from(locations['counties'] ?? []), selectedCounty.value);
      final subcountyName = nameFromListById(
          List.from(locations['subcounties'] ?? []), selectedSubcounty.value);
      final parishName = nameFromListById(
          List.from(locations['parishes'] ?? []), selectedParish.value);
      final villageName = nameFromListById(
          List.from(locations['villages'] ?? []), selectedVillage.value);

      final body = <String, dynamic>{
        // send district and member_subcounty/member_parish/member_village as names
        'district': districtName.isNotEmpty
            ? districtName
            : profile.value?.district ?? '',
        'member_subcounty': subcountyName.isNotEmpty
            ? subcountyName
            : profile.value?.memberSubcounty ?? '',
        'member_parish': parishName.isNotEmpty
            ? parishName
            : profile.value?.memberParish ?? '',
        'member_village': villageName.isNotEmpty
            ? villageName
            : profile.value?.memberVillage ?? '',
        // you can add phone/email updates too if desired
        'email': emailController.text,
        'phone': phoneController.text,
        'alternative_phone': alternativePhoneController.text,
      };

      final response = await http.patch(
        Uri.parse('https://urcs-api.taufeeq.dev/api/vms/membership/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        },
        body: json.encode(body),
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
    super.onClose();
  }
}

// Models (unchanged, kept for completeness)
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

// Main Screen (MembershipCard)
class MembershipCard extends StatefulWidget {
  const MembershipCard({super.key});

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
          return const Center(
              child:
                  CircularProgressIndicator(color: AppColors.primaryRedColor));
        }

        if (controller.profile.value == null) {
          return const Center(child: Text('No membership data available'));
        }

        return Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  title: const Text('Membership Card'),
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

                      const SizedBox(height: 20),

                      // Profile Details
                      _buildProfileDetails(context),

                      const SizedBox(height: 20),

                      // Membership Status
                      if (controller.activeMembership.value != null)
                        _buildMembershipStatus(
                            controller.activeMembership.value!),

                      const SizedBox(height: 20),

                      // Update Button (only in edit mode)
                      Obx(() => controller.isEditing.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: controller.updateProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE31E24),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Update Profile',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ),
                              ),
                            )
                          : const SizedBox()),

                      const SizedBox(height: 30),
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
                              title: const Text('Membership Card'),
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
                : const SizedBox()),
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
            gradient: const LinearGradient(
              colors: [Color(0xFFE31E24), Color(0xFFB01519)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.add,
                                color: const Color(0xFFE31E24), size: iconSize),
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
                                  color: const Color(0xFFE31E24),
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
                                const SizedBox(height: 5),
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
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
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
            offset: const Offset(0, 2),
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
                color: const Color(0xFFE31E24)),
          ),
          const SizedBox(height: 20),
          _buildInfoRow('Full Name', profile.name, false),
          _buildInfoRow('Gender', profile.gender, false),
          _buildInfoRow('Date of Birth', profile.dob, false),
          _buildInfoRow('NIN', profile.nin, false),
          const Divider(height: 30),
          Text(
            'Contact Information',
            style: TextStyle(
                fontSize: screenWidth > 600 ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE31E24)),
          ),
          const SizedBox(height: 20),
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
          const Divider(height: 30),
          Text(
            'Address Information',
            style: TextStyle(
                fontSize: screenWidth > 600 ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE31E24)),
          ),
          const SizedBox(height: 20),

          // District Dropdown
          Obx(() => controller.isEditing.value
              ? DropdownButtonFormField<String>(
                  value: controller.selectedDistrict.value.isEmpty
                      ? null
                      : controller.selectedDistrict.value,
                  items:
                      controller.districts.map<DropdownMenuItem<String>>((d) {
                    return DropdownMenuItem<String>(
                      value: (d['id'] ?? '').toString(),
                      child: Text(d['name'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) controller.onDistrictSelected(val);
                  },
                  decoration: InputDecoration(
                    labelText: 'District',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              : _buildInfoRow('District', profile.district, false)),

          const SizedBox(height: 12),

          // County Dropdown
          Obx(() => controller.isEditing.value
              ? DropdownButtonFormField<String>(
                  value: controller.selectedCounty.value.isEmpty
                      ? null
                      : controller.selectedCounty.value,
                  items: controller.counties.map<DropdownMenuItem<String>>((c) {
                    return DropdownMenuItem<String>(
                      value: (c['id'] ?? '').toString(),
                      child: Text(c['name'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) controller.onCountySelected(val);
                  },
                  decoration: InputDecoration(
                    labelText: 'County',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              : _buildInfoRow(
                  'County', /* no county in profile model */ '', false)),

          const SizedBox(height: 12),

          // Subcounty Dropdown
          Obx(() => controller.isEditing.value
              ? DropdownButtonFormField<String>(
                  value: controller.selectedSubcounty.value.isEmpty
                      ? null
                      : controller.selectedSubcounty.value,
                  items:
                      controller.subcounties.map<DropdownMenuItem<String>>((s) {
                    return DropdownMenuItem<String>(
                      value: (s['id'] ?? '').toString(),
                      child: Text(s['name'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) controller.onSubcountySelected(val);
                  },
                  decoration: InputDecoration(
                    labelText: 'Subcounty',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              : _buildInfoRow('Subcounty', profile.memberSubcounty, false)),

          const SizedBox(height: 12),

          // Parish Dropdown
          Obx(() => controller.isEditing.value
              ? DropdownButtonFormField<String>(
                  value: controller.selectedParish.value.isEmpty
                      ? null
                      : controller.selectedParish.value,
                  items: controller.parishes.map<DropdownMenuItem<String>>((p) {
                    return DropdownMenuItem<String>(
                      value: (p['id'] ?? '').toString(),
                      child: Text(p['name'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) controller.onParishSelected(val);
                  },
                  decoration: InputDecoration(
                    labelText: 'Parish',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              : _buildInfoRow('Parish', profile.memberParish, false)),

          const SizedBox(height: 12),

          // Village Dropdown
          Obx(() => controller.isEditing.value
              ? DropdownButtonFormField<String>(
                  value: controller.selectedVillage.value.isEmpty
                      ? null
                      : controller.selectedVillage.value,
                  items: controller.villages.map<DropdownMenuItem<String>>((v) {
                    return DropdownMenuItem<String>(
                      value: (v['id'] ?? '').toString(),
                      child: Text(v['name'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedVillage.value = val;
                  },
                  decoration: InputDecoration(
                    labelText: 'Village',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              : _buildInfoRow('Village', profile.memberVillage, false)),

          const SizedBox(height: 12),

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
            offset: const Offset(0, 2),
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
                color: const Color(0xFFE31E24)),
          ),
          const SizedBox(height: 20),
          _buildInfoRow('Category', membership.category, false),
          _buildInfoRow('Tier', membership.tier, false),
          _buildInfoRow('Start Date', membership.startDate, false),
          _buildInfoRow('End Date', membership.endDate, false),
          _buildInfoRow('Payment Status', membership.paymentStatus, false),
          const SizedBox(height: 15),
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
      padding: const EdgeInsets.only(bottom: 15),
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
                    style: const TextStyle(
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
                const SizedBox(height: 5),
                Text(
                  value.isEmpty ? 'N/A' : value,
                  style: const TextStyle(
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
      padding: const EdgeInsets.only(bottom: 15),
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
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE31E24)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
