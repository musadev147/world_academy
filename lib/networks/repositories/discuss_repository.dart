import 'package:dio/dio.dart';
import '../../networks/dio/dio.dart';
import '../../networks/endpoints.dart';
import 'package:flutter/foundation.dart';

class DiscussRepository {
  Future<bool> sendSms(String to, String message) async {
    try {
      final response = await getHttp(Endpoints.sendSms(to, message));
      if (response.statusCode == 200) {
        // SMS Gateway returns plain text or JSON depending on config. We assume success if 200.
        return true;
      }
    } on DioException catch (e) {
      debugPrint('Send SMS Error: ${e.response?.data}');
    }
    return false;
  }
}
