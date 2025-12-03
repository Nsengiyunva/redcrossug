// import 'package:flutter/material.dart';

// class DonationHistory extends StatelessWidget {
//   const DonationHistory({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Red Cross',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: 'SF Pro',
//       ),
//       home: const DonationHistoryScreen(),
//     );
//   }
// }

// class DonationHistoryScreen extends StatefulWidget {
//   const DonationHistoryScreen({Key? key}) : super(key: key);

//   @override
//   State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
// }

// class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
//   int _selectedIndex = 0;
//   int _currentPage = 1;
//   final int _totalPages = 10;

//   final List<DonationItem> _donations = List.generate(
//     6,
//     (index) => DonationItem(
//       title: 'NITA-U Staff Donation',
//       date: 'May 10, 2025',
//       units: '01',
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isTablet = size.width > 600;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Back',
//           style: TextStyle(
//             color: Colors.grey,
//             fontSize: 16,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         titleSpacing: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: isTablet ? 32.0 : 20.0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 8),
//                     const Text(
//                       'Donation History',
//                       style: TextStyle(
//                         fontSize: 36,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF2C2C2C),
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     _buildTabs(),
//                     const SizedBox(height: 24),
//                     _buildDonationList(isTablet),
//                     const SizedBox(height: 24),
//                     _buildPagination(),
//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabs() {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               _selectedIndex = 0;
//             });
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'ALL DONATIONS',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: _selectedIndex == 0
//                       ? const Color(0xFFE31E24)
//                       : Colors.grey,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 height: 3,
//                 width: 140,
//                 decoration: BoxDecoration(
//                   color: _selectedIndex == 0
//                       ? const Color(0xFFE31E24)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 32),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               _selectedIndex = 1;
//             });
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'FILTER',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: _selectedIndex == 1
//                       ? const Color(0xFFE31E24)
//                       : Colors.grey,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 height: 3,
//                 width: 60,
//                 decoration: BoxDecoration(
//                   color: _selectedIndex == 1
//                       ? const Color(0xFFE31E24)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDonationList(bool isTablet) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: _donations.length,
//       itemBuilder: (context, index) {
//         final isFirst = index == 0;
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 12),
//           child: _buildDonationCard(
//             donation: _donations[index],
//             isHighlighted: isFirst,
//             isTablet: isTablet,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDonationCard({
//     required DonationItem donation,
//     required bool isHighlighted,
//     required bool isTablet,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F5F5),
//         borderRadius: BorderRadius.circular(16),
//         border: isHighlighted
//             ? Border.all(
//                 color: const Color(0xFF2196F3),
//                 width: 2.5,
//               )
//             : null,
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFE5E7),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(
//                 Icons.water_drop,
//                 color: Color(0xFFE31E24),
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     donation.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF2C2C2C),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     donation.date,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   donation.units,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2C2C2C),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Units',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPagination() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildPageButton('Prev', isText: true, enabled: _currentPage > 1),
//         const SizedBox(width: 8),
//         ..._buildPageNumbers(),
//         const SizedBox(width: 8),
//         _buildPageButton('Next',
//             isText: true, enabled: _currentPage < _totalPages),
//       ],
//     );
//   }

//   List<Widget> _buildPageNumbers() {
//     List<Widget> pages = [];

//     if (_currentPage > 2) {
//       pages.add(_buildPageButton('1'));
//       pages.add(const SizedBox(width: 8));
//     }

//     if (_currentPage > 3) {
//       pages.add(_buildPageButton('...', isEllipsis: true));
//       pages.add(const SizedBox(width: 8));
//     }

//     for (int i = _currentPage - 1; i <= _currentPage + 1; i++) {
//       if (i > 0 && i <= _totalPages) {
//         pages.add(_buildPageButton(
//           i.toString(),
//           isActive: i == _currentPage,
//         ));
//         pages.add(const SizedBox(width: 8));
//       }
//     }

//     if (_currentPage < _totalPages - 2) {
//       pages.add(_buildPageButton('...', isEllipsis: true));
//       pages.add(const SizedBox(width: 8));
//     }

//     if (_currentPage < _totalPages - 1) {
//       pages.add(_buildPageButton(_totalPages.toString()));
//     }

//     return pages;
//   }

//   Widget _buildPageButton(
//     String text, {
//     bool isActive = false,
//     bool isText = false,
//     bool isEllipsis = false,
//     bool enabled = true,
//   }) {
//     if (isEllipsis) {
//       return Container(
//         width: 40,
//         height: 40,
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//           ),
//         ),
//       );
//     }

