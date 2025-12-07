// import 'package:flutter/material.dart';
// import 'package:redcross/scenes/home_badge.dart';
// import 'package:redcross/scenes/volunteer/volunteer_register.dart';
// import 'package:redcross/scenes/widgets/picture_badge.dart';
// import 'package:redcross/utils/colors.dart';

// class VolunteerHome extends StatelessWidget {
//   const VolunteerHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.bgColor,
//         body: SingleChildScrollView(
//           child: Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(vertical: 30.0),
//               padding:
//                   const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     alignment: Alignment.centerLeft,
//                     child: const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Volunteer and",
//                             style: TextStyle(
//                               fontFamily: "Inter",
//                               fontSize: 26.33,
//                               fontWeight: FontWeight.w700,
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                           SizedBox(height: 1),
//                           Text(
//                             "Community Engagement",
//                             style: TextStyle(
//                               fontFamily: "Inter",
//                               fontSize: 26.33,
//                               fontWeight: FontWeight.w700,
//                             ),
//                             textAlign: TextAlign.start,
//                           )
//                         ]),
//                   ),
//                   const SizedBox(height: 15),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           height: 86,
//                           width: 335,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 5, horizontal: 30),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryRedColor,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                               color: AppColors.primaryRedColor,
//                               width: 1,
//                             ),
//                           ),
//                           child: Center(
//                               child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                 const Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text("Want to",
//                                           style: TextStyle(
//                                               fontFamily: "Inter",
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.bold,
//                                               color: AppColors.whiteColor)),
//                                       Text("Volunteer",
//                                           style: TextStyle(
//                                               fontFamily: "Inter",
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.bold,
//                                               color: AppColors.whiteColor))
//                                     ]),
//                                 SizedBox(
//                                   width: 100, // custom width
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       // Get.toNamed("/donations-categories");
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const VolunteerRegister()),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: AppColors
//                                           .redColorL, // background color
//                                       // foregroundColor:
//                                       //     Colors.white, // text color
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(
//                                             5), // rounded corners
//                                         // side: const BorderSide(
//                                         //     color: Colors.black,
//                                         //     width: 0), // border
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 5, horizontal: 5),
//                                     ),
//                                     child: const Text("Sign Up",
//                                         style: TextStyle(
//                                             fontFamily: "Inter",
//                                             fontSize: 12.3,
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColors.primaryRedColor)),
//                                   ),
//                                 )
//                               ]))),
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   Container(
//                       width: 335,
//                       height: 48,
//                       decoration: BoxDecoration(
//                           color: AppColors.redColorD,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Track My Volunteer Hours",
//                               style: TextStyle(
//                                   fontFamily: "Inter",
//                                   fontSize: 12,
//                                   color: AppColors.primaryRedColor,
//                                   fontWeight: FontWeight.w700))
//                         ],
//                       )),
//                   const SizedBox(height: 15),
//                   const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Upcoming Events',
//                               style: TextStyle(
//                                   fontSize: 13.09,
//                                   fontFamily: "Inter",
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.greyColorZ)),
//                           Row(children: [
//                             Text('See All',
//                                 style: TextStyle(
//                                     fontSize: 9.03,
//                                     fontFamily: "Inter",
//                                     fontWeight: FontWeight.w400,
//                                     color: AppColors.greyColorZ)),
//                           ])
//                         ],
//                       )),
//                   const SizedBox(height: 10),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       HomeBadge(
//                           title: 'Annual Red Cross Gala & Fundraiser',
//                           icon_name: "blood_icon"),
//                       HomeBadge(
//                           title: 'World Blood Donor Day', icon_name: "gala")
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Community Updates',
//                               style: TextStyle(
//                                   fontSize: 13.09,
//                                   fontFamily: "Inter",
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.greyColorZ)),
//                           Row(children: [
//                             Text('See All',
//                                 style: TextStyle(
//                                     fontSize: 9.03,
//                                     fontFamily: "Inter",
//                                     fontWeight: FontWeight.w400,
//                                     color: AppColors.greyColorZ)),
//                           ])
//                         ],
//                       )),
//                   const SizedBox(height: 15),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 2.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         PictureBadge(
//                             title: 'Volunteer Assesment',
//                             address: "Kakira, Jinja",
//                             image: "assets/images/member_1.png"),
//                         PictureBadge(
//                             title: 'Disaster Training',
//                             address: "Nakawa, Kampala",
//                             image: "assets/images/member_1.png")
//                       ],
//                     ),
//                   )
//                 ],
//               )),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:redcross/scenes/home_badge.dart';
import 'package:redcross/scenes/volunteer/volunteer_register.dart';
import 'package:redcross/scenes/widgets/picture_badge.dart';
import 'package:redcross/utils/colors.dart';

