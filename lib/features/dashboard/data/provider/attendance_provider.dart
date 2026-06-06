import 'package:attendance_app/features/dashboard/data/data_source/attendance_api_service.dart';
import 'package:attendance_app/features/dashboard/data/models/attendance_status_response_model.dart';
import 'package:flutter/material.dart';


class AttendanceProvider
    extends ChangeNotifier {
  final AttendanceApiService _apiService =
      AttendanceApiService();

  bool isLoading = false;

  AttendanceStatusResponse?
  attendanceStatusResponse;

  String? errorMessage;

  Future<void> fetchAttendanceStatus() async {
    try {
      isLoading = true;
      errorMessage = null;

      notifyListeners();

      attendanceStatusResponse =
          await _apiService
              .getAttendanceStatus();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}