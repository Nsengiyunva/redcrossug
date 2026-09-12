import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redcross/scenes/auth/sign_in.dart';
import 'package:redcross/utils/colors.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _isResending = false;

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Same mobile client credentials used in forgot_password.dart / sign_up.dart.
  String _basicAuthHeader() {
    const username = "+DNhMCx71sCejEPfNQf/4w==";
    const password = "MSHGBhk9E5WHwpJqruvbbIxChO9DUuvP6JEn/IZA/7w=";
    return 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  }

  String _extractErrorMessage(Map<String, dynamic>? data, String fallback) {
    String errorText = data?['message'] ?? fallback;
    final errors = data?['errors'];
    if (errors is Map && errors.isNotEmpty) {
      final firstField = errors.values.first;
      if (firstField is List && firstField.isNotEmpty) {
        errorText = firstField.first.toString();
      }
    }
    return errorText;
  }

  Future<void> _handleResend() async {
    setState(() => _isResending = true);

    try {
      final response = await http.post(
        Uri.parse('https://urcs-api.taufeeq.dev/api/auth/forgot-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': _basicAuthHeader(),
        },
        body: jsonEncode({'email': widget.email}),
      );

      Map<String, dynamic>? data;
      try {
        data = jsonDecode(response.body);
      } catch (_) {}

      if (!mounted) return;

      final bool isSuccess =
          response.statusCode == 200 || response.statusCode == 201;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isSuccess
              ? (data?['message'] ??
                  'A new code has been sent to ${widget.email}.')
              : _extractErrorMessage(
                  data, 'Could not resend the code. Please try again.')),
          backgroundColor:
              isSuccess ? Colors.green[800] : AppColors.primaryRedColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: AppColors.blackColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final payload = {
      'email': widget.email,
      'code': _codeController.text.trim(),
      'password': _passwordController.text,
      'password_confirmation': _confirmPasswordController.text,
    };

    try {
      final response = await http.patch(
        Uri.parse(
            'https://urcs-api.taufeeq.dev/api/auth/reset-password-with-code'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': _basicAuthHeader(),
        },
        body: jsonEncode(payload),
      );

      Map<String, dynamic>? data;
      try {
        data = jsonDecode(response.body);
      } catch (_) {}

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data?['message'] ??
                'Your password has been reset. Please sign in.'),
            backgroundColor: Colors.green[800],
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Clear the whole auth stack (forgot-password, reset-password) so
        // the back button can't return to a screen that needed the old
        // password/code.
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => SignIn()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_extractErrorMessage(data,
                'Could not reset your password. Please check the code and try again.')),
            backgroundColor: AppColors.primaryRedColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: AppColors.blackColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 900;

    final horizontalPadding =
        isDesktop ? size.width * 0.25 : (isTablet ? 48.0 : 24.0);
    final titleFontSize = isDesktop ? 28.0 : (isTablet ? 26.0 : 24.0);
    final buttonHeight = isTablet ? 64.0 : 56.0;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(leading: const BackButton(), title: const Text("")),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: isDesktop ? 600 : double.infinity),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Enter reset code',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        color: AppColors.blackColorF,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "We've sent a code to ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColorF,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: widget.email,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColorF,
                            ),
                          ),
                          const TextSpan(
                              text:
                                  '. Enter it below along with your new password.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildTextField(
                      controller: _codeController,
                      label: 'Reset code',
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          (val?.trim().isEmpty ?? true) ? 'Required' : null,
                    ),
                    const SizedBox(height: 24),
                    _buildPasswordField(
                      controller: _passwordController,
                      label: 'New password',
                      obscureText: _obscurePassword,
                      toggleObscure: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      validator: (val) {
                        if (val?.isEmpty ?? true) return 'Required';
                        if (val!.length < 8) return 'Min 8 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      label: 'Confirm new password',
                      obscureText: _obscureConfirmPassword,
                      toggleObscure: () => setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword),
                      validator: (val) {
                        if (val?.isEmpty ?? true) return 'Required';
                        if (val != _passwordController.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: _isResending ? null : _handleResend,
                        child: Text(
                          _isResending
                              ? 'Resending...'
                              : "Didn't get a code? Resend",
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.primaryRedColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryRedColor,
                          disabledBackgroundColor:
                              AppColors.primaryRedColor.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Text(
                                'Reset password',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "Inter"),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
                color: Colors.black87)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 2)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback toggleObscure,
    String? Function(String?)? validator,
  }) {
    return _buildTextField(
      controller: controller,
      label: label,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey),
        onPressed: toggleObscure,
      ),
      validator: validator,
    );
  }
}
