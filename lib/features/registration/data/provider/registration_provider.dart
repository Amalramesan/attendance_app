import 'package:attendance_app/core/network/api_exception.dart';
import 'package:attendance_app/features/registration/data/model/registration_response_model.dart';
import 'package:attendance_app/features/registration/data/repository/registration_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  final RegistrationRepository repository;

  RegistrationProvider(this.repository);

  bool isLoading = false;
  String? errorMessage;
  RegistrationResponseModel? registrationResponse;

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String address,
    required String dob,
    required String mobileNumber,
    required String doj,
    required String location,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      registrationResponse = null;
      notifyListeners();

      registrationResponse = await repository.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        address: address,
        dob: dob,
        mobileNumber: mobileNumber,
        doj: doj,
        location: location,
      );

      return registrationResponse!.status;
    } catch (e) {
      if (e is DioException) {
        errorMessage = ApiException.fromDioException(e).message;
      } else {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}