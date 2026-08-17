import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class YoutubeScreen extends StatelessWidget {
  const YoutubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final List<Map<String, dynamic>> channels = [
      {
        'title': 'World Academy Official',
        'subscribers': '15.2K Subscribers',
        'icon': Icons.business,
      },
      {
        'title': 'Supply Chain Masters',
        'subscribers': '8.5K Subscribers',
        'icon': Icons.local_shipping,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Channels'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          itemCount: channels.length,
          itemBuilder: (context, index) {
            final channel = channels[index];

            return Card(
              margin: EdgeInsets.only(bottom: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.w),
                leading: CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Colors.red.shade100,
                  child: Icon(channel['icon'], color: Colors.red),
                ),
                title: Text(
                  channel['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    channel['subscribers'],
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Open in-app browser or YouTube app
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  ),
                  child: Text('Visit'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
