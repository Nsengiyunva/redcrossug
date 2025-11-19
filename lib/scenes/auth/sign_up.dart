// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redcross/controllers/registration_controller.dart';
// import 'package:redcross/scenes/widgets/form_password.dart';
// import 'package:redcross/utils/colors.dart';

// import '../widgets/form_textfield.dart';
// import '../widgets/red_btn.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   SignUpState createState() => SignUpState();
// }

// class SignUpState extends State<SignUp> {
//   final _formKey = GlobalKey<FormState>();
//   final RegistrationController _registerController =
//       Get.put(RegistrationController());

//   void validateForm() {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Form is valid!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.whiteColor,
//         body: SingleChildScrollView(
//             child: Container(
//           width: double.maxFinite,
//           margin: const EdgeInsets.symmetric(vertical: 30.0),
//           padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
//           child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const Text("Lets get to know you",
//                       style: TextStyle(
//                           fontSize: 20.14,
//                           color: AppColors.blackColorF,
//                           fontFamily: "Manrope",
//                           fontWeight: FontWeight.w600)),
//                   const SizedBox(height: 10),
//                   FormTextfield(
//                     no_question: true,
//                     isNumberField: false,
//                     question: 'First Name',
//                     textEditingController: _registerController.firstname,
//                     validator: (value) {
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   FormTextfield(
//                       no_question: true,
//                       isNumberField: false,
//                       question: 'Last Name',
//                       textEditingController: _registerController.lastname,
//                       validator: (value) {
//                         return null;
//                       }),
//                   const SizedBox(height: 10),
//                   FormPassword(
//                       question: 'Password',
//                       textEditingController: _registerController.password),
//                   const SizedBox(height: 10),
//                   FormPassword(
//                       question: 'Confirm Password',
//                       textEditingController:
//                           _registerController.confirmpassword),
//                   const SizedBox(height: 10),
//                   const Row(
//                     children: [
//                       Icon(
//                         Icons.check_box_outline_blank,
//                         color: AppColors.whiteColorB,
//                         size: 24.0,
//                       ),
//                       Text("By continuing, you accept our privacy policy",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontFamily: "Inter",
//                               fontSize: 10,
//                               color: AppColors.greyColorC)),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   RedBtn(
//                     label: 'Continue',
//                     onPressed: () {
//                       _registerController.registerAccount();
//                       // Get.toNamed("/account-creation-success");
//                     },
//                   )
//                 ],
//               )),
//         )));
//   }
// }
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redcross/scenes/auth/sign_in.dart';
import 'package:redcross/scenes/widgets/phone_number_field.dart';
import 'package:redcross/utils/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _membershipIdController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptPrivacy = false;
  bool _hasMembership = false;
  bool _isLoading = false;

  String _selectedPhoneCode = "256";

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _membershipIdController.dispose();
    _nationalityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _getPhoneLast4() {
    String phone = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    return phone.length >= 4 ? phone.substring(phone.length - 4) : '';
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptPrivacy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the privacy policy')),
      );
      return;
    }

    setState(() => _isLoading = true);

    const username = "+DNhMCx71sCejEPfNQf/4w==";
    const password = "MSHGBhk9E5WHwpJqruvbbIxChO9DUuvP6JEn/IZA/7w=";
    final credentials = base64Encode(utf8.encode('$username:$password'));

    final payload = {
      'first_name': _firstNameController.text.trim(),
      'last_name': _lastNameController.text.trim(),
      'phone_no': '+$_selectedPhoneCode${_phoneController.text.trim()}',
      'email': _emailController.text.trim(),
      'has_membership': _hasMembership,
      'membership_id':
          _hasMembership ? _membershipIdController.text.trim() : "",
      'phone_last4': _getPhoneLast4(),
      'nationality': _nationalityController.text.trim(),
      'password': _passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://urcs-api.taufeeq.dev/api/auth/register'),
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Basic $credentials',
        },
        body: jsonEncode(payload),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${result["message"]}')),
        );

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => SignIn()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${result["message"]}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDesktop = size.width > 900;

    final horizontalPadding =
        isDesktop ? size.width * 0.25 : (isTablet ? 48.0 : 24.0);
    final verticalPadding = isTablet ? 60.0 : 40.0;
    final titleFontSize = isDesktop ? 32.0 : (isTablet ? 28.0 : 24.0);
    final labelFontSize = isTablet ? 15.0 : 14.0;
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
                    SizedBox(height: verticalPadding),
                    Center(
                      child: Text(
                        "Let's get to know you",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ),
                    SizedBox(height: verticalPadding),

                    // First & Last Name
                    if (isTablet)
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                                controller: _firstNameController,
                                label: 'First Name',
                                labelFontSize: labelFontSize,
                                validator: (val) =>
                                    val?.isEmpty ?? true ? 'Required' : null),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                                controller: _lastNameController,
                                label: 'Last Name',
                                labelFontSize: labelFontSize,
                                validator: (val) =>
                                    val?.isEmpty ?? true ? 'Required' : null),
                          ),
                        ],
                      )
                    else ...[
                      _buildTextField(
                        controller: _firstNameController,
                        label: 'First Name',
                        labelFontSize: labelFontSize,
                        validator: (val) =>
                            val?.isEmpty ?? true ? 'Required' : null,
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        labelFontSize: labelFontSize,
                        validator: (val) =>
                            val?.isEmpty ?? true ? 'Required' : null,
                      ),
                    ],
                    const SizedBox(height: 24),

                    // Phone & Email
                    if (isTablet)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                PhoneFormField(
                                  controller: _phoneController,
                                  onCountryChanged: (code) =>
                                      _selectedPhoneCode = code,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Required";
                                    }
                                    if (val.length < 7) return "Invalid phone";
                                    if (val.length < 9)
                                      return "Invalid Phone Number entered.";
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: _emailController,
                              label: 'Email',
                              labelFontSize: labelFontSize,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val?.isEmpty ?? true) return 'Required';
                                if (!val!.contains('@')) return 'Invalid email';
                                return null;
                              },
                            ),
                          ),
                        ],
                      )
                    else ...[
                      PhoneFormField(
                        controller: _phoneController,
                        onCountryChanged: (code) => _selectedPhoneCode = code,
                        validator: (val) {
                          if (val == null || val.isEmpty) return "Required";
                          if (val.length < 7) return "Invalid phone";
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        labelFontSize: labelFontSize,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val?.isEmpty ?? true) return 'Required';
                          if (!val!.contains('@')) return 'Invalid email';
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 24),

                    // Nationality
                    _buildTextField(
                        controller: _nationalityController,
                        label: 'Nationality',
                        labelFontSize: labelFontSize,
                        validator: (val) =>
                            val?.isEmpty ?? true ? 'Required' : null),
                    const SizedBox(height: 24),

                    // Membership
                    CheckboxListTile(
                      title: Text('I have a membership',
                          style: TextStyle(fontSize: labelFontSize)),
                      value: _hasMembership,
                      onChanged: (val) =>
                          setState(() => _hasMembership = val ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (_hasMembership) ...[
                      const SizedBox(height: 16),
                      _buildTextField(
                          controller: _membershipIdController,
                          label: 'Membership ID',
                          labelFontSize: labelFontSize,
                          validator: (val) =>
                              _hasMembership && (val?.isEmpty ?? true)
                                  ? 'Required'
                                  : null),
                    ],
                    const SizedBox(height: 24),

                    // Password & Confirm Password
                    if (isTablet)
                      Row(
                        children: [
                          Expanded(
                              child: _buildPasswordField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  obscureText: _obscurePassword,
                                  toggleObscure: () => setState(() =>
                                      _obscurePassword = !_obscurePassword))),
                          const SizedBox(width: 16),
                          Expanded(
                              child: _buildPasswordField(
                                  controller: _confirmPasswordController,
                                  label: 'Confirm Password',
                                  obscureText: _obscureConfirmPassword,
                                  toggleObscure: () => setState(() =>
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword),
                                  validator: (val) {
                                    if (val?.isEmpty ?? true) return 'Required';
                                    if (val != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  })),
                        ],
                      )
                    else ...[
                      _buildPasswordField(
                          controller: _passwordController,
                          label: 'Password',
                          obscureText: _obscurePassword,
                          toggleObscure: () => setState(
                              () => _obscurePassword = !_obscurePassword)),
                      const SizedBox(height: 24),
                      _buildPasswordField(
                          controller: _confirmPasswordController,
                          label: 'Confirm Password',
                          obscureText: _obscureConfirmPassword,
                          toggleObscure: () => setState(() =>
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword),
                          validator: (val) {
                            if (val?.isEmpty ?? true) return 'Required';
                            if (val != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }),
                    ],
                    const SizedBox(height: 24),

                    // Privacy
                    CheckboxListTile(
                      title: Text(
                        'By continuing, you accept our privacy policy',
                        style: TextStyle(fontSize: labelFontSize),
                      ),
                      value: _acceptPrivacy,
                      onChanged: (val) =>
                          setState(() => _acceptPrivacy = val ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                'Continue',
                                style: TextStyle(
                                    fontSize: isTablet ? 18.0 : 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 40),
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
    required double labelFontSize,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w500,
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
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
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
      labelFontSize: 14.0,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey),
        onPressed: toggleObscure,
      ),
      validator: validator ??
          (val) {
            if (val?.isEmpty ?? true) return 'Required';
            if (val!.length < 8) return 'Min 8 characters';
            return null;
          },
    );
  }
}
