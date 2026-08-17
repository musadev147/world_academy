import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../route/app_pages.dart';
import '../../../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("SplashScreen: initState called");
    Future.delayed(const Duration(seconds: 2), () {
      print("SplashScreen: 2 seconds passed, navigating to LOGIN");
      try {
        Get.offAllNamed(Routes.LOGIN);
        print("SplashScreen: Navigation called");
      } catch (e) {
        print("SplashScreen: Navigation failed with error: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.allPrimaryColor,
      body: Center(
        child: Icon(
          Icons.school,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
