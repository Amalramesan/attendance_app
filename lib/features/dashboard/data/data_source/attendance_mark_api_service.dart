import 'package:attendance_app/core/network/api_constants.dart';
import 'package:attendance_app/core/network/dio_client.dart';
import 'package:attendance_app/features/dashboard/data/models/attendance_mark_response.dart';


class AttendanceMarkApiService {
  final DioClient _dioClient = DioClient();

  Future<AttendanceMarkResponse> markAttendance({
    required int attendanceStatus,
    required String latitude,
    required String longitude,
  }) async {
    final response = await _dioClient.dio.post(
      ApiConstants.attendanceMark,
      data: {
        "attendance_status": attendanceStatus,
        "latitude": latitude,
        "longitude": longitude,
      },
    );

    return AttendanceMarkResponse.fromJson(
      response.data,
    );
  }
}