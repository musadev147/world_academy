import 'package:dio/dio.dart';
import '../../networks/dio/dio.dart';
import '../../networks/endpoints.dart';
import 'package:flutter/foundation.dart';

class TestRepository {
  Future<List<dynamic>?> getTests() async {
    try {
      final response = await DioSingleton.instance.dio.get(
        Endpoints.tests(),
        options: Options(headers: {'Authorization': '48f2641e56d3ff1fa75d64a1137a6932'}),
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
      debugPrint('Get Tests Error: ${e.response?.data}');
    }
    return null;
  }

  Future<bool> startStudentTest(int testId) async {
    try {
      final response = await postHttp(Endpoints.startStudentTest(), {
        "test_id": testId
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      debugPrint('Start Test Error: ${e.response?.data}');
    }
    return false;
  }

  Future<bool> submitTest(int studentTestId, Map<String, dynamic> answers) async {
    try {
      // endpoints use PUT or POST for submit? Postman had PUT, but let's use post/put depending on standard.
      // Usually PUT or POST. We'll use POST or PUT based on endpoints.dart
      final response = await postHttp(Endpoints.submitTest(studentTestId), answers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      debugPrint('Submit Test Error: ${e.response?.data}');
    }
    return false;
  }

  Future<Map<String, dynamic>?> getTestResults(int testId) async {
    try {
      final response = await getHttp(Endpoints.testResults(testId));
      if (response.statusCode == 200) {
        return response.data['data'] ?? response.data;
      }
    } on DioException catch (e) {
      debugPrint('Get Test Results Error: ${e.response?.data}');
    }
    return null;
  }
}
