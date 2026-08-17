import 'package:dio/dio.dart';
import '../../networks/dio/dio.dart';
import '../../networks/endpoints.dart';
import 'package:flutter/foundation.dart';

class AssignmentRepository {
  Future<List<dynamic>?> getAssignments() async {
    try {
      final response = await DioSingleton.instance.dio.get(
        Endpoints.assignments(),
        options: Options(headers: {'Authorization': '1f3f9806f693ac364ca188e845a75aa7'}),
      );
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
      debugPrint('Get Assignments Error: ${e.response?.data}');
    }
    return null;
  }

  Future<Map<String, dynamic>?> getAssignmentDetails(int id) async {
    try {
      final response = await getHttp(Endpoints.assignmentDetails(id));
      if (response.statusCode == 200) {
        return response.data['data'] ?? response.data;
      }
    } on DioException catch (e) {
      debugPrint('Get Assignment Details Error: ${e.response?.data}');
    }
    return null;
  }

  Future<bool> submitAssignment(FormData data) async {
    try {
      final response = await postHttp(Endpoints.submitAssignment(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      debugPrint('Submit Assignment Error: ${e.response?.data}');
    }
    return false;
  }
}
