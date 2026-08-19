import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: AppColors.allPrimaryColor.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 72.h,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.school_rounded,
                        size: 72.h,
                        color: AppColors.allPrimaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                Text(
                  'Welcome Back 👋',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 28.sp,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      color: const Color(0xFF64748B),
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: 'Sign in to your '),
                      TextSpan(
                        text: 'World Academy',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w700,
                          color: AppColors.allPrimaryColor,
                        ),
                      ),
                      const TextSpan(text: ' account.'),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  controller: _authController.emailController,
                  labelText: 'Registration ID / Email',
                  hintText: 'Enter your ID or Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: _authController.passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  isPassword: true,
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: AppColors.allPrimaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
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
      ),
    );
  }
}
