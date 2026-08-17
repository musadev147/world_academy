import 'dart:developer';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '/networks/endpoints.dart';
import '../presentation/model/forgot_password_model.dart';

class PostForgotPasswordApi {
  static final PostForgotPasswordApi _singleton = PostForgotPasswordApi._internal();
  PostForgotPasswordApi._internal();
  static PostForgotPasswordApi get instance => _singleton;

  Future<ForgotPasswordModel> forgotPassword({
    required String phone,
  }) async {
    log("forgotPassword API: $phone");

    try {
      final data = {
        "phone_number": phone,
      };

      final response = await postHttp(Endpoints.forgotPassword(), data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ForgotPasswordModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      log("FORGOT PASSWORD API ERROR: $error");
      rethrow;
    }
  }
}
