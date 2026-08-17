import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';

class AdminAssessmentsScreen extends StatelessWidget {
  const AdminAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> submissions = [
      {'student': 'John Doe', 'task': 'Case Study 1', 'date': '2026-08-14', 'status': 'Pending Review'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessments Review'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          itemCount: submissions.length,
          itemBuilder: (context, index) {
            final sub = submissions[index];
            return Card(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Task: ${sub['task']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    SizedBox(height: 8.h),
                    Text('Student: ${sub['student']}'),
                    Text('Submitted on: ${sub['date']}', style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text('Download Work'),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: CommonButton(
                            height: 40.h,
                            text: 'Grade',
                            onPressed: () {
                              _showGradeModal(context, sub);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showGradeModal(BuildContext context, Map<String, dynamic> submission) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24.w,
            right: 24.w,
            top: 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.r)),
                ),
              ),
              SizedBox(height: 24.h),
              Text('Assess Submission', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              Text('Student: ${submission['student']}', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Review Status',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                value: 'Graded',
                items: ['Pending', 'Graded', 'Reject'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Result',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                value: 'Pass',
                items: ['Pass', 'Fail'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(height: 16.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Score (optional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Reviewer Comment',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.allPrimaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text('Submit Assessment'),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }
}
