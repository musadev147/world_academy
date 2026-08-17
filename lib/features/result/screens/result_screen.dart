import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> results = [
      {
        'assessmentName': 'PGDHRM-Exam-1: Talent Acquisition (Unit-1)',
        'allotedScore': '100',
        'written': '38',
        'mcq': '14',
        'assignment': '17',
        'totalMarks': '69',
        'remarks': 'Passed',
      },
      {
        'assessmentName': 'PGDHRM-Exam-2: HR Business Partnering (Unit-2)',
        'allotedScore': '100',
        'written': '36',
        'mcq': '30',
        'assignment': '16',
        'totalMarks': '82',
        'remarks': 'Passed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            final isPassed = result['remarks'] == 'Passed';

            return Card(
              margin: EdgeInsets.only(bottom: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            result['assessmentName'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isPassed ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            result['remarks'],
                            style: TextStyle(
                              color: isPassed ? Colors.green : Colors.red,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildResultDetail('Alloted', result['allotedScore']),
                        _buildResultDetail('Written', result['written']),
                        _buildResultDetail('MCQ', result['mcq']),
                        _buildResultDetail('Assign.', result['assignment']),
                        _buildResultDetail('Total', result['totalMarks'], isHighlight: true),
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

  Widget _buildResultDetail(String label, String value, {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isHighlight ? 16.sp : 14.sp,
            color: isHighlight ? AppColors.allPrimaryColor : Colors.black87,
          ),
        ),
      ],
    );
  }
}
