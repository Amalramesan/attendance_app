class RegistrationResponseModel {
  final bool status;
  final String message;

  RegistrationResponseModel({
    required this.status,
    required this.message,
  });

  factory RegistrationResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return RegistrationResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }
}