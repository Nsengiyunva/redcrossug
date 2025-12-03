// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/storage_service.dart';

class DropdownField<T> extends StatefulWidget {
  final String label;
  final String hint;
  final List<T> items;
  final T? initialValue;
  final Function(T?)? onChanged;
  final TextEditingController controller;
  final String? Function(T?)? validator;

  const DropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.controller,
    this.initialValue,
    this.onChanged,
    this.validator,
    String? selectedValue,
  });

  @override
  _DropdownFieldWithControllerState<T> createState() =>
      _DropdownFieldWithControllerState<T>();
}

class _DropdownFieldWithControllerState<T> extends State<DropdownField<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    if (selectedValue != null) {
      widget.controller.text = selectedValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: selectedValue,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primaryRedColor,
            width: 1,
          ),
        ),
      ),
      hint: Text(
        widget.hint,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
          fontSize: 12,
          height: StorageService.getHeight(24, 12),
          letterSpacing: StorageService.getSpacing(12),
        ),
      ),
      items: widget.items.map((value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Inter",
              fontSize: 12,
              height: StorageService.getHeight(24, 12),
              letterSpacing: StorageService.getSpacing(12),
            ),
          ),
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() {
          selectedValue = newValue;
          widget.controller.text = newValue?.toString() ?? "";
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      validator: widget.validator,
    );
  }
}
