import 'package:flutter/material.dart';
import 'package:redcross/scenes/widgets/country_search_sheet.dart';
import 'package:redcross/utils/countries.dart';

/// Drop-in replacement for a free-text "Nationality" field: tapping it
/// opens the same searchable country picker used for phone codes, and
/// the selected country's name is written into [controller] — so the
/// rest of sign_up.dart (payload building, validation) doesn't need to
/// change at all.
class NationalityField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final double labelFontSize;
  final String? Function(String?)? validator;

  const NationalityField({
    super.key,
    required this.controller,
    required this.label,
    required this.labelFontSize,
    this.validator,
  });

  @override
  State<NationalityField> createState() => _NationalityFieldState();
}

class _NationalityFieldState extends State<NationalityField> {
  Country? _selected;

  @override
  void initState() {
    super.initState();
    _selected = findCountryByName(widget.controller.text);
  }

  Future<void> _openPicker(FormFieldState<String> field) async {
    final picked = await showCountryPickerSheet(
      context,
      title: 'Select your nationality',
      countries: kCountriesUgandaFirst,
      selected: _selected,
      showDialCode: false,
    );
    if (picked == null) return;
    setState(() {
      _selected = picked;
      widget.controller.text = picked.name;
    });
    field.didChange(picked.name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: widget.labelFontSize,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        FormField<String>(
          initialValue: widget.controller.text,
          validator: widget.validator,
          builder: (field) {
            return InkWell(
              onTap: () => _openPicker(field),
              borderRadius: BorderRadius.circular(8),
              child: InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[50],
                  errorText: field.errorText,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                ),
                child: Row(
                  children: [
                    if (_selected != null) ...[
                      Text(_selected!.flag,
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Text(
                        _selected?.name ?? 'Select your nationality',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          color: _selected != null
                              ? Colors.black87
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          onSaved: (_) {},
        ),
      ],
    );
  }
}
