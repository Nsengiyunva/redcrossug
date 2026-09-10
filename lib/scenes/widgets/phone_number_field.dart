import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redcross/scenes/widgets/country_search_sheet.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/countries.dart';

/// Phone number input with a searchable dial-code + flag picker covering
/// every country, instead of the previous 4-country hardcoded dropdown.
///
/// Public API is unchanged from the previous version — [controller],
/// [onCountryChanged] (still receives the dial code as a plain string,
/// e.g. "256"), and [validator] — so callers (sign_in.dart, sign_up.dart)
/// don't need to change how they use it.
class PhoneFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onCountryChanged;
  final String? Function(String?)? validator;

  /// ISO-2 code to preselect. Defaults to Uganda, matching prior behavior.
  final String initialIso2;

  const PhoneFormField({
    super.key,
    required this.controller,
    required this.onCountryChanged,
    this.validator,
    this.initialIso2 = 'UG',
  });

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  late Country _selected = kCountries.firstWhere(
    (c) => c.iso2 == widget.initialIso2,
    orElse: () => kCountries.firstWhere((c) => c.iso2 == 'UG'),
  );

  Future<void> _openPicker() async {
    final picked = await showCountryPickerSheet(
      context,
      title: 'Select country code',
      countries: kCountriesUgandaFirst,
      selected: _selected,
      showDialCode: true,
    );
    if (picked == null) return;
    setState(() => _selected = picked);
    widget.onCountryChanged(picked.dialCode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColorGrey, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _openPicker,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_selected.flag, style: const TextStyle(fontSize: 19)),
                    const SizedBox(width: 6),
                    Text(
                      _selected.dialDisplay,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.greyColorC, size: 18),
                  ],
                ),
              ),
            ),
          ),
          Container(width: 1, color: AppColors.borderColorGrey, margin: const EdgeInsets.symmetric(vertical: 10)),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              validator: widget.validator,
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
              decoration: const InputDecoration(
                hintText: "701234567",
                hintStyle: TextStyle(
                  fontFamily: "Inter",
                  color: AppColors.greyColorC,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
