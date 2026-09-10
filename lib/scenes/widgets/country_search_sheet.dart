import 'package:flutter/material.dart';
import 'package:redcross/utils/colors.dart';
import 'package:redcross/utils/countries.dart';

/// Opens a searchable, scrollable list of all countries in a rounded
/// bottom sheet and resolves with the one the user taps (or null if they
/// dismiss it). Shared by the phone dial-code picker and the nationality
/// picker so both look and behave identically.
Future<Country?> showCountryPickerSheet(
  BuildContext context, {
  required String title,
  required List<Country> countries,
  Country? selected,
  bool showDialCode = false,
}) {
  return showModalBottomSheet<Country>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => _CountryPickerSheet(
      title: title,
      countries: countries,
      selected: selected,
      showDialCode: showDialCode,
    ),
  );
}

class _CountryPickerSheet extends StatefulWidget {
  final String title;
  final List<Country> countries;
  final Country? selected;
  final bool showDialCode;

  const _CountryPickerSheet({
    required this.title,
    required this.countries,
    required this.selected,
    required this.showDialCode,
  });

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  late List<Country> _filtered = widget.countries;
  final _searchController = TextEditingController();

  void _onSearchChanged(String query) {
    final q = query.trim().toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? widget.countries
          : widget.countries
              .where((c) =>
                  c.name.toLowerCase().contains(q) ||
                  c.dialCode.contains(q) ||
                  c.iso2.toLowerCase() == q)
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final sheetHeight = mediaQuery.size.height * 0.82;

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: Container(
        height: sheetHeight,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                autofocus: false,
                style: const TextStyle(fontFamily: "Inter", fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search country or code',
                  hintStyle: TextStyle(
                      fontFamily: "Inter", color: Colors.grey[400]),
                  prefixIcon:
                      const Icon(Icons.search_rounded, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFF7F8FB),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                        color: AppColors.primaryRedColor, width: 1.4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No countries match your search',
                        style: TextStyle(
                            fontFamily: "Inter", color: Colors.grey[500]),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Colors.grey.shade100,
                        indent: 16,
                        endIndent: 16,
                      ),
                      itemBuilder: (context, index) {
                        final country = _filtered[index];
                        final isSelected =
                            widget.selected?.iso2 == country.iso2;
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => Navigator.of(context).pop(country),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryRedColor
                                      .withOpacity(0.06)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Text(country.flag,
                                    style: const TextStyle(fontSize: 22)),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    country.name,
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14.5,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ),
                                if (widget.showDialCode)
                                  Text(
                                    country.dialDisplay,
                                    style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackColorC,
                                    ),
                                  ),
                                if (isSelected) ...[
                                  const SizedBox(width: 10),
                                  const Icon(Icons.check_circle_rounded,
                                      color: AppColors.primaryRedColor,
                                      size: 18),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
