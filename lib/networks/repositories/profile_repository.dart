import 'package:dio/dio.dart';
import '../../networks/dio/dio.dart';
import '../../networks/endpoints.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository {
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final response = await getHttp(Endpoints.profile());
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data['status'] == false) {
          debugPrint('API Error: ${data['error']}');
          return null;
        }
        return data['data'] ?? data['records'] ?? data;
      }
    } on DioException catch (e) {
      debugPrint('Get Profile Error: ${e.response?.data}');
    }
    return null;
  }

  Future<Map<String, dynamic>?> getDashboardGuideline() async {
    try {
      final response = await getHttp(Endpoints.dashboardGuideline());
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data['status'] == false) {
          debugPrint('API Error: ${data['error']}');
          return null;
        }
        return data['data'] ?? data['records'] ?? data;
      }
    } on DioException catch (e) {
      debugPrint('Get Dashboard Guideline Error: ${e.response?.data}');
    }
    return null;
  }
}
