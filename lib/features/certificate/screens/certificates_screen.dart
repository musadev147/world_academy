import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> certificates = [
      {
        'title': 'Advanced Diploma in Supply Chain Management',
        'certificateName': 'Completion Certificate',
        'classRequired': 'Yes',
        'testRequired': 'Yes',
        'issueDate': '2026-08-10',
        'id': 'CERT-908123',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Certificates'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: certificates.isEmpty
            ? Center(
                child: Text('No certificates earned yet.'),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                itemCount: certificates.length,
                itemBuilder: (context, index) {
                  final cert = certificates[index];

                  return Card(
                    margin: EdgeInsets.only(bottom: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.workspace_premium, size: 40.r, color: Colors.amber),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cert['certificateName'],
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                    ),
                                    Text(
                                      cert['title'],
                                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Class Required: ${cert['classRequired']}',
                                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                              ),
                              Text(
                                'Test Required: ${cert['testRequired']}',
                                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Issued: ${cert['issueDate']}',
                                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                              ),
                              Text(
                                'ID: ${cert['id']}',
                                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: Icon(Icons.download, color: AppColors.allPrimaryColor),
                              label: Text('Download PDF', style: TextStyle(color: AppColors.allPrimaryColor)),
                              onPressed: () {
                                // Download Logic
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.allPrimaryColor),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              ),
                            ),
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
}
