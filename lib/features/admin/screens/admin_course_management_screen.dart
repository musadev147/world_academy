import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class AdminCourseManagementScreen extends StatelessWidget {
  const AdminCourseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> courses = [
      {'title': 'Advanced Diploma in SCM', 'status': 'Active'},
      {'title': 'Post Graduate Diploma in HR', 'status': 'Draft'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Management'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            final isActive = course['status'] == 'Active';

            return Card(
              margin: EdgeInsets.only(bottom: 12.h),
              child: ListTile(
                leading: Icon(Icons.school, color: AppColors.allPrimaryColor),
                title: Text(course['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Status: ${course['status']}'),
                trailing: Switch(
                  value: isActive,
                  activeColor: AppColors.allPrimaryColor,
                  onChanged: (val) {
                    // Toggle Status
                  },
                ),
                onTap: () {
                  _showEditCourseModal(context, course);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showEditCourseModal(BuildContext context, Map<String, dynamic> course) {
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
              Text('Edit Course', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              TextField(
                controller: TextEditingController(text: course['title']),
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                value: course['status'],
                items: ['Active', 'Draft', 'Archived'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (_) {},
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
                  child: Text('Save Changes'),
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
