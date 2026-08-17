import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class AdminEnrollmentScreen extends StatelessWidget {
  const AdminEnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enrollment Management'),
          backgroundColor: AppColors.allPrimaryColor,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _buildEnrollmentList(isPending: true),
              _buildEnrollmentList(isPending: false),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showEnrollmentForm(context);
          },
          backgroundColor: AppColors.allPrimaryColor,
          icon: Icon(Icons.add, color: Colors.white),
          label: Text('Enroll Student', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  void _showEnrollmentForm(BuildContext context) {
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
              Text('Enroll Student', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Select Student (Search by Name/ID)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Program/Course',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                items: ['Advanced Diploma in SCM', 'PG Diploma in HR'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
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
                  child: Text('Confirm Enrollment'),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEnrollmentList({required bool isPending}) {
    // Mock Data
    final List<Map<String, dynamic>> enrollments = [
      {'name': 'John Doe', 'course': 'Advanced Diploma in SCM', 'date': '2026-08-10'},
      {'name': 'Jane Smith', 'course': 'Post Graduate Diploma in HR', 'date': '2026-08-12'},
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      itemCount: enrollments.length,
      itemBuilder: (context, index) {
        final enrollment = enrollments[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12.h),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(enrollment['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                SizedBox(height: 4.h),
                Text(enrollment['course'], style: TextStyle(color: Colors.grey.shade800)),
                SizedBox(height: 4.h),
                Text('Requested: ${enrollment['date']}', style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                if (isPending) ...[
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Reject', style: TextStyle(color: Colors.red)),
                      ),
                      SizedBox(width: 8.w),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: Text('Approve', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
