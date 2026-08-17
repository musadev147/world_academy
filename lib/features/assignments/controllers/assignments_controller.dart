import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';
import '../../../networks/repositories/assignment_repository.dart';

class AssignmentsController extends GetxController {
  final AssignmentRepository _repository = AssignmentRepository();
  
  var isLoading = false.obs;
  var assignments = <dynamic>[].obs;
  var currentAssignment = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchAssignments();
  }

  Future<void> fetchAssignments() async {
    isLoading(true);
    final data = await _repository.getAssignments();
    if (data != null) {
      assignments.assignAll(data);
    } else {
      EasyLoading.showError('Failed to load assignments');
    }
    isLoading(false);
  }

  Future<void> fetchAssignmentDetails(int id) async {
    isLoading(true);
    final data = await _repository.getAssignmentDetails(id);
    if (data != null) {
      currentAssignment.value = data;
    } else {
      EasyLoading.showError('Failed to load details');
    }
    isLoading(false);
  }

  Future<void> submitAssignment(int assignmentId, String filePath) async {
    EasyLoading.show(status: 'Submitting...');
    try {
      String fileName = filePath.split('/').last;
      FormData formData = FormData.fromMap({
        "assignment_id": assignmentId,
        "file": await MultipartFile.fromFile(filePath, filename: fileName),
      });
      
      bool success = await _repository.submitAssignment(formData);
      if (success) {
        EasyLoading.showSuccess('Submitted successfully');
        fetchAssignments(); // Refresh list
      } else {
        EasyLoading.showError('Submission failed');
      }
    } catch (e) {
      EasyLoading.showError('An error occurred');
    }
  }
}
