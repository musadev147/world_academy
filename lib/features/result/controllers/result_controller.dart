import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/test_repository.dart';

class ResultController extends GetxController {
  final TestRepository _repository = TestRepository();
  
  var isLoading = false.obs;
  var result = Rxn<Map<String, dynamic>>();

  Future<void> fetchTestResult(int testId) async {
    isLoading(true);
    final data = await _repository.getTestResults(testId);
    if (data != null) {
      result.value = data;
    } else {
      EasyLoading.showError('Failed to load result');
    }
    isLoading(false);
  }
}
