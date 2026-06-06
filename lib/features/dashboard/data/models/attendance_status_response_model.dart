class AttendanceStatusResponse {
  final bool status;
  final String message;
  final Attendance attendance;

  AttendanceStatusResponse({
    required this.status,
    required this.message,
    required this.attendance,
  });

  factory AttendanceStatusResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AttendanceStatusResponse(
      status: json['status'],
      message: json['message'],
      attendance: Attendance.fromJson(
        json['attendance'],
      ),
    );
  }
}

class Attendance {
  final String attendanceStatus;
  final String shiftStartTime;
  final String? markInTime;
  final String? markOutTime;

  Attendance({
    required this.attendanceStatus,
    required this.shiftStartTime,
    this.markInTime,
    this.markOutTime,
  });

  factory Attendance.fromJson(
    Map<String, dynamic> json,
  ) {
    return Attendance(
      attendanceStatus:
          json['attendance_status'] ?? '',
      shiftStartTime:
          json['shift_start_time'] ?? '',
      markInTime:
          json['mark_in_time'],
      markOutTime:
          json['mark_out_time'],
    );
  }
}