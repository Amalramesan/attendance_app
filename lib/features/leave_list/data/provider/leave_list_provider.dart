import 'package:attendance_app/core/network/api_exception.dart';
import 'package:attendance_app/features/leave_list/data/model/leave_list_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data_source/leave_list_api_service.dart';

class LeaveListProvider extends ChangeNotifier {
  final LeaveListApiService _apiService = LeaveListApiService();

  bool isLoading = false;
  String? errorMessage;

  LeaveListResponse? response;

  Future<void> getLeaves({required int employeeId}) async {
    try {
      isLoading = true;
      errorMessage = null;

      notifyListeners();

      response = await _apiService.getLeaves(
        employeeId: employeeId,
        leaveType: 'all',
        month: '2026-06',
      );
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
