import 'package:attendance_app/core/network/api_constants.dart';
import 'package:attendance_app/core/network/dio_client.dart';

import '../model/login_response_model.dart';

class LoginApiService {
  final DioClient _dioClient = DioClient();

  Future<LoginResponse> login({
    required String mobileNumber,
    required String password,
  }) async {
    final response = await _dioClient.dio.post(
      ApiConstants.login,
      data: {
        "mobile_number": mobileNumber,
        "password": password,
      },
    );

    return LoginResponse.fromJson(response.data);
  }
}