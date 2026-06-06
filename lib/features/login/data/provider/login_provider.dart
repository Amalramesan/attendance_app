import 'package:attendance_app/features/login/data/data_source/login_api_service.dart';
import 'package:attendance_app/features/login/data/model/login_response_model.dart';
import 'package:flutter/material.dart';


class LoginProvider extends ChangeNotifier {
  final LoginApiService _loginApiService = LoginApiService();

  bool isLoading = false;
  LoginResponse? loginResponse;
  String? errorMessage;

  Future<bool> login({
    required String mobileNumber,
    required String password,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      loginResponse = await _loginApiService.login(
        mobileNumber: mobileNumber,
        password: password,
      );

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}