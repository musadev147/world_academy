import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white),
        ),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactCard(),
            SizedBox(height: 32.h),
            Text(
              'Frequently Asked Questions',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp, color: Colors.black87),
            ),
            SizedBox(height: 16.h),
            _buildFAQItem('How do I reset my password?', 'You can reset your password by going to Profile > Change Password, or tapping "Forgot Password" on the login screen.'),
            _buildFAQItem('Where can I find my course schedule?', 'Your course schedule is available in the Dashboard under the "Class Schedule" section.'),
            _buildFAQItem('How to download my certificate?', 'Once you complete a course, go to the "Certificates" section in the menu to view and download it.'),
            _buildFAQItem('What if I miss a live class?', 'All live classes are recorded. You can find the recordings in the "My Courses" section under the specific course.'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.allPrimaryColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(color: AppColors.allPrimaryColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.headset_mic_rounded, size: 48.r, color: Colors.white),
          SizedBox(height: 16.h),
          Text(
            'How can we help you?',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8.h),
          Text(
            'It looks like you have problems with our system. We are here to help you, so please get in touch with us.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, color: Colors.white.withOpacity(0.8), height: 1.5),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContactButton(Icons.chat_bubble_rounded, 'Chat'),
              _buildContactButton(Icons.email_rounded, 'Email'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.r, color: AppColors.allPrimaryColor),
          SizedBox(width: 8.w),
          Text(label, style: TextStyle(color: AppColors.allPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13.sp)),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.allPrimaryColor,
          collapsedIconColor: Colors.grey.shade400,
          title: Text(
            question,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp, color: Colors.black87),
          ),
          childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
          children: [
            Text(
              answer,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
