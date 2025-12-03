// import 'package:flutter/material.dart';
// import 'package:redcross/utils/colors.dart';
// import 'chat_screen.dart';

// class FloatingChatButton extends StatelessWidget {
//   const FloatingChatButton({super.key});

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 24,
//       right: 24,
//       child: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (_) => const ChatScreen()),
//           );
//         },
//         backgroundColor: AppColors.primaryRedColor,
//         child: const Icon(Icons.chat_bubble, color: Colors.white),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:redcross/utils/colors.dart';
// import 'chat_screen.dart';

// class FloatingChatButton extends StatelessWidget {
//   const FloatingChatButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isTablet = size.width > 600;

//     return Align(
//       alignment: Alignment.bottomRight,
//       child: Padding(
//         padding: const EdgeInsets.only(
//           right: 20,
//           bottom: 40, // <-- Extra bottom margin
//         ),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (_) => const ChatScreen()),
//             );
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: isTablet ? 20 : 16,
//               vertical: isTablet ? 14 : 10,
//             ),
//             decoration: BoxDecoration(
//               color: AppColors.primaryRedColor,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.chat_bubble, color: Colors.white),
//                 SizedBox(width: isTablet ? 12 : 8),
//                 Text(
//                   "Talk to Red Cross",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: isTablet ? 18 : 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
