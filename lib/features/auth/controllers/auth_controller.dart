import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/auth_repository.dart';
import '../../../networks/dio/dio.dart';
import '../../../route/app_pages.dart';
import '../../../helpers/di.dart';
import '../../../constants/app_constants.dart';

class AuthController extends GetxController {
  final AuthRepository _repository = AuthRepository();
  final emailController = TextEditingController(text: 'h.kabir01796010084@gmail.com');
  final passwordController = TextEditingController(text: '12345678');

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      EasyLoading.showError('Please enter email and password');
      return;
    }

    EasyLoading.show(status: 'Logging in...');
    final response = await _repository.login(email, password);

    if (response != null && response['status'] == true) {
      // Assuming response contains a token inside a 'data' map or directly
      // Postman collection didn't have response body, but standard is data['token']
      final token = response['data']?['token'] ?? response['token']; 
      if (token != null) {
        appData.write(kKeyAccessToken, token);
        DioSingleton.instance.update(token); // Update Dio headers with new token
      }
      
      EasyLoading.showSuccess('Login Successful');
      Get.offAllNamed(Routes.MAIN_NAVIGATION);
    } else {
      EasyLoading.showError(response?['message'] ?? 'Login failed. Please try again.');
    }
  }
}
