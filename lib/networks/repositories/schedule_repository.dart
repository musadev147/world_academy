import 'package:dio/dio.dart';
import '../../networks/dio/dio.dart';
import '../../networks/endpoints.dart';
import 'package:flutter/foundation.dart';

class ScheduleRepository {
  Future<List<dynamic>?> getStudentLectures() async {
    try {
      final response = await getHttp(Endpoints.studentLecture());
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data['status'] == false) {
          debugPrint('API Error: ${data['error']}');
          return null;
        }
        dynamic result = data['data'] ?? data['records'] ?? data;
        if (result is List) {
          return result;
        }
        return null;
      }
    } on DioException catch (e) {
      debugPrint('Get Student Lectures Error: ${e.response?.data}');
    }
    return null;
  }
}
