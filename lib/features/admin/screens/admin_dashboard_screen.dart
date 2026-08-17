import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../route/app_pages.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Admin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  children: [
                    _buildAdminCard('Students', Icons.people, Routes.ADMIN_STUDENT_MANAGEMENT),
                    _buildAdminCard('Enrollments', Icons.app_registration, Routes.ADMIN_ENROLLMENT),
                    _buildAdminCard('Invoices', Icons.receipt, Routes.ADMIN_INVOICES),
                    _buildAdminCard('Assessments', Icons.assessment, Routes.ADMIN_ASSESSMENTS),
                    _buildAdminCard('Courses', Icons.school, Routes.ADMIN_COURSE_MANAGEMENT),
                    _buildAdminCard('Push Notifications', Icons.notifications_active, Routes.ADMIN_PUSH_NOTIFICATIONS),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminCard(String title, IconData icon, String route) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.r, color: AppColors.allPrimaryColor),
            SizedBox(height: 12.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
