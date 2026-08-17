import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/schedule_repository.dart';

class ScheduleController extends GetxController {
  final ScheduleRepository _repository = ScheduleRepository();
  
  var isLoading = false.obs;
  var schedules = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    isLoading(true);
    final data = await _repository.getStudentLectures();
    if (data != null) {
      schedules.assignAll(data);
    } else {
      EasyLoading.showError('Failed to load schedules');
    }
    isLoading(false);
  }
}