class VolunteerHome extends StatelessWidget {
  const VolunteerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04;
    final maxWidth = screenWidth > 600 ? 600.0 : screenWidth;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: maxWidth,
            margin: EdgeInsets.symmetric(
              vertical: screenWidth * 0.05,
              horizontal: horizontalPadding,
            ),
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.05,
              horizontal: horizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --------------------------------------------------
                /// HEADER SECTION
                /// --------------------------------------------------
                Text(
                  "Volunteer and",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Community Engagement",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: screenWidth * 0.065,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: screenWidth * 0.06),

                /// --------------------------------------------------
                /// SIGN UP CARD
                /// --------------------------------------------------
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.04,
                    horizontal: screenWidth * 0.06,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryRedColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primaryRedColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Want to",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: screenWidth * 0.055,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Text(
                              "Volunteer",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: screenWidth * 0.055,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const VolunteerRegister(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColorL,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.03,
                              horizontal: screenWidth * 0.02,
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: screenWidth * 0.032,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryRedColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth * 0.06),

                /// --------------------------------------------------
                /// FEATURED OPPORTUNITIES
                /// --------------------------------------------------
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.redColorD,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Featured Opportunities",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: screenWidth * 0.038,
                          color: AppColors.primaryRedColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.03),

                      /// Overflow-safe row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Blood Drive Assistant",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: screenWidth * 0.032,
                                    color: AppColors.primaryRedColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: screenWidth * 0.01),
                                Text(
                                  "Help coordinate donors",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: screenWidth * 0.028,
                                    color: AppColors.greyColorZ,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: screenWidth * 0.04,
                            color: AppColors.primaryRedColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: screenWidth * 0.06),

                /// --------------------------------------------------
                /// UPCOMING EVENTS
                /// --------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming Events',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        color: AppColors.greyColorZ,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: screenWidth * 0.028,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColorZ,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.03),

                screenWidth > 400
                    ? Row(
                        children: [
                          Expanded(
                            child: HomeBadge(
                              title: 'Annual Red Cross Gala & Fundraiser',
                              icon_name: "blood_icon",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: HomeBadge(
                              title: 'World Blood Donor Day',
                              icon_name: "gala",
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          HomeBadge(
                            title: 'Annual Red Cross Gala & Fundraiser',
                            icon_name: "blood_icon",
                          ),
                          SizedBox(height: screenWidth * 0.03),
                          HomeBadge(
                            title: 'World Blood Donor Day',
                            icon_name: "gala",
                          ),
                        ],
                      ),
                SizedBox(height: screenWidth * 0.06),

                /// --------------------------------------------------
                /// COMMUNITY UPDATES
                /// --------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Community Updates',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        color: AppColors.greyColorZ,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: screenWidth * 0.028,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColorZ,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.04),

                screenWidth > 400
                    ? Row(
                        children: [
                          Expanded(
                            child: PictureBadge(
                              title: 'Volunteer Assessment',
                              address: "Kakira, Jinja",
                              image: "assets/images/member_1.png",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: PictureBadge(
                              title: 'Disaster Training',
                              address: "Nakawa, Kampala",
                              image: "assets/images/member_1.png",
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          PictureBadge(
                            title: 'Volunteer Assessment',
                            address: "Kakira, Jinja",
                            image: "assets/images/member_1.png",
                          ),
                          SizedBox(height: screenWidth * 0.03),
                          PictureBadge(
                            title: 'Disaster Training',
                            address: "Nakawa, Kampala",
                            image: "assets/images/member_1.png",
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
