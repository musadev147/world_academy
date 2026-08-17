import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'New Assignment Uploaded',
        'message': 'A new assignment for Module 2 is now available.',
        'time': '2 hours ago',
        'isRead': false,
      },
      {
        'title': 'Live Class Reminder',
        'message': 'Your live class starts in 30 minutes.',
        'time': 'Yesterday',
        'isRead': true,
      },
      {
        'title': 'Special Offer on New Courses!',
        'message': 'Enroll now and get a 50% discount on all new IT programs.',
        'time': '2 days ago',
        'isRead': true,
        'imageUrl': 'https://via.placeholder.com/400x200.png?text=Promo+Banner',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            final isRead = notification['isRead'];

            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              tileColor: isRead ? null : AppColors.allPrimaryColor.withOpacity(0.05),
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.allPrimaryColor.withOpacity(0.1),
                    child: Icon(Icons.notifications, color: AppColors.allPrimaryColor),
                  ),
                  if (!isRead)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                ],
              ),
              title: Text(
                notification['title'],
                style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold, fontSize: 16.sp),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification['message'], style: TextStyle(fontSize: 14.sp)),
                    if (notification['imageUrl'] != null) ...[
                      SizedBox(height: 8.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          notification['imageUrl'],
                          width: double.infinity,
                          height: 120.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 120.h,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.image_not_supported, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 6.h),
                    Text(notification['time'], style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                  ],
                ),
              ),
              onTap: () {
                // Mark as read or navigate
              },
            );
          },
        ),
      ),
    );
  }
}
