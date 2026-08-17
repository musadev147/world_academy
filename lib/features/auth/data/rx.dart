import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common_wigdets/app_toast.dart';
import '../../../../networks/exception_handler/data_source.dart';
import '../../../../networks/rx_base.dart';
import '../presentation/model/forgot_password_model.dart';
import 'api.dart';

class PostForgotPasswordRx extends RxResponseInt<ForgotPasswordModel> {
  final api = PostForgotPasswordApi.instance;

  PostForgotPasswordRx({required super.empty, required super.dataFetcher});

  ValueStream<ForgotPasswordModel> get valueStreamData => dataFetcher.stream;

  Future<bool> forgotPasswordFunc({
    required String phone,
  }) async {
    try {
      await EasyLoading.show(status: "Sending OTP...");

      final data = await api.forgotPassword(phone: phone);

      await EasyLoading.dismiss();
      return await handleSuccessWithReturn(data);
    } catch (error) {
      await EasyLoading.dismiss();
      log("ForgotPasswordRx error: $error");
      return await handleErrorWithReturn(error);
    }
  }

  @override
  Future<bool> handleSuccessWithReturn(ForgotPasswordModel data) async {
    AppToast.success(data.message ?? "OTP sent successfully.");
    return true;
  }

  @override
  Future<bool> handleErrorWithReturn(error) async {
    String message = "Request failed";

    if (error is DioException) {
      final failure = ErrorHandler.handle(error).failure;
      message = failure.responseMessage;
    } else if (error is Exception) {
      message = error.toString().replaceFirst('Exception: ', '');
    }

    AppToast.error(message);
    return false;
  }
}
