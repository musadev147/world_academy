import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';
import '../controllers/exams_controller.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({super.key});

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  final ExamsController _controller = Get.put(ExamsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Premium background
      appBar: AppBar(
        title: Text(
          'Exams',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white),
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
          if (_controller.exams.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_rounded, size: 80.r, color: Colors.grey.shade300),
                  SizedBox(height: 16.h),
                  Text('No exams found.', style: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            itemCount: _controller.exams.length,
            itemBuilder: (context, index) {
              final exam = _controller.exams[index];
              final canTake = exam['can_take'] == true;
              final String name = exam['name']?.toString() ?? 'Unknown Exam';
              final String date = exam['created_at']?.toString().split('T').first ?? 'N/A';
              final String duration = '${exam['minutes'] ?? 0} mins';
              final String questions = '${exam['number_of_questions'] ?? 0} Qs';
              final String attempts = '${exam['total_attempts'] ?? 0} Attempt(s)';
              final String passmark = 'Pass: ${double.tryParse(exam['passmark']?.toString() ?? '0')?.toStringAsFixed(0) ?? '0'}%';

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
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.sp, height: 1.3, color: Colors.black87),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: canTake ? Colors.green.shade50 : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: canTake ? Colors.green.shade200 : Colors.red.shade200),
                            ),
                            child: Text(
                              canTake ? 'Available' : 'Closed',
                              style: TextStyle(
                                color: canTake ? Colors.green.shade700 : Colors.red.shade700,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w800,
                              ),
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
                          Text(
                            'Added: $date',
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 10.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 20.w),
                          Icon(Icons.timer_rounded, size: 14.r, color: Colors.grey.shade400),
                          SizedBox(width: 6.w),
                          Text(
                            duration,
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 10.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoItem(Icons.help_outline_rounded, questions),
                          _buildInfoItem(Icons.repeat_rounded, attempts),
                          _buildInfoItem(Icons.verified_outlined, passmark),
                        ],
                      ),
                      if (canTake) ...[
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          child: CommonButton(
                            height: 44.h,
                            text: 'Start Exam',
                            icon: Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 18.r),
                            borderRadius: 16.r,
                            onPressed: () {
                              final int examId = int.tryParse(exam['id']?.toString() ?? '0') ?? 0;
                              if (examId > 0) {
                                _controller.startExam(examId);
                              }
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.r, color: AppColors.allPrimaryColor.withOpacity(0.6)),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(color: Colors.black87, fontSize: 11.sp, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
