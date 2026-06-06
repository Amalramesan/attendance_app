import 'package:attendance_app/features/leave_list/data/model/leave_list_response_model.dart';
import 'package:flutter/material.dart';

import '../data_source/leave_list_api_service.dart';

class LeaveListProvider extends ChangeNotifier {
  final LeaveListApiService _apiService = LeaveListApiService();

  bool isLoading = false;

  LeaveListResponse? response;

  Future<void> getLeaves({required int employeeId}) async {
    try {
      isLoading = true;

      notifyListeners();

      response = await _apiService.getLeaves(
        employeeId: employeeId,
        leaveType: 'all',
        month: '2026-06',
      );
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
