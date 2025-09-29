import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcross/utils/colors.dart';

class DatePicker extends StatefulWidget {
  final String question;
  final TextEditingController controller;

  const DatePicker(
      {super.key, required this.question, required this.controller});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final _formKey = GlobalKey<FormState>();
  // final _dateController = TextEditingController();

  // @override
  // void dispose() {
  //   // widget.controller.dispose();
  //   super.dispose();
  // }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

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
                    color: AppColors.greyColorC)),
            const SizedBox(height: 2),
            TextField(
              controller: widget.controller,
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 12.74,
                  color: AppColors.greyColorC,
                  fontWeight: FontWeight.w500),
              readOnly: true,
              onTap: () => _pickDate(context),
              decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_month,
                      color: AppColors.greyColorC),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    // Border when not focused
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: AppColors.blackColorB, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border when focused
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: AppColors.primaryRedColor, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    // Border when error occurs
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                        color: AppColors.primaryRedColor, width: 1),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
