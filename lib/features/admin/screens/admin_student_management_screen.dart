import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class AdminStudentManagementScreen extends StatelessWidget {
  const AdminStudentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> students = [
      {'name': 'John Doe', 'id': 'WA-2026-001', 'course': 'Adv. Diploma in SCM', 'status': 'Active'},
      {'name': 'Jane Smith', 'id': 'WA-2026-002', 'course': 'PG Diploma in HR', 'status': 'Inactive'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by Name or ID...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.allPrimaryColor.withOpacity(0.1),
                        child: Icon(Icons.person, color: AppColors.allPrimaryColor),
                      ),
                      title: Text(student['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${student['id']}'),
                          Text(student['course'], style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                        ],
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: student['status'] == 'Active' ? Colors.green.shade100 : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          student['status'],
                          style: TextStyle(color: student['status'] == 'Active' ? Colors.green : Colors.red, fontSize: 12.sp),
                        ),
                      ),
                      onTap: () {
                        _showStudentProfile(context, student);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStudentProfile(BuildContext context, Map<String, dynamic> student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(24.w),
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
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.allPrimaryColor.withOpacity(0.1),
                    child: Icon(Icons.person, color: AppColors.allPrimaryColor, size: 30.r),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(student['name'], style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        Text('Reg ID: ${student['id']}', style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _buildProfileDetail('Email', '${student['name'].toString().toLowerCase().replaceAll(' ', '.')}@example.com'),
              _buildProfileDetail('Phone', '+1 234 567 8900'),
              _buildProfileDetail('Enrolled Program', student['course']),
              _buildProfileDetail('Progress', '65% Completed'),
              _buildProfileDetail('Status', student['status']),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.allPrimaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(label, style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          ),
          Expanded(
            child: Text(value, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
