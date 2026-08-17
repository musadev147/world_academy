import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/profile_repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository = ProfileRepository();
  
  var isLoading = false.obs;
  var profileData = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading(true);
    final data = await _repository.getProfile();
    if (data != null) {
      profileData.value = data;
    } else {
      EasyLoading.showError('Failed to load profile');
    }
    isLoading(false);
  }
}
