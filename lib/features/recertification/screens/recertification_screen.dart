import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';

class RecertificationScreen extends StatelessWidget {
  const RecertificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Premium background
      appBar: AppBar(
        title: Text('Recertification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white)),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eligible for Recertification',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.sp, color: Colors.black87),
              ),
              SizedBox(height: 16.h),
              Container(
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
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: AppColors.allPrimaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.workspace_premium_rounded, color: AppColors.allPrimaryColor, size: 24.r),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Text(
                              'Advanced Diploma in Supply Chain Management',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.sp, height: 1.3, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Divider(color: Colors.grey.shade100, height: 1),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, size: 14.r, color: Colors.grey.shade400),
                          SizedBox(width: 6.w),
                          Text('Issued: 2021-08-10', style: TextStyle(color: Colors.grey.shade600, fontSize: 11.sp, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.event_busy_rounded, size: 14.r, color: Colors.red.shade400),
                          SizedBox(width: 6.w),
                          Text('Expires: 2026-08-10', style: TextStyle(color: Colors.red.shade700, fontSize: 11.sp, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.orange.shade100),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline_rounded, size: 16.r, color: Colors.orange.shade800),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'This certification has expired or is about to expire. You must pass the recertification exam to renew your credential.',
                                style: TextStyle(fontSize: 11.sp, color: Colors.orange.shade900, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: CommonButton(
                          height: 44.h,
                          text: 'Apply for Recertification',
                          icon: Icon(Icons.autorenew_rounded, color: Colors.white, size: 18.r),
                          borderRadius: 16.r,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
