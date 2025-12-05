// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:redcross/utils/colors.dart';

// // class DisasterListItem extends StatelessWidget {
// //   final String title;
// //   final String subtitle;
// //   final String date;
// //   final String location;
// //   final String photo;
// //   final int id;

// //   const DisasterListItem(
// //       {super.key,
// //       required this.id,
// //       required this.title,
// //       required this.subtitle,
// //       required this.date,
// //       required this.location,
// //       required this.photo});

// //   @override
// //   Widget build(BuildContext context) {
// //     var picture = 'https://urcs-api.taufeeq.dev/api/$photo';

// // ignore_for_file: unused_import, deprecated_member_use

// //     return GestureDetector(
// //       onTap: () {
// //         Get.toNamed("/disaster-details", arguments: {'title': title, 'id': id});
// //       },
// //       child: Container(
// //           height: 97,
// //           padding: const EdgeInsets.only(left: 10, right: 2),
// //           margin: const EdgeInsets.only(top: 2, bottom: 2),
// //           decoration: const BoxDecoration(color: AppColors.whiteColor),
// //           child:
// //               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
// //             Container(
// //                 width: 75,
// //                 height: 72,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Image.network(
// //                   picture,
// //                   fit: BoxFit.cover,
// //                   loadingBuilder: (context, child, loadingProgress) {
// //                     if (loadingProgress == null) return child;
// //                     return const Center(child: CircularProgressIndicator());
// //                   },
// //                   errorBuilder: (context, error, stackTrace) {
// //                     return const Icon(Icons.error, color: Colors.red);
// //                   },
// //                 )),
// //             Expanded(
// //                 child: Container(
// //               // height: 120,
// //               padding: const EdgeInsets.symmetric(horizontal: 10),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Padding(
// //                           padding: const EdgeInsets.only(right: 0),
// //                           child: Text(title,
// //                               style: const TextStyle(
// //                                   fontSize: 13.74,
// //                                   fontFamily: "Inter",
// //                                   fontWeight: FontWeight.w700,
// //                                   color: AppColors.blackColor))),
// //                       const Text("|",
// //                           style: TextStyle(
// //                               fontSize: 13.74,
// //                               fontFamily: "Inter",
// //                               fontWeight: FontWeight.w700,
// //                               color: AppColors.blackColor)),
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 2),
// //                         child: Text(location,
// //                             style: const TextStyle(
// //                                 fontSize: 13.74,
// //                                 fontFamily: "Inter",
// //                                 fontWeight: FontWeight.w700,
// //                                 color: AppColors.blackColor)),
// //                       ),
// //                     ],
// //                   ),
// //                   Text(subtitle,
// //                       style: const TextStyle(
// //                           fontSize: 11.37,
// //                           fontFamily: "Inter",
// //                           fontWeight: FontWeight.w400,
// //                           color: AppColors.blackColor)),
// //                   const SizedBox(height: 5),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       const Padding(
// //                           padding: EdgeInsets.only(right: 5.0),
// //                           child: Row(
// //                             children: [
// //                               Icon(
// //                                 Icons.access_time_rounded,
// //                                 color: AppColors.primaryRedColor,
// //                                 size: 6.21,
// //                               ),
// //                               Padding(
// //                                 padding: EdgeInsets.only(left: 1),
// //                                 child: Text('Reported:',
// //                                     style: TextStyle(
// //                                         fontSize: 7.06,
// //                                         fontFamily: "Inter",
// //                                         fontWeight: FontWeight.w400,
// //                                         color: AppColors.primaryRedColor)),
// //                               )
// //                             ],
// //                           )),
// //                       Text(date,
// //                           style: const TextStyle(
// //                               fontSize: 7.06,
// //                               fontFamily: "Inter",
// //                               fontWeight: FontWeight.w700,
// //                               color: AppColors.blackColor))
// //                     ],
// //                   )
// //                 ],
// //               ),
// //             ))
// //           ])),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/scenes/disasters/disaster_details.dart';
// import 'package:redcross/utils/colors.dart';

