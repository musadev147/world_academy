import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';
import '../../../common_wigdets/custom_textfiled.dart';

class AdminPushNotificationsScreen extends StatelessWidget {
  const AdminPushNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send a new notification to students devices.',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
              ),
              SizedBox(height: 24.h),
              Text('Target Audience', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                value: 'All Students',
                items: ['All Students', 'Active Students', 'Specific Course'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(height: 20.h),
              Text('Category Preset', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                value: 'General Notice',
                items: [
                  'General Notice',
                  'Exam Schedule',
                  'Result Publication',
                  'Assignment Reminder',
                  'Payment Reminder',
                  'New Course Upload'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                labelText: 'Title',
                hintText: 'Enter notification title',
              ),
              SizedBox(height: 20.h),
              Text('Message', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.c1C1C28)),
              SizedBox(height: 8.h),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter your message...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.allPrimaryColor),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              OutlinedButton.icon(
                onPressed: () {
                  // Attach Image logic
                },
                icon: Icon(Icons.image, color: AppColors.allPrimaryColor),
                label: Text('Attach Promotional Image / Video', style: TextStyle(color: AppColors.allPrimaryColor)),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  side: BorderSide(color: AppColors.allPrimaryColor),
                ),
              ),
              SizedBox(height: 32.h),
              CommonButton(
                text: 'Send Broadcast',
                onPressed: () {
                  Get.snackbar(
                    'Success',
                    'Push notification sent.',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
