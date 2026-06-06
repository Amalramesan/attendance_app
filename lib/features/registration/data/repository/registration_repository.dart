import 'package:attendance_app/features/registration/data/data_sources/registration_api_service.dart';
import 'package:attendance_app/features/registration/data/model/registration_response_model.dart';


class RegistrationRepository {
  final RegistrationApiService apiService;

  RegistrationRepository(this.apiService);

  Future<RegistrationResponseModel> register({
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
    final response = await apiService.register(
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

    return RegistrationResponseModel.fromJson(
      response.data,
    );
  }
}