import 'package:attendance_app/core/network/api_exception.dart';
import 'package:attendance_app/features/leave/data/data_source/apply_leave_api_service.dart';
import 'package:attendance_app/features/leave/data/model/apply_leave_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class ApplyLeaveProvider
    extends ChangeNotifier {
  final ApplyLeaveApiService _apiService =
      ApplyLeaveApiService();

  bool isLoading = false;
  String? errorMessage;

  ApplyLeaveResponse?
  applyLeaveResponse;

  Future<bool> applyLeave({
    required String leaveMode,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reason,
    required int userId,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      applyLeaveResponse = null;

      notifyListeners();

      applyLeaveResponse =
          await _apiService.applyLeave(
            leaveMode: leaveMode,
            leaveType: leaveType,
            startDate: startDate,
            endDate: endDate,
            reason: reason,
            userId: userId,
          );

      return applyLeaveResponse!.status;
    } catch (e) {
      if (e is DioException) {
        errorMessage = ApiException.fromDioException(e).message;
      } else {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
      return false;
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}