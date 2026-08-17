import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/profile_repository.dart';

class DashboardController extends GetxController {
  final ProfileRepository _repository = ProfileRepository();
  
  var isLoading = false.obs;
  var dashboardGuideline = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchDashboardGuideline();
  }

  Future<void> fetchDashboardGuideline() async {
    isLoading(true);
    final data = await _repository.getDashboardGuideline();
    if (data != null) {
      dashboardGuideline.value = data;
    } else {
      // Optional: Handle error silently or show toast
    }
    isLoading(false);
  }
}
