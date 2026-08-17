import 'package:dio/dio.dart';
import '../../networks/dio/dio.dart';
import '../../networks/endpoints.dart';
import 'package:flutter/foundation.dart';

class MenuRepository {
  Future<List<dynamic>?> getMenus() async {
    try {
      final response = await getHttp(Endpoints.menus());
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
      debugPrint('Get Menus Error: ${e.response?.data}');
    }
    return null;
  }
}