//     return GestureDetector(
//       onTap: enabled && !isEllipsis
//           ? () {
//               setState(() {
//                 if (isText) {
//                   if (text == 'Prev' && _currentPage > 1) {
//                     _currentPage--;
//                   } else if (text == 'Next' && _currentPage < _totalPages) {
//                     _currentPage++;
//                   }
//                 } else {
//                   _currentPage = int.parse(text);
//                 }
//               });
//             }
//           : null,
//       child: Container(
//         width: isText ? null : 40,
//         height: 40,
//         padding: isText
//             ? const EdgeInsets.symmetric(horizontal: 12)
//             : EdgeInsets.zero,
//         decoration: BoxDecoration(
//           color: isActive ? const Color(0xFFE31E24) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//             color: isActive
//                 ? Colors.white
//                 : enabled
//                     ? Colors.grey[700]
//                     : Colors.grey[400],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DonationItem {
//   final String title;
//   final String date;
//   final String units;

//   DonationItem({
//     required this.title,
//     required this.date,
//     required this.units,
//   });
// }
import 'package:flutter/material.dart';
import 'package:redcross/models/donation.dart';
import 'package:redcross/models/donation_item.dart';
import 'package:redcross/scenes/donations/donation_details.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Red Cross',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SF Pro',
      ),
      home: const DonationHistoryScreen(),
    );
  }
}

class DonationHistoryScreen extends StatefulWidget {
  const DonationHistoryScreen({super.key});

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> {
  int _selectedIndex = 0;
  int _currentPage = 1;
  final int _totalPages = 10;

  final List<DonationItem> _donations = List.generate(
    6,
    (index) => DonationItem(
      title: 'NITA-U Staff Donation',
      date: 'May 10, 2025',
      units: '01',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          // Tabs + donation list
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 32.0 : 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Donation History',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTabs(),
                  const SizedBox(height: 24),
                  _buildDonationList(isTablet),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Pagination bar fixed at bottom
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: _buildPagination(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ALL DONATIONS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _selectedIndex == 0
                      ? const Color(0xFFE31E24)
                      : Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 3,
                width: 140,
                decoration: BoxDecoration(
                  color: _selectedIndex == 0
                      ? const Color(0xFFE31E24)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FILTER',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _selectedIndex == 1
                      ? const Color(0xFFE31E24)
                      : Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                  color: _selectedIndex == 1
                      ? const Color(0xFFE31E24)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDonationList(bool isTablet) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _donations.length,
      itemBuilder: (context, index) {
        final isFirst = index == 0;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildDonationCard(
            donation: _donations[index],
            isHighlighted: isFirst,
            isTablet: isTablet,
          ),
        );
      },
    );
  }

  Widget _buildDonationCard({
    required DonationItem donation,
    required bool isHighlighted,
    required bool isTablet,
  }) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DonationDetails(
          //       donation: Donation(
          //         id: 1,
          //         organizationName: "NITA Uganda",
          //         donorName: "Test Donor",
          //         date: DateTime.now(),
          //         donationType: "Blood",
          //         amount: 50000,
          //         paymentMode: "Cash",
          //       ),
          //     ),
          //   ),
          // );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
            border: isHighlighted
                ? Border.all(
                    color: const Color(0xFF2196F3),
                    width: 2.5,
                  )
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE5E7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Color(0xFFE31E24),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donation.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        donation.date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      donation.units,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Units',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  // --- PAGINATION BAR ---
  Widget _buildPagination() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPageButton('Prev', isText: true, enabled: _currentPage > 1),
          const SizedBox(width: 8),
          ..._buildPageNumbers(),
          const SizedBox(width: 8),
          _buildPageButton('Next',
              isText: true, enabled: _currentPage < _totalPages),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];

    if (_currentPage > 2) {
      pages.add(_buildPageButton('1'));
      pages.add(const SizedBox(width: 8));
    }

    if (_currentPage > 3) {
      pages.add(_buildPageButton('...', isEllipsis: true));
      pages.add(const SizedBox(width: 8));
    }

    for (int i = _currentPage - 1; i <= _currentPage + 1; i++) {
      if (i > 0 && i <= _totalPages) {
        pages.add(_buildPageButton(
          i.toString(),
          isActive: i == _currentPage,
        ));
        pages.add(const SizedBox(width: 8));
      }
    }

    if (_currentPage < _totalPages - 2) {
      pages.add(_buildPageButton('...', isEllipsis: true));
      pages.add(const SizedBox(width: 8));
    }

    if (_currentPage < _totalPages - 1) {
      pages.add(_buildPageButton(_totalPages.toString()));
    }

    return pages;
  }

  Widget _buildPageButton(
    String text, {
    bool isActive = false,
    bool isText = false,
    bool isEllipsis = false,
    bool enabled = true,
  }) {
    if (isEllipsis) {
      return Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: enabled && !isEllipsis
          ? () {
              setState(() {
                if (isText) {
                  if (text == 'Prev' && _currentPage > 1) {
                    _currentPage--;
                  } else if (text == 'Next' && _currentPage < _totalPages) {
                    _currentPage++;
                  }
                } else {
                  _currentPage = int.parse(text);
                }
              });
            }
          : null,
      child: Container(
        width: isText ? null : 40,
        height: 40,
        padding: isText
            ? const EdgeInsets.symmetric(horizontal: 12)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE31E24) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive
                ? Colors.white
                : enabled
                    ? Colors.grey[700]
                    : Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