// class DisasterListItem extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String date;
//   final String location;
//   final String photo;
//   final int id;

//   const DisasterListItem({
//     super.key,
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.date,
//     required this.location,
//     required this.photo,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     final imageSize = screenWidth * 0.18; // 18% of screen width
//     final titleFont = screenWidth * 0.035; // scales dynamically
//     final subtitleFont = screenWidth * 0.030;
//     final dateFont = screenWidth * 0.025;

//     final picture = 'https://urcs-api.taufeeq.dev/storage/$photo';

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DisasterDetails(
//               title: title,
//               id: id,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         constraints: const BoxConstraints(minHeight: 97), // grows if needed
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         margin: const EdgeInsets.symmetric(vertical: 2),
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 2,
//               offset: Offset(0, 1),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // --- Disaster Image ---
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 picture,
//                 width: imageSize,
//                 height: imageSize,
//                 fit: BoxFit.cover,
//                 loadingBuilder: (context, child, progress) {
//                   if (progress == null) return child;
//                   return const Center(
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   );
//                 },
//                 errorBuilder: (context, error, stackTrace) => const Icon(
//                     Icons.image_not_supported,
//                     size: 40,
//                     color: Colors.grey),
//               ),
//             ),

//             const SizedBox(width: 10),

//             // --- Text content ---
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title + location row
//                   Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           title,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: titleFont,
//                             fontFamily: "Inter",
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.blackColor,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       const Text(
//                         "|",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.blackColor,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Flexible(
//                         child: Text(
//                           location,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: titleFont,
//                             fontFamily: "Inter",
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.blackColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 5),

//                   // Subtitle
//                   Text(
//                     subtitle,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: subtitleFont,
//                       fontFamily: "Inter",
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.blackColor.withOpacity(0.8),
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   // Reported Date Row
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.access_time_rounded,
//                         color: AppColors.primaryRedColor,
//                         size: 10,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         'Reported:',
//                         style: TextStyle(
//                           fontSize: dateFont,
//                           fontFamily: "Inter",
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.primaryRedColor,
//                         ),
//                       ),
//                       const SizedBox(width: 3),
//                       Flexible(
//                         child: Text(
//                           date,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: dateFont,
//                             fontFamily: "Inter",
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.blackColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/scenes/disasters/disaster_details.dart';
import 'package:redcross/utils/colors.dart';

class DisasterListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String location;
  final String photo;
  final int id;

  const DisasterListItem({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.location,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    // Responsive sizing
    final imageSize = isTablet ? 100.0 : 85.0;
    final titleFont = isTablet ? 16.0 : 14.5;
    final subtitleFont = isTablet ? 13.0 : 12.0;
    final dateFont = isTablet ? 11.0 : 10.0;
    final locationFont = isTablet ? 13.0 : 11.5;

    final picture = 'https://urcs-api.taufeeq.dev/storage/$photo';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisasterDetails(
              title: title,
              id: id,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisasterDetails(
                      title: title,
                      id: id,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- Disaster Image with Hero animation ---
                      Hero(
                        tag: 'disaster-$id',
                        child: Container(
                          width: imageSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              picture,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primaryRedColor,
                                      value: progress.expectedTotalBytes != null
                                          ? progress.cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!
                                          : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  size: 32,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // --- Text content ---
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: titleFont,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackColor,
                                letterSpacing: -0.3,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // Location with icon
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: locationFont + 2,
                                  color: AppColors.primaryRedColor
                                      .withOpacity(0.8),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    location,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: locationFont,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryRedColor
                                          .withOpacity(0.85),
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Subtitle/Description
                            Text(
                              subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: subtitleFont,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor.withOpacity(0.65),
                                height: 1.4,
                                letterSpacing: -0.1,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Reported Date
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    AppColors.primaryRedColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: AppColors.primaryRedColor,
                                    size: dateFont + 2,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Reported: ',
                                    style: TextStyle(
                                      fontSize: dateFont,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryRedColor
                                          .withOpacity(0.85),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      date,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: dateFont,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryRedColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Arrow indicator
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
