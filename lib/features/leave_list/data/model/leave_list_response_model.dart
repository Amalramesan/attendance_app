class LeaveListResponse {
  final bool status;
  final List<LeaveItem> leaves;
  final String message;

  LeaveListResponse({
    required this.status,
    required this.leaves,
    required this.message,
  });

  factory LeaveListResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return LeaveListResponse(
      status: json['status'],
      message: json['message'],
      leaves:
          (json['sales_executive_leaves'] as List)
              .map(
                (e) => LeaveItem.fromJson(e),
              )
              .toList(),
    );
  }
}

class LeaveItem {
  final int id;
  final int userId;
  final String leaveMode;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;
  final int status;

  LeaveItem({
    required this.id,
    required this.userId,
    required this.leaveMode,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });

  factory LeaveItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return LeaveItem(
      id: json['id'],
      userId: json['user_id'],
      leaveMode: json['leave_mode'],
      leaveType: json['leave_type'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      reason: json['reason'],
      status: json['status'],
    );
  }
}