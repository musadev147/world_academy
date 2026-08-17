import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_font_style.dart';
import '../controllers/schedule_controller.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});

  @override
  State<ClassScheduleScreen> createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  final ScheduleController _controller = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Premium background
      appBar: AppBar(
        title: Text('Class Schedule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white)),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_controller.schedules.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy_rounded, size: 80.r, color: Colors.grey.shade300),
                  SizedBox(height: 16.h),
                  Text('No upcoming schedules found.', style: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            itemCount: _controller.schedules.length,
            itemBuilder: (context, index) {
              final schedule = _controller.schedules[index];
              
              // Safe access with fallbacks for dynamic API data
              final String date = schedule['date']?.toString() ?? 'N/A';
              final String startTime = schedule['start_time']?.toString() ?? 'TBD';
              final String endTime = schedule['end_time']?.toString() ?? 'TBD';
              final String totalTime = schedule['total_time']?.toString() ?? 'N/A';
              final String moduleName = schedule['module_name'] ?? schedule['title'] ?? 'Unknown Module';
              final String trainer = schedule['trainer'] ?? schedule['instructor'] ?? 'TBD';
              final String status = schedule['status'] ?? 'Scheduled';
              
              final bool isCompleted = status.toLowerCase() == 'completed';
              final bool isScheduled = status.toLowerCase() == 'scheduled' || status.toLowerCase() == 'upcoming';

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
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: AppColors.allPrimaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.event_available_rounded, size: 18.r, color: AppColors.allPrimaryColor),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                date,
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.sp, color: Colors.black87),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: isCompleted ? Colors.green.shade50 : (isScheduled ? Colors.blue.shade50 : Colors.orange.shade50),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isCompleted ? Colors.green.shade200 : (isScheduled ? Colors.blue.shade200 : Colors.orange.shade200),
                              ),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color: isCompleted ? Colors.green.shade700 : (isScheduled ? Colors.blue.shade700 : Colors.orange.shade700),
                                fontWeight: FontWeight.w800,
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Divider(height: 1, color: Colors.grey.shade100),
                      ),
                      Text(
                        moduleName,
                        style: TextStyle(color: Colors.black87, fontSize: 13.sp, fontWeight: FontWeight.w800, height: 1.3),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoItem(Icons.access_time_rounded, '$startTime - $endTime'),
                          _buildInfoItem(Icons.hourglass_bottom_rounded, totalTime),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      _buildInfoItem(Icons.person_rounded, 'Trainer: $trainer'),
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
        Icon(icon, size: 14.r, color: Colors.grey.shade400),
        SizedBox(width: 6.w),
        Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 10.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
