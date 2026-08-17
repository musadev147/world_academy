import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/test_repository.dart';

class ExamsController extends GetxController {
  final TestRepository _repository = TestRepository();
  
  var isLoading = false.obs;
  var exams = <dynamic>[].obs;
  var currentExam = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchExams();
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
      EasyLoading.showSuccess('Exam started');
      // Navigate to take exam screen logic
    } else {
      EasyLoading.showError('Failed to start exam');
    }
  }

  Future<void> submitExamAnswers(int studentTestId, Map<String, dynamic> answers) async {
    EasyLoading.show(status: 'Submitting...');
    final success = await _repository.submitTest(studentTestId, answers);
    if (success) {
      EasyLoading.showSuccess('Exam submitted successfully');
      Get.back();
    } else {
      EasyLoading.showError('Failed to submit exam');
    }
  }
}
