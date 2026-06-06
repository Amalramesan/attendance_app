import 'package:attendance_app/features/dashboard/data/data_source/attendance_mark_api_service.dart';
import 'package:attendance_app/features/dashboard/data/models/attendance_mark_response.dart';
import 'package:flutter/material.dart';



class AttendanceMarkProvider
    extends ChangeNotifier {
  final AttendanceMarkApiService _apiService =
      AttendanceMarkApiService();

  bool isLoading = false;

  AttendanceMarkResponse?
  attendanceMarkResponse;

  Future<bool> markAttendance({
    required int attendanceStatus,
    required String latitude,
    required String longitude,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      attendanceMarkResponse =
          await _apiService.markAttendance(
            attendanceStatus:
                attendanceStatus,
            latitude: latitude,
            longitude: longitude,
          );

      return attendanceMarkResponse!
          .status;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}