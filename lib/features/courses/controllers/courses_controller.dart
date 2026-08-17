import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/course_repository.dart';

class CoursesController extends GetxController {
  final CourseRepository _repository = CourseRepository();
  
  var isLoading = false.obs;
  var courses = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentCourses();
  }

  Future<void> fetchCurrentCourses() async {
    isLoading(true);
    final data = await _repository.getCurrentCourses();
    if (data != null) {
      courses.assignAll(data);
    } else {
      EasyLoading.showError('Failed to load courses');
    }
    isLoading(false);
  }

  Future<void> searchCourses(String query) async {
    if (query.isEmpty) {
      fetchCurrentCourses();
      return;
    }
    isLoading(true);
    final data = await _repository.searchCourses(query);
    if (data != null) {
      courses.assignAll(data);
    }
    isLoading(false);
  }
}
