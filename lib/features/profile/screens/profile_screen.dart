import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_font_style.dart';
import '../../../route/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white),
        ),
        backgroundColor: AppColors.allPrimaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        final profile = _profileController.profileData.value;
        final name = profile != null ? "${profile['first_name'] ?? ''} ${profile['last_name'] ?? ''}".trim() : 'Loading...';
        final id = profile?['id']?.toString() ?? '...';
        
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.allPrimaryColor.withOpacity(0.3), width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 48.r,
                        backgroundColor: AppColors.allPrimaryColor.withOpacity(0.1),
                        child: Icon(Icons.person_rounded, size: 56.r, color: AppColors.allPrimaryColor),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.allPrimaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(color: AppColors.allPrimaryColor.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(Icons.edit_rounded, size: 16.r, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                name.isEmpty ? 'Student Name' : name,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.allPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'ID: $id',
                  style: TextStyle(
                    color: AppColors.allPrimaryColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileOption(
                    icon: Icons.person_outline_rounded,
                    title: 'Personal Details',
                    onTap: () {
                      Get.toNamed(Routes.PERSONAL_DETAILS);
                    },
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    icon: Icons.payment_rounded,
                    title: 'Payment History',
                    onTap: () {
                      Get.toNamed(Routes.PAYMENTS);
                    },
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    icon: Icons.library_books_rounded,
                    title: 'Reference Books',
                    onTap: () {
                      Get.toNamed(Routes.REFERENCE_BOOK);
                    },
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    icon: Icons.lock_outline_rounded,
                    title: 'Change Password',
                    onTap: () {
                      Get.toNamed(Routes.CHANGE_PASSWORD);
                    },
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Support',
                    onTap: () {
                      Get.toNamed(Routes.HELP_SUPPORT);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: _buildProfileOption(
                icon: Icons.logout_rounded,
                title: 'Logout',
                iconColor: Colors.red,
                textColor: Colors.red,
                showTrailing: false,
                onTap: () {
                  Get.offAllNamed(Routes.LOGIN);
                },
              ),
            ),
            SizedBox(height: 100.h), // Spacing for floating nav bar
          ],
        ),
      );
    }),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 60.w, right: 20.w),
      child: Divider(color: Colors.grey.shade100, height: 1),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
    bool showTrailing = true,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      leading: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.allPrimaryColor).withOpacity(0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: iconColor ?? AppColors.allPrimaryColor, size: 20.r),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13.sp,
          color: textColor ?? Colors.black87,
        ),
      ),
      trailing: showTrailing ? Icon(Icons.arrow_forward_ios_rounded, size: 14.r, color: Colors.grey.shade400) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      onTap: onTap,
    );
  }
}
