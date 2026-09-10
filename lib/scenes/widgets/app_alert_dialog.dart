import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redcross/utils/colors.dart';

/// A single reusable, on-brand dialog used across the app for
/// success / error / "not found" style confirmations — replacing plain
/// `Get.snackbar` calls with something more deliberate.
///
/// Prefer [AppAlertDialog.show] over constructing this widget directly.
class AppAlertDialog extends StatefulWidget {
  final IconData icon;
  final Color accentColor;
  final String title;
  final String message;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  /// If set, the dialog auto-dismisses (running [onPrimary]) after this
  /// delay, so a quick confirmation like "signed in successfully" doesn't
  /// require a tap. The button is still shown for anyone who wants to
  /// dismiss immediately.
  final Duration? autoDismissAfter;

  const AppAlertDialog({
    super.key,
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.message,
    required this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.autoDismissAfter,
  });

  static Future<void> show({
    required IconData icon,
    required Color accentColor,
    required String title,
    required String message,
    required String primaryLabel,
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    Duration? autoDismissAfter,
  }) {
    return Get.dialog(
      AppAlertDialog(
        icon: icon,
        accentColor: accentColor,
        title: title,
        message: message,
        primaryLabel: primaryLabel,
        onPrimary: onPrimary,
        secondaryLabel: secondaryLabel,
        onSecondary: onSecondary,
        autoDismissAfter: autoDismissAfter,
      ),
      barrierDismissible: autoDismissAfter == null,
    );
  }

  @override
  State<AppAlertDialog> createState() => _AppAlertDialogState();
}

class _AppAlertDialogState extends State<AppAlertDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final delay = widget.autoDismissAfter;
    if (delay != null) {
      _timer = Timer(delay, _runPrimary);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _runPrimary() {
    _timer?.cancel();
    if (Get.isDialogOpen ?? false) Get.back();
    widget.onPrimary?.call();
  }

  void _runSecondary() {
    _timer?.cancel();
    if (Get.isDialogOpen ?? false) Get.back();
    widget.onSecondary?.call();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width > 480 ? 400.0 : size.width - 56;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.88, end: 1.0),
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) =>
            Transform.scale(scale: scale, child: child),
        child: Container(
          width: maxWidth,
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 22),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 30,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  color: widget.accentColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: widget.accentColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(widget.icon, color: Colors.white, size: 26),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13.5,
                  height: 1.45,
                  color: AppColors.blackColorC,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _runPrimary,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    widget.primaryLabel,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 14.5,
                    ),
                  ),
                ),
              ),
              if (widget.secondaryLabel != null) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _runSecondary,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      widget.secondaryLabel!,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColorC,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
