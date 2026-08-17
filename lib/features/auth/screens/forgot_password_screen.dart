import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common_wigdets/common_button.dart';
import '../../../common_wigdets/custom_textfiled.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_font_style.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _currentStep = 1;
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    } else {
      Get.back();
      Get.snackbar(
        'Success',
        'Password reset successfully. Please login.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                _currentStep == 1
                    ? 'Reset Password'
                    : _currentStep == 2
                        ? 'Verify OTP'
                        : 'Set New Password',
                style: TextFontStyle.textStyle20PoppinsW400.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                  color: AppColors.c1C1C28,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _currentStep == 1
                    ? 'Enter your Registration ID or Email address and we will send you an OTP.'
                    : _currentStep == 2
                        ? 'Enter the 6-digit OTP sent to your email.'
                        : 'Enter your new password and confirm it.',
                style: TextFontStyle.textStyle121C1C28Poppins400.copyWith(
                  color: AppColors.c494953,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 32.h),
              if (_currentStep == 1)
                CustomTextFormField(
                  controller: _emailController,
                  labelText: 'Registration ID / Email',
                  hintText: 'Enter your ID or Email',
                  keyboardType: TextInputType.emailAddress,
                )
              else if (_currentStep == 2)
                CustomTextFormField(
                  controller: _otpController,
                  labelText: 'OTP',
                  hintText: 'Enter 6-digit OTP',
                  keyboardType: TextInputType.number,
                )
              else if (_currentStep == 3) ...[
                CustomTextFormField(
                  controller: _newPasswordController,
                  labelText: 'New Password',
                  hintText: 'Enter new password',
                  isPassword: true,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter new password',
                  isPassword: true,
                ),
              ],
              SizedBox(height: 32.h),
              CommonButton(
                text: _currentStep == 1
                    ? 'Send OTP'
                    : _currentStep == 2
                        ? 'Verify OTP'
                        : 'Reset Password',
                onPressed: _nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
