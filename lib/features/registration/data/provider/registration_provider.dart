import 'package:attendance_app/features/registration/data/repository/registration_repository.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  final RegistrationRepository repository;

  RegistrationProvider(this.repository);

  bool isLoading = false;

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
      notifyListeners();

      final response = await repository.register(
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

      return response.status;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}