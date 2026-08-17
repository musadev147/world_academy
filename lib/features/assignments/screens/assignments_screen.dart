import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';
import '../../../route/app_pages.dart';
import '../controllers/assignments_controller.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  final AssignmentsController _controller = Get.put(AssignmentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Premium background
      appBar: AppBar(
        title: Text(
          'Assignments',
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
          if (_controller.assignments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_turned_in, size: 80.r, color: Colors.grey.shade300),
                  SizedBox(height: 16.h),
                  Text('No assignments found.', style: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            itemCount: _controller.assignments.length,
            itemBuilder: (context, index) {
              final assignment = _controller.assignments[index];
              final bool hasSubmission = assignment['has_submission'] == true;
              final Map<String, dynamic>? submission = assignment['submission'];
              
              final String title = assignment['title'] ?? 'Unknown Assignment';
              final String courseName = assignment['course_name'] ?? 'Unknown Course';
              final String statusString = hasSubmission ? 'Submitted' : 'Pending';
              
              // Handle due date (Fixed string interpolation bug)
              String dueDateStr = 'N/A';
              if (assignment['due_date'] != null) {
                try {
                  final int timestamp = int.parse(assignment['due_date'].toString());
                  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
                  dueDateStr = '${date.day}/${date.month}/${date.year}';
                } catch (e) {
                  dueDateStr = assignment['due_date'].toString();
                }
              }

              // Submission details
              final String submittedOn = submission?['created_at']?.toString() ?? 'N/A';
              final String? grade = submission?['grade']?.toString();
              final bool isGraded = grade != null && grade.isNotEmpty && grade != 'null';
              final String reviewStatus = isGraded ? 'Graded' : 'Pending';
              
              String passFail = 'N/A';
              bool isPass = false;
              if (isGraded) {
                final double? gradeVal = double.tryParse(grade);
                final double? passMark = double.tryParse(assignment['passmark']?.toString() ?? '0');
                if (gradeVal != null && passMark != null) {
                  isPass = gradeVal >= passMark;
                  passFail = isPass ? 'Pass' : 'Fail';
                }
              }
              final String comment = submission?['admin_comment']?.toString() ?? 'No comments from reviewer.';

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
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    childrenPadding: EdgeInsets.zero,
                    iconColor: AppColors.allPrimaryColor,
                    collapsedIconColor: Colors.grey.shade400,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: hasSubmission ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            hasSubmission ? Icons.check_circle_rounded : Icons.pending_actions_rounded,
                            size: 20.r,
                            color: hasSubmission ? Colors.green : Colors.orange.shade700,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.sp, color: Colors.black87, height: 1.3),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: hasSubmission ? Colors.green.shade50 : Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(color: hasSubmission ? Colors.green.shade200 : Colors.orange.shade200),
                                    ),
                                    child: Text(
                                      statusString,
                                      style: TextStyle(
                                        color: hasSubmission ? Colors.green.shade700 : Colors.orange.shade700,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today_rounded, size: 12.r, color: Colors.grey.shade400),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Text(
                                      'Due: $dueDateStr',
                                      style: TextStyle(color: Colors.grey.shade500, fontSize: 10.sp, fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: Colors.grey.shade100, height: 1),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Icon(Icons.book_rounded, size: 14.r, color: Colors.grey.shade400),
                                SizedBox(width: 8.w),
                                Expanded(child: Text('Course: $courseName', style: TextStyle(color: Colors.grey.shade700, fontSize: 12.sp, fontWeight: FontWeight.w600))),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            if (!hasSubmission) ...[
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: AppColors.allPrimaryColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(color: AppColors.allPrimaryColor.withOpacity(0.1)),
                                ),
                                child: Column(
                                  children: [
                                    Text('Task: Download the assignment file below, complete it, and upload your final submission.', style: TextStyle(fontSize: 12.sp, color: Colors.black87, height: 1.4)),
                                    SizedBox(height: 16.h),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.cloud_download_rounded, color: AppColors.allPrimaryColor, size: 18.r),
                                        label: Text('Download File', style: TextStyle(color: AppColors.allPrimaryColor, fontWeight: FontWeight.w700, fontSize: 12.sp)),
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(vertical: 12.h),
                                          side: BorderSide(color: AppColors.allPrimaryColor),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              CommonButton(
                                height: 44.h,
                                text: 'Upload Submission',
                                icon: Icon(Icons.upload_file_rounded, color: Colors.white, size: 18.r),
                                borderRadius: 16.r,
                                onPressed: () {
                                  // Upload logic
                                },
                              ),
                            ] else ...[
                              // Submission Details
                              Text('My Submission Details', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.sp, color: Colors.black87)),
                              SizedBox(height: 16.h),
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(color: Colors.grey.shade100),
                                ),
                                child: Column(
                                  children: [
                                    _buildDetailRow('Submitted On', submittedOn),
                                    Divider(color: Colors.grey.shade100, height: 24.h),
                                    _buildDetailRow('Review Status', reviewStatus, 
                                      valueColor: isGraded ? AppColors.allPrimaryColor : Colors.orange.shade700),
                                    if (isGraded) ...[
                                      Divider(color: Colors.grey.shade100, height: 24.h),
                                      _buildDetailRow('Result', passFail, 
                                        valueColor: isPass ? Colors.green : Colors.red),
                                    ],
                                  ],
                                ),
                              ),
                              if (isGraded) ...[
                                SizedBox(height: 16.h),
                                Text('Reviewer Comment:', style: TextStyle(color: Colors.grey.shade500, fontSize: 11.sp, fontWeight: FontWeight.w600)),
                                SizedBox(height: 8.h),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.allPrimaryColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Text('"$comment"', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black87, fontSize: 12.sp, height: 1.4)),
                                ),
                              ],
                              SizedBox(height: 20.h),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.cloud_download_rounded, color: AppColors.allPrimaryColor, size: 18.r),
                                  label: Text('Download My Submission', style: TextStyle(color: AppColors.allPrimaryColor, fontWeight: FontWeight.w700, fontSize: 12.sp)),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
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

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 11.sp, fontWeight: FontWeight.w600)),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value, 
            textAlign: TextAlign.end,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.sp, color: valueColor ?? Colors.black87),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

