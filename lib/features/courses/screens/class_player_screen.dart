import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/text_font_style.dart';
import '../../../route/app_pages.dart';
import '../../../common_wigdets/common_button.dart';

class ClassPlayerScreen extends StatefulWidget {
  const ClassPlayerScreen({super.key});

  @override
  State<ClassPlayerScreen> createState() => _ClassPlayerScreenState();
}

class _ClassPlayerScreenState extends State<ClassPlayerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 1: Intro to SCM'),
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              Get.toNamed(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: Routes.REFERENCE_BOOK, child: Text('Reference Book')),
                PopupMenuItem(value: Routes.CLASS_SCHEDULE, child: Text('Class Schedule')),
                PopupMenuItem(value: Routes.ASSIGNMENTS, child: Text('Assignments')),
                PopupMenuItem(value: Routes.EXAMS, child: Text('Exams')),
                PopupMenuItem(value: Routes.RESULT, child: Text('Results')),
                PopupMenuItem(value: Routes.PAYMENTS, child: Text('Payment History')),
                PopupMenuItem(value: Routes.CERTIFICATES, child: Text('Certificate')),
                PopupMenuItem(value: Routes.STUDENT_DASHBOARD, child: Text('Back to Dashboard')),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildVideoPlayerPlaceholder(),
            _buildActionButtons(),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.allPrimaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.allPrimaryColor,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Learning Tools'),
                Tab(text: 'Material'),
                Tab(text: 'Discuss'),
                Tab(text: 'Sample Q&A'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLearningToolsTab(),
                  _buildMaterialTab(),
                  _buildDiscussTab(),
                  _buildSampleQuestionTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerPlaceholder() {
    return Container(
      height: 220.h,
      width: double.infinity,
      color: Colors.black,
      child: Center(
        child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60.r),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.skip_previous, color: AppColors.allPrimaryColor),
            label: Text('Previous', style: TextStyle(color: AppColors.allPrimaryColor)),
          ),
          SizedBox(
            width: 150.w,
            child: CommonButton(
              text: 'Complete Lecture',
              height: 40.h,
              onPressed: () {
                // Proceed to next lecture
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningToolsTab() {
    return Center(
      child: Text(
        'Video details, transcript, or notes go here.',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildMaterialTab() {
    return ListView.builder(
      itemCount: 3,
      padding: EdgeInsets.all(16.w),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.picture_as_pdf, color: Colors.red),
          title: Text('Lecture Slide ${index + 1}'),
          trailing: Icon(Icons.download, color: AppColors.allPrimaryColor),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildDiscussTab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildChatBubble('Student', 'Could you explain the bullwhip effect again?', true),
                _buildChatBubble('Instructor', 'Sure, it refers to the amplification of demand variability...', false),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type your question...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              CircleAvatar(
                backgroundColor: AppColors.allPrimaryColor,
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String name, String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isMe ? AppColors.allPrimaryColor.withOpacity(0.1) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: AppColors.allPrimaryColor)),
            SizedBox(height: 4.h),
            Text(message, style: TextStyle(fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }

  Widget _buildSampleQuestionTab() {
    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.all(16.w),
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text('Sample Question ${index + 1}'),
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text('This is the detailed answer for the sample question to help you prepare for the exam.'),
            )
          ],
        );
      },
    );
  }
}
