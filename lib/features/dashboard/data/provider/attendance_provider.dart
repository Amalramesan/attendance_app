import 'package:attendance_app/core/network/api_exception.dart';
import 'package:attendance_app/features/dashboard/data/data_source/attendance_api_service.dart';
import 'package:attendance_app/features/dashboard/data/models/attendance_status_response_model.dart';
import 'package:dio/dio.dart';
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
      if (e is DioException) {
        errorMessage = ApiException.fromDioException(e).message;
      } else {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}