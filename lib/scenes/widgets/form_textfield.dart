import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redcross/utils/colors.dart';

class FormTextfield extends StatelessWidget {
  bool no_question;
  final String question;
  final TextEditingController textEditingController;
  FormFieldValidator<String>? validator;
  bool isNumberField;

  FormTextfield(
      {super.key,
      required this.question,
      required this.textEditingController,
      required this.validator,
      required this.isNumberField,
      required this.no_question});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(question,
                    style: const TextStyle(
                        fontSize: 12.74,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor))),
            const SizedBox(height: 2),
            TextFormField(
              controller: textEditingController,
              keyboardType:
                  isNumberField ? TextInputType.number : TextInputType.text,
              inputFormatters:
                  isNumberField ? [FilteringTextInputFormatter.digitsOnly] : [],
              style: const TextStyle(
                  fontFamily: "Inter", fontSize: 14, color: Color(0xFF293041)),
              validator: validator,
              decoration: InputDecoration(
                  hintText: no_question ? "" : question,
                  filled: true, // Enables background color
                  fillColor: AppColors.whiteColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: AppColors.greyColorD, width: 1)),
                  enabledBorder: OutlineInputBorder(
                    // Border when not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.greyColorD, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border when focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: AppColors.primaryRedColor, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    // Border when error occurs
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFFED1C24), width: 1),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
