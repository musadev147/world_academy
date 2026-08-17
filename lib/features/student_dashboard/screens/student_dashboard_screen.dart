import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../route/app_pages.dart';
import '../../../common_wigdets/common_button.dart';
import '../controllers/dashboard_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  final DashboardController _dashboardController = Get.put(DashboardController());
  final ProfileController _profileController = Get.put(ProfileController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F6F9), // Ultra-clean light grey background
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPremiumHeader(),
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enrolled Programs',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14.sp,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 11.sp,
                      color: AppColors.allPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _buildPremiumEnrolledCard(),
            SizedBox(height: 100.h), // padding for floating nav bar
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Header
        Container(
          width: double.infinity,
          height: 250.h,
          decoration: BoxDecoration(
            color: AppColors.allPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32.r),
              bottomRight: Radius.circular(32.r),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.allPrimaryColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Subtle background pattern/icon
              Positioned(
                right: -30.w,
                top: -20.h,
                child: Icon(Icons.school_rounded, size: 200.r, color: Colors.white.withOpacity(0.05)),
              ),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => _scaffoldKey.currentState?.openDrawer(),
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(Icons.menu_rounded, color: Colors.white, size: 24.r),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Dashboard',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, color: Colors.white, letterSpacing: 0.5),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(Icons.notifications_active_rounded, color: AppColors.allPrimaryColor, size: 24.r),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      
                      // Welcome Area
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 28.r,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person_rounded, size: 34.r, color: AppColors.allPrimaryColor),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello,',
                                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 11.sp, fontWeight: FontWeight.w500),
                                ),
                              Obx(() {
                                final profile = _profileController.profileData.value;
                                final name = profile != null ? "${profile['first_name'] ?? ''} ${profile['last_name'] ?? ''}".trim() : 'Loading...';
                                return Text(
                                  name.isEmpty ? 'Student Name' : name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                );
                              }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Floating Quick Actions (3 sleek buttons instead of 2 massive blocks)
        Positioned(
          bottom: -35.h,
          left: 16.w,
          right: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 24, offset: const Offset(0, 12)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickAction(Icons.play_circle_fill_rounded, 'Tutorial', Colors.redAccent, () {}),
                _buildQuickAction(Icons.picture_as_pdf_rounded, 'Guides', Colors.blueAccent, () {}),
                _buildQuickAction(Icons.forum_rounded, 'Discuss', Colors.green, () => Get.toNamed(Routes.DISCUSS)),
                _buildQuickAction(Icons.help_rounded, 'Support', Colors.orange, () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22.r),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 9.sp, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumEnrolledCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.grey.shade100, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section - Vibrant Banner
            Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.allPrimaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 10.w,
                    bottom: -10.h,
                    child: Icon(Icons.rocket_launch_rounded, size: 100.r, color: AppColors.allPrimaryColor.withOpacity(0.1)),
                  ),
                  Positioned(
                    left: 20.w,
                    top: 20.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.allPrimaryColor.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, size: 8.r, color: Colors.green),
                          SizedBox(width: 4.w),
                          Text(
                            'Active Course',
                            style: TextStyle(color: Colors.black87, fontSize: 8.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Bottom Section - Content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Advanced Diploma in Supply Chain Management',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp, height: 1.3, letterSpacing: -0.5, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16.h),
                  
                  // Progress Section
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Overall Progress', style: TextStyle(color: Colors.grey.shade600, fontSize: 10.sp, fontWeight: FontWeight.w600)),
                                Text('45%', style: TextStyle(color: AppColors.allPrimaryColor, fontSize: 11.sp, fontWeight: FontWeight.w900)),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: LinearProgressIndicator(
                                value: 0.45,
                                backgroundColor: Colors.grey.shade100,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.allPrimaryColor),
                                minHeight: 6.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 20.h),
                  
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.CLASS_PLAYER),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.allPrimaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Resume Class', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700)),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward_rounded, size: 16.r),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(32.r), bottomRight: Radius.circular(32.r)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 60.h, left: 24.w, right: 24.w, bottom: 30.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.allPrimaryColor, AppColors.allPrimaryColor.withBlue(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(32.r)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 36.r,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person_rounded, size: 40.r, color: AppColors.allPrimaryColor),
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(() {
                  final profile = _profileController.profileData.value;
                  final name = profile != null ? "${profile['first_name'] ?? ''} ${profile['last_name'] ?? ''}".trim() : 'Loading...';
                  return Text(
                    name.isEmpty ? 'Student Name' : name,
                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                  );
                }),
                SizedBox(height: 4.h),
                Obx(() {
                  final profile = _profileController.profileData.value;
                  final email = profile?['email'] ?? 'student@example.com';
                  return Text(
                    email,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12.sp, fontWeight: FontWeight.w600),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 12.h, bottom: 20.h),
              children: [
                _drawerItem(Icons.dashboard_rounded, 'Dashboard', () => Get.back()),
                _drawerItem(Icons.book_rounded, 'My Courses', () => Get.toNamed(Routes.MY_COURSES)),
                _drawerItem(Icons.event_rounded, 'Class Schedule', () => Get.toNamed(Routes.CLASS_SCHEDULE)),
                _drawerItem(Icons.assignment_rounded, 'Assignments', () => Get.toNamed(Routes.ASSIGNMENTS)),
                _drawerItem(Icons.edit_document, 'Exams', () => Get.toNamed(Routes.EXAMS)),
                _drawerItem(Icons.grade_rounded, 'Results', () => Get.toNamed(Routes.RESULT)),
                _drawerItem(Icons.library_books_rounded, 'Reference Books', () => Get.toNamed(Routes.REFERENCE_BOOK)),
                _drawerItem(Icons.card_membership_rounded, 'Certificates', () => Get.toNamed(Routes.CERTIFICATES)),
                _drawerItem(Icons.payment_rounded, 'Payment History', () => Get.toNamed(Routes.PAYMENTS)),
                _drawerItem(Icons.forum_rounded, 'Discuss', () => Get.toNamed(Routes.DISCUSS)),
                _drawerItem(Icons.autorenew_rounded, 'Recertification', () => Get.toNamed(Routes.RECERTIFICATION)),
                _drawerItem(Icons.group_add_rounded, 'Refer', () => Get.toNamed(Routes.REFER)),
                _drawerItem(Icons.video_library_rounded, 'YouTube Channels', () => Get.toNamed(Routes.YOUTUBE)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  child: Divider(color: Colors.grey.shade200),
                ),
                _drawerItem(Icons.logout_rounded, 'Logout', () => Get.offAllNamed(Routes.LOGIN), color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        leading: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: (color ?? AppColors.allPrimaryColor).withOpacity(0.08),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: color ?? AppColors.allPrimaryColor, size: 22.r),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: color ?? Colors.black87,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        onTap: onTap,
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      ),
    );
  }
}

