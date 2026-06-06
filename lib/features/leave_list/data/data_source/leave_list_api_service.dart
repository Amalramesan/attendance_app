import 'package:attendance_app/core/network/api_constants.dart';
import 'package:attendance_app/core/network/dio_client.dart';
import 'package:attendance_app/features/leave_list/data/model/leave_list_response_model.dart';



class LeaveListApiService {
  final DioClient _dioClient = DioClient();

  Future<LeaveListResponse> getLeaves({
    required int employeeId,
    required String leaveType,
    required String month,
  }) async {
    final response = await _dioClient.dio.post(
      ApiConstants.leaveList,
      data: {
        "employee_id": employeeId,
        "leave_type": leaveType,
        "month": month,
      },
    );

    return LeaveListResponse.fromJson(
      response.data,
    );
  }
}