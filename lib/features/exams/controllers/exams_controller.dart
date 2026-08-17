import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/test_repository.dart';
import '../screens/take_exam_screen.dart';

class ExamsController extends GetxController {
  final TestRepository _repository = TestRepository();
  
  var isLoading = false.obs;
  var exams = <dynamic>[].obs;
  var currentExam = Rxn<Map<String, dynamic>>();

  // Exam Taking State
  var currentQuestionIndex = 0.obs;
  var selectedAnswers = <int, String>{}.obs;
  var remainingSeconds = 1800.obs; // 30 minutes default
  Timer? _timer;

  final List<Map<String, dynamic>> mockQuestions = [
    {
      'id': 1,
      'question': 'What is the primary purpose of supply chain management?',
      'options': ['Increase cost', 'Maximize customer value', 'Reduce employee count', 'Slow down production'],
      'answer': 'Maximize customer value'
    },
    {
      'id': 2,
      'question': 'Which of the following is NOT a phase of project management?',
      'options': ['Initiation', 'Planning', 'Execution', 'Procrastination'],
      'answer': 'Procrastination'
    },
    {
      'id': 3,
      'question': 'In accounting, what does ROI stand for?',
      'options': ['Return On Investment', 'Rate Of Inflation', 'Return On Inventory', 'Risk Of Investment'],
      'answer': 'Return On Investment'
    },
  ];

  @override
  void onInit() {
    super.onInit();
    fetchExams();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> fetchExams() async {
    isLoading(true);
    final data = await _repository.getTests();
    if (data != null) {
      exams.assignAll(data);
    } else {
      EasyLoading.showError('Failed to load exams');
    }
    isLoading(false);
  }

  Future<void> startExam(int examId) async {
    EasyLoading.show(status: 'Starting exam...');
    final success = await _repository.startStudentTest(examId);
    if (success) {
      EasyLoading.dismiss();
      _initializeExamState(examId);
      Get.to(() => const TakeExamScreen());
    } else {
      EasyLoading.showError('Failed to start exam');
    }
  }

  void _initializeExamState(int examId) {
    // Find exam details
    try {
      final exam = exams.firstWhere((e) => e['id']?.toString() == examId.toString());
      currentExam.value = Map<String, dynamic>.from(exam);
      // set timer based on minutes if available
      final minutes = int.tryParse(exam['minutes']?.toString() ?? '30') ?? 30;
      remainingSeconds.value = minutes * 60;
    } catch (_) {
      remainingSeconds.value = 1800;
    }
    
    currentQuestionIndex.value = 0;
    selectedAnswers.clear();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        _timer?.cancel();
        // Auto-submit logic can be added here
        submitExamAnswers(123, Map<String, dynamic>.from(selectedAnswers.map((key, value) => MapEntry(key.toString(), value))));
      }
    });
  }

  void selectAnswer(int questionId, String answer) {
    selectedAnswers[questionId] = answer;
  }

  String get formattedTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> submitExamAnswers(int studentTestId, Map<String, dynamic> answers) async {
    _timer?.cancel();
    EasyLoading.show(status: 'Submitting...');
    final success = await _repository.submitTest(studentTestId, answers);
    if (success) {
      EasyLoading.showSuccess('Exam submitted successfully');
      Get.back(); // Navigate back to exams list
    } else {
      EasyLoading.showError('Failed to submit exam');
    }
  }
}
