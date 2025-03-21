// import 'package:flutter/material.dart';
// import 'package:redcross/utils/colors.dart';

// class PaymentListItem extends StatelessWidget {
//   final String text_label;
//   final String icon_name;
//   bool? outline;

//   PaymentListItem(
//       {super.key,
//       required this.text_label,
//       required this.icon_name,
//       this.outline});

//   String selectedOption = 'Option 1';

//   @override
//   Widget build(BuildContext context) {
//     final iconMap = <String, IconData>{
//       'credit_card_rounded': Icons.credit_card_rounded,
//       'phone_iphone_rounded': Icons.phone_iphone_rounded
//     };

//     final iconData = iconMap[icon_name] ?? Icons.error;

//     return Container(
//       height: 72,
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//           border: Border(
//               top: BorderSide(
//                   width: outline! ? 2.0 : 0, color: AppColors.greyColorH),
//               bottom: BorderSide(
//                   width: outline! ? 2.0 : 0, color: AppColors.greyColorH))),
//       child: Expanded(
//           child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: AppColors.redColorC),
//                   child: Center(
//                       child: Icon(
//                     iconData,
//                     color: AppColors.primaryRedColor,
//                     size: 20.0,
//                   ))),
//               Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     text_label,
//                     style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.greyColorG,
//                         fontFamily: "Inter"),
//                   ))
//             ],
//           ),
//           Radio(
//             value: 'Option 1',
//             groupValue: "",
//             activeColor:
//                 AppColors.primaryRedColor, // Custom color when selected
//             onChanged: (value) {
//               // setState(() {
//               //   selectedOption = value.toString();
//               // });
//             },
//           )
//         ],
//       )),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/controllers/disasters_list_controller.dart';
import 'package:redcross/utils/colors.dart';

class PaymentListItem extends StatefulWidget {
  final String text_label;
  final String icon_name;
  bool? outline;

  PaymentListItem(
      {super.key,
      required this.text_label,
      required this.icon_name,
      this.outline});

  @override
  PaymentListItemState createState() => PaymentListItemState();
}

class PaymentListItemState extends State<PaymentListItem> {
  String selectedOption = 'Option 1';

  final DisastersListController disasterController =
      Get.put(DisastersListController());

  @override
  Widget build(BuildContext context) {
    final iconMap = <String, IconData>{
      'credit_card_rounded': Icons.credit_card_rounded,
      'phone_iphone_rounded': Icons.phone_iphone_rounded
    };

    final iconData = iconMap[widget.icon_name] ?? Icons.error;

    return Container(
      height: 72,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
            width: widget.outline! ? 1.0 : 0, color: AppColors.greyColorH),
        bottom: BorderSide(
            width: widget.outline! ? 1.0 : 0, color: AppColors.greyColorH),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Row(
              children: [
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.redColorC),
                    child: Center(
                        child: Icon(
                      iconData,
                      color: AppColors.primaryRedColor,
                      size: 20.0,
                    ))),
                SizedBox(width: 10),
                Text(
                  widget.text_label,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColorG,
                      fontFamily: "Inter"),
                )
              ],
            ),
          ),
          // SizedBox(width: 50),
          // RadioListTile<String>(
          //   title: Text(''),
          //   value: "Custom",
          //   groupValue: selectedOption,
          //   activeColor: Colors.red,
          //   onChanged: (value) {
          //     setState(() {
          //       selectedOption = value!;
          //     });
          //   },
          // )
        ],
      ),
    );
  }
}
