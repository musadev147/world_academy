import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common_wigdets/common_button.dart';
import '../../../common_wigdets/custom_textfiled.dart';
import '../../../common_wigdets/custom_appbar.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_font_style.dart';
import '../../../route/app_pages.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png', // Assuming a logo exists or placeholder
                  height: 100.h,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.school,
                    size: 100.h,
                    color: AppColors.allPrimaryColor,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Welcome Back',
                style: TextFontStyle.textStyle20PoppinsW400.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                  color: AppColors.c1C1C28,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Sign in to your World Academy account.',
                style: TextFontStyle.textStyle121C1C28Poppins400.copyWith(
                  color: AppColors.c494953,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 32.h),
              CustomTextFormField(
                controller: _authController.emailController,
                labelText: 'Registration ID / Email',
                hintText: 'Enter your ID or Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                controller: _authController.passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                isPassword: true,
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.FORGOT_PASSWORD);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextFontStyle.textStyle121C1C28Poppins400.copyWith(
                      color: AppColors.allPrimaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              CommonButton(
                text: 'Sign In',
                onPressed: () {
                  _authController.login();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
