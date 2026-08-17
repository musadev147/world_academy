import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';
import '../../../common_wigdets/custom_textfiled.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Premium background
      appBar: AppBar(
        title: Text('Refer a Friend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white)),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(24.w),
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
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.allPrimaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.share_rounded, color: AppColors.allPrimaryColor, size: 48.r),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Referral Module',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'This is a placeholder shell. Detailed rules for referral tracking and rewards are pending confirmation from the client.',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.orange.shade100),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline_rounded, size: 18.r, color: Colors.orange.shade800),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Basic share action and code display below are for demonstration only.',
                              style: TextStyle(fontSize: 12.sp, color: Colors.orange.shade900, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Dummy Referral Code Display (As per requirements: "navigation entry and basic share action only")
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Code (Placeholder)', style: TextStyle(color: Colors.grey.shade500, fontSize: 11.sp, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4.h),
                        Text('WA-REF-0000', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.sp, color: AppColors.allPrimaryColor, letterSpacing: 1.2)),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.allPrimaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.copy_rounded, color: AppColors.allPrimaryColor, size: 20.r),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: CommonButton(
                  height: 44.h,
                  text: 'Share Link (Native Share)',
                  icon: Icon(Icons.ios_share_rounded, color: Colors.white, size: 18.r),
                  borderRadius: 16.r,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
