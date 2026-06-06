import 'package:attendance_app/core/network/api_constants.dart';
import 'package:attendance_app/core/network/dio_client.dart';
import 'package:attendance_app/features/dashboard/data/models/attendance_status_response_model.dart';



class AttendanceApiService {
  final DioClient _dioClient = DioClient();

  Future<AttendanceStatusResponse>
  getAttendanceStatus() async {
    try {
      final response = await _dioClient.dio.get(
        ApiConstants.attendanceStatus,
      );

      return AttendanceStatusResponse.fromJson(
        response.data,
      );
    } catch (e) {
      throw Exception(
        'Failed to fetch attendance status: $e',
      );
    }
  }
}