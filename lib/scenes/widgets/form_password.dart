import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';

class FormPassword extends StatefulWidget {
  final String question;
  final TextEditingController textEditingController;

  FormPassword(
      {super.key, required this.question, required this.textEditingController});

  @override
  FormPasswordState createState() => FormPasswordState();
}

class FormPasswordState extends State<FormPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question,
                style: const TextStyle(
                    fontSize: 12.74,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor)),
            const SizedBox(height: 2),
            TextField(
              controller: widget.textEditingController,
              obscureText: _isObscure,
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 12.74,
                  color: AppColors.greyColorC,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.greyColorD, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border when focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.redColorA, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    // Border when error occurs
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.redColorA, width: 1),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
