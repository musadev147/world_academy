import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_font_style.dart';
import '../../../route/app_pages.dart';
import '../../../common_wigdets/common_button.dart';
import '../controllers/courses_controller.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  final CoursesController _controller = Get.put(CoursesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Courses',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: Colors.white),
        ),
        backgroundColor: AppColors.allPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_controller.courses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.library_books_rounded, size: 80.r, color: Colors.grey.shade300),
                  SizedBox(height: 16.h),
                  Text('No courses found.', style: TextStyle(color: Colors.grey.shade500, fontSize: 16.sp)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            itemCount: _controller.courses.length,
            itemBuilder: (context, index) {
              final course = _controller.courses[index];
              return _buildCourseCard(course);
            },
          );
        }),
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    final bool isCourseLocked = false; // Add real logic if provided by API
    final String title = course['name'] ?? course['title'] ?? 'Unknown Course';
    final double progress = 0.0; // API doesn't provide progress yet
    final String? pictureUrl = course['picture'];
    final bool hasValidImage = pictureUrl != null && pictureUrl.isNotEmpty && pictureUrl != 'https://worldacademy.uk/';
    final List modules = course['modules'] ?? [];

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.grey.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          childrenPadding: EdgeInsets.zero,
          iconColor: AppColors.allPrimaryColor,
          collapsedIconColor: Colors.grey.shade400,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Image Thumbnail
              Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  color: AppColors.allPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.allPrimaryColor.withOpacity(0.1)),
                  image: hasValidImage && !isCourseLocked
                      ? DecorationImage(
                          image: NetworkImage(pictureUrl),
                          fit: BoxFit.cover,
                          onError: (error, stackTrace) => debugPrint('Image load failed'),
                        )
                      : null,
                ),
                child: isCourseLocked
                    ? Icon(Icons.lock_rounded, color: Colors.grey.shade400, size: 24.r)
                    : (!hasValidImage ? Icon(Icons.image_rounded, color: AppColors.allPrimaryColor.withOpacity(0.3), size: 24.r) : null),
              ),
              SizedBox(width: 16.w),
              // Course Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13.sp,
                        color: isCourseLocked ? Colors.grey.shade500 : Colors.black87,
                        height: 1.3,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Progress', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade500)),
                        Text('${(progress * 100).toInt()}%', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w800, color: AppColors.allPrimaryColor)),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade100,
                        valueColor: AlwaysStoppedAnimation<Color>(isCourseLocked ? Colors.grey.shade300 : AppColors.allPrimaryColor),
                        minHeight: 4.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: isCourseLocked
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12.r)),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock_rounded, size: 14.r, color: Colors.grey.shade500),
                          SizedBox(width: 6.w),
                          Text('Course Locked', style: TextStyle(color: Colors.grey.shade500, fontSize: 11.sp, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.CLASS_PLAYER),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.allPrimaryColor.withOpacity(0.1),
                        foregroundColor: AppColors.allPrimaryColor,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Start Class', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
                          SizedBox(width: 6.w),
                          Icon(Icons.play_circle_fill_rounded, size: 16.r),
                        ],
                      ),
                    ),
                  ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey.shade100, height: 1),
                  SizedBox(height: 16.h),
                  if (modules.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text('No modules available yet.', style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp)),
                      ),
                    )
                  else
                    ...modules.map((module) {
                      final isLocked = module['isLocked'] == true;
                      final String moduleTitle = module['title'] ?? 'Module';
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color: isLocked ? Colors.grey.shade50 : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                          leading: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: isLocked ? Colors.grey.shade200 : AppColors.allPrimaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isLocked ? Icons.lock_rounded : Icons.play_arrow_rounded,
                              color: isLocked ? Colors.grey.shade500 : AppColors.allPrimaryColor,
                              size: 16.r,
                            ),
                          ),
                          title: Text(
                            moduleTitle,
                            style: TextStyle(
                              color: isLocked ? Colors.grey.shade500 : Colors.black87,
                              fontSize: 12.sp,
                              fontWeight: isLocked ? FontWeight.normal : FontWeight.w600,
                            ),
                          ),
                          trailing: isLocked
                              ? null
                              : Icon(Icons.arrow_forward_ios_rounded, size: 12.r, color: Colors.grey.shade400),
                          onTap: isLocked || isCourseLocked
                              ? () => Get.toNamed(Routes.STRIPE_PAYMENT)
                              : () => Get.toNamed(Routes.CLASS_PLAYER),
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

