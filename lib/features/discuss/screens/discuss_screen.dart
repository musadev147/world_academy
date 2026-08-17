import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../controllers/discuss_controller.dart';

class DiscussScreen extends StatefulWidget {
  const DiscussScreen({super.key});

  @override
  State<DiscussScreen> createState() => _DiscussScreenState();
}

class _DiscussScreenState extends State<DiscussScreen> {
  final DiscussController _controller = Get.put(DiscussController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9), // Soft background
      appBar: AppBar(
        title: Text('Discuss', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white)),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  itemCount: _controller.discussions.length,
                  itemBuilder: (context, index) {
                    final discussion = _controller.discussions[index];

                    final isMe = discussion['author'] == 'Me';

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h, left: isMe ? 40.w : 0, right: isMe ? 0 : 40.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.allPrimaryColor.withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(16.r).copyWith(
                            bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
                            bottomLeft: !isMe ? Radius.zero : Radius.circular(16.r),
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                          ],
                          border: Border.all(color: isMe ? AppColors.allPrimaryColor.withOpacity(0.3) : Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  discussion['author'],
                                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.sp, color: isMe ? AppColors.allPrimaryColor : Colors.black87),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  discussion['time'],
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 10.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              discussion['content'],
                              style: TextStyle(fontSize: 14.sp, color: Colors.black87, height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller.messageController,
              decoration: InputDecoration(
                hintText: 'Start a discussion...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(color: AppColors.allPrimaryColor),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Obx(() {
            return InkWell(
              onTap: _controller.isSending.value ? null : _controller.sendSms,
              borderRadius: BorderRadius.circular(24.r),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.allPrimaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: AppColors.allPrimaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: _controller.isSending.value
                    ? SizedBox(width: 20.r, height: 20.r, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Icon(Icons.send_rounded, color: Colors.white, size: 20.r),
              ),
            );
          }),
        ],
      ),
    );
  }
}
