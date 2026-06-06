class AttendanceMarkResponse {
  final bool status;
  final String message;

  AttendanceMarkResponse({
    required this.status,
    required this.message,
  });

  factory AttendanceMarkResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AttendanceMarkResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}