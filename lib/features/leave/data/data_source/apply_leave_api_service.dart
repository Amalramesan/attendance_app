import 'package:attendance_app/core/network/api_constants.dart';
import 'package:attendance_app/core/network/dio_client.dart';

import '../model/apply_leave_response_model.dart';

class ApplyLeaveApiService {
  final DioClient _dioClient = DioClient();

  Future<ApplyLeaveResponse> applyLeave({
    required String leaveMode,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reason,
    required int userId,
  }) async {
    final response = await _dioClient.dio.post(
      ApiConstants.applyLeave,
      data: {
        "leave_mode": leaveMode,
        "leave_type": leaveType,
        "start_date": startDate,
        "end_date": endDate,
        "reason": reason,
        "user_id": userId,
      },
    );

    return ApplyLeaveResponse.fromJson(
      response.data,
    );
  }
}