import 'package:dio/dio.dart';
import '../../networks/dio/dio.dart';
import '../../networks/endpoints.dart';
import 'package:flutter/foundation.dart';

class CourseRepository {
  Future<List<dynamic>?> getCourses() async {
    try {
      final response = await getHttp(Endpoints.courses());
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
      debugPrint('Get Courses Error: ${e.response?.data}');
    }
    return null;
  }

  Future<List<dynamic>?> getCurrentCourses() async {
    try {
      final response = await getHttp(Endpoints.currentCourses());
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
      debugPrint('Get Current Courses Error: ${e.response?.data}');
    }
    return null;
  }

  Future<List<dynamic>?> searchCourses(String query) async {
    try {
      final response = await postHttp(Endpoints.searchCourses(), {
        "searchItem": query,
      });
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
      debugPrint('Search Courses Error: ${e.response?.data}');
    }
    return null;
  }
}
