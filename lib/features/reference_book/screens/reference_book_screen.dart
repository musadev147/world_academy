import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_font_style.dart';
import '../../../route/app_pages.dart';

class ReferenceBookScreen extends StatelessWidget {
  const ReferenceBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> referenceBooks = [
      {
        'title': 'Supply Chain Management: Strategy, Planning, and Operation',
        'author': 'Sunil Chopra',
        'size': '2.5 MB',
      },
      {
        'title': 'Logistics and Supply Chain Management',
        'author': 'Martin Christopher',
        'size': '4.1 MB',
      },
      {
        'title': 'Operations Management',
        'author': 'Jay Heizer',
        'size': '3.2 MB',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Premium background
      appBar: AppBar(
        title: Text('Reference Books', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white)),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert_rounded, color: Colors.white),
            onSelected: (value) {
              Get.toNamed(value);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: Routes.STUDENT_DASHBOARD, child: Text('Dashboard', style: TextStyle(fontSize: 13.sp))),
                PopupMenuItem(value: Routes.MY_COURSES, child: Text('My Courses', style: TextStyle(fontSize: 13.sp))),
                PopupMenuItem(value: Routes.CLASS_SCHEDULE, child: Text('Class Schedule', style: TextStyle(fontSize: 13.sp))),
                PopupMenuItem(value: Routes.ASSIGNMENTS, child: Text('Assignments', style: TextStyle(fontSize: 13.sp))),
                PopupMenuItem(value: Routes.EXAMS, child: Text('Exams', style: TextStyle(fontSize: 13.sp))),
                PopupMenuItem(value: Routes.RESULT, child: Text('Results', style: TextStyle(fontSize: 13.sp))),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          itemCount: referenceBooks.length,
          itemBuilder: (context, index) {
            final book = referenceBooks[index];

            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
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
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(24.r),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(Icons.picture_as_pdf_rounded, color: Colors.red, size: 28.r),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book['title'],
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.sp, color: Colors.black87, height: 1.3),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.person_outline_rounded, size: 14.r, color: Colors.grey.shade500),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(
                                    '${book['author']}',
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 11.sp, fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.sd_storage_outlined, size: 14.r, color: Colors.grey.shade400),
                                SizedBox(width: 4.w),
                                Text(
                                  'Size: ${book['size']}',
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 10.sp, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10.h),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.allPrimaryColor.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.file_download_rounded, color: AppColors.allPrimaryColor, size: 20.r),
                              onPressed: () {},
                              tooltip: 'Download PDF',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
