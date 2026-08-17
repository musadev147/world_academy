import 'package:dio/dio.dart';
import '../../networks/dio/dio.dart';
import '../../networks/endpoints.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await postHttp(Endpoints.login(), {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (e) {
      debugPrint('Login Error: ${e.response?.data}');
      return null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final response = await getHttp(Endpoints.profile());
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      debugPrint('Get Profile Error: ${e.response?.data}');
    }
    return null;
  }
}
