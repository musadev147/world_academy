import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white),
        ),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (_profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = _profileController.profileData.value ?? {};

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailItem(Icons.person_outline_rounded, 'Full Name', '${profile['first_name'] ?? ''} ${profile['last_name'] ?? ''}'.trim()),
                  _buildDivider(),
                  _buildDetailItem(Icons.email_outlined, 'Email Address', profile['email'] ?? 'Not available'),
                  _buildDivider(),
                  _buildDetailItem(Icons.phone_outlined, 'Phone Number', profile['phone'] ?? 'Not available'),
                  _buildDivider(),
                  _buildDetailItem(Icons.location_on_outlined, 'Address', profile['address'] ?? 'Not available'),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 64.w, right: 20.w),
      child: Divider(color: Colors.grey.shade100, height: 1),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.allPrimaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.allPrimaryColor, size: 22.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Text(
                  value.isEmpty ? 'Not available' : value,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
