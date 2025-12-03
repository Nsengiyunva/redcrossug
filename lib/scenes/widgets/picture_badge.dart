import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class PictureBadge extends StatelessWidget {
  final String title;
  final String address;
  final String image;

  const PictureBadge({
    super.key,
    required this.title,
    required this.address,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // final iconMap = <String, IconData>{
    //   'blood_icon': Icons.bloodtype_rounded,
    //   'gala': Icons.safety_check,
    // };

    // final iconData = iconMap[icon_name] ?? Icons.error;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 162,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover, // fills the container nicely
              ),
            )),
        const SizedBox(height: 5),
        Text(title,
            style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 13.21,
                color: AppColors.blackColorX)),
        const SizedBox(height: 2),
        Text(address,
            style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 9.83,
                color: AppColors.greyColorX))
      ],
    );
  }
}


// child: Column(
//           children: [
//             Text(title,
//                 style: const TextStyle(
//                     fontFamily: "Inter",
//                     fontSize: 13.21,
//                     color: AppColors.blackColorX)),
//             const SizedBox(height: 10),
//             Text("Test 2")
//           ],
//         )