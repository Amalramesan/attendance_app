import 'dart:developer';
import 'package:attendance_app/core/network/api_constants.dart';
import 'package:dio/dio.dart';

class RegistrationApiService {
  final Dio dio;

  RegistrationApiService(this.dio);

  Future<Response> register({
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
    final response = await dio.post(
      ApiConstants.register,
      data: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "address": address,
        "dob": dob,
        "mobile_number": mobileNumber,
        "doj": doj,
        "location": location,
      },
    );

    log("Status Code: ${response.statusCode}");
    log("Response: ${response.data}");

    return response;
  }
}
