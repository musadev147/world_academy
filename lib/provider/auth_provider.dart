import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../networks/dio/dio.dart';
import '../networks/endpoints.dart';
import '../helpers/di.dart';
import '../constants/app_constants.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// Login via API
  Future<bool> login({
    required String phone,
  }) async {
    setLoading(true);
    try {
      final response = await postHttp(Endpoints.signIn(), {
        "phone_number": phone,
      });

      setLoading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success sending OTP
        return true;
      }
      return false;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  /// Register via API
  Future<bool> registerUser({
    required String phoneNumber,
    required String fullName,
    required String dateOfBirth,
    required int role,
    required String password,
    required String confirmPassword,
    required String nidNumber,
    File? profileImg,
    File? nidFrontImage,
    File? nidBackImage,
    File? birthCertificateImage,
  }) async {
    setLoading(true);
    try {
      Map<String, dynamic> data = {
        "phone_number": phoneNumber,
        "full_name": fullName,
        "date_of_birth": dateOfBirth,
        "role": role,
        "password": password,
        "confirm_password": confirmPassword,
        "nid_number": nidNumber,
      };

      if (profileImg != null) {
        data["profile_img"] = await MultipartFile.fromFile(profileImg.path);
      }
      if (nidFrontImage != null) {
        data["nid_front_image"] = await MultipartFile.fromFile(nidFrontImage.path);
      }
      if (nidBackImage != null) {
        data["nid_back_image"] = await MultipartFile.fromFile(nidBackImage.path);
      }
      if (birthCertificateImage != null) {
        data["birth_certificate_image"] = await MultipartFile.fromFile(birthCertificateImage.path);
      }

      FormData formData = FormData.fromMap(data);

      final response = await DioSingleton.instance.dio.post(
        Endpoints.register(),
        data: formData,
        cancelToken: DioSingleton.cancelToken,
      );

      setLoading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  /// Verify OTP via API
  Future<bool> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    setLoading(true);
    try {
      final response = await postHttp(Endpoints.loginVerifyOtp(), {
        "phone_number": phone,
        "otp": otp,
      });

      setLoading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // You can extract and save access_token and user info here
        return true;
      }
      return false;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }
}
