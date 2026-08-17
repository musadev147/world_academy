import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../common_wigdets/common_button.dart';
import '../controllers/exams_controller.dart';

class TakeExamScreen extends StatefulWidget {
  const TakeExamScreen({super.key});

  @override
  State<TakeExamScreen> createState() => _TakeExamScreenState();
}

class _TakeExamScreenState extends State<TakeExamScreen> {
  final ExamsController _controller = Get.find<ExamsController>();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_controller.currentQuestionIndex.value < _controller.mockQuestions.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      _controller.currentQuestionIndex.value++;
    }
  }

  void _previousPage() {
    if (_controller.currentQuestionIndex.value > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      _controller.currentQuestionIndex.value--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              _controller.currentExam.value?['name'] ?? 'Exam in Progress',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white),
            ),
            SizedBox(height: 2.h),
            Obx(() => Text(
                  'Time Remaining: ${_controller.formattedTime}',
                  style: TextStyle(fontSize: 12.sp, color: Colors.red.shade100, fontWeight: FontWeight.w600),
                )),
          ],
        ),
        backgroundColor: AppColors.allPrimaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            _showExitDialog(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressIndicator(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe to force using buttons
                itemCount: _controller.mockQuestions.length,
                itemBuilder: (context, index) {
                  final question = _controller.mockQuestions[index];
                  return _buildQuestionCard(question, index);
                },
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Obx(() {
      final progress = (_controller.currentQuestionIndex.value + 1) / _controller.mockQuestions.length;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        color: Colors.white,
        child: Row(
          children: [
            Text(
              'Question ${_controller.currentQuestionIndex.value + 1} of ${_controller.mockQuestions.length}',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.sp, color: Colors.black87),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8.h,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.allPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildQuestionCard(Map<String, dynamic> question, int index) {
    final List<String> options = List<String>.from(question['options']);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Text(
              question['question'],
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1.5, color: Colors.black87),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Choose your answer:',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
          ),
          SizedBox(height: 12.h),
          Obx(() {
            final selectedOption = _controller.selectedAnswers[question['id']];
            return Column(
              children: options.map((option) {
                final isSelected = selectedOption == option;
                return GestureDetector(
                  onTap: () {
                    _controller.selectAnswer(question['id'], option);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.allPrimaryColor.withOpacity(0.05) : Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected ? AppColors.allPrimaryColor : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: AppColors.allPrimaryColor.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24.r,
                          height: 24.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.allPrimaryColor : Colors.grey.shade300,
                              width: 2,
                            ),
                            color: isSelected ? AppColors.allPrimaryColor : Colors.transparent,
                          ),
                          child: isSelected
                              ? Icon(Icons.circle, size: 10.r, color: Colors.white)
                              : null,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? AppColors.allPrimaryColor : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, -5)),
        ],
      ),
      child: Obx(() {
        final isFirst = _controller.currentQuestionIndex.value == 0;
        final isLast = _controller.currentQuestionIndex.value == _controller.mockQuestions.length - 1;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isFirst)
              Expanded(
                child: CommonButton(
                  height: 48.h,
                  text: 'Previous',
                  backgroundColor: Colors.grey.shade100,
                  textColor: Colors.black87,
                  borderRadius: 16.r,
                  onPressed: _previousPage,
                ),
              )
            else
              const Spacer(),
            SizedBox(width: 16.w),
            if (!isLast)
              Expanded(
                child: CommonButton(
                  height: 48.h,
                  text: 'Next',
                  borderRadius: 16.r,
                  onPressed: _nextPage,
                ),
              )
            else
              Expanded(
                child: CommonButton(
                  height: 48.h,
                  text: 'Submit Exam',
                  backgroundColor: Colors.green.shade600,
                  borderRadius: 16.r,
                  icon: Icon(Icons.check_circle_rounded, color: Colors.white, size: 18.r),
                  onPressed: () {
                    _showSubmitDialog(context);
                  },
                ),
              ),
          ],
        );
      }),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text('Exit Exam?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        content: Text('Are you sure you want to exit? Your progress might be lost.', style: TextStyle(fontSize: 14.sp)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // close dialog
              Get.back(); // close exam screen
            },
            child: const Text('Exit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSubmitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text('Submit Exam?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        content: Text('Are you sure you want to submit your answers? You cannot change them after submission.', style: TextStyle(fontSize: 14.sp)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            onPressed: () {
              Get.back(); // close dialog
              _controller.submitExamAnswers(123, Map<String, dynamic>.from(_controller.selectedAnswers.map((key, value) => MapEntry(key.toString(), value)))); // 123 is mock student_test_id
            },
            child: const Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
