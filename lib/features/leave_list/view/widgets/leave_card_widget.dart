import 'package:attendance_app/core/theams/app_colors.dart';
import 'package:flutter/material.dart';

class LeaveCard extends StatelessWidget {
  final String leaveMode;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;
  final int status;

  const LeaveCard({
    super.key,
    required this.leaveMode,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderGrey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  leaveMode == 'full_day'
                      ? 'Full Day Application'
                      : 'Half Day Application',
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 15,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            startDate,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            leaveType.replaceAll('_', ' '),
            style: const TextStyle(
              color: AppColors.casualLeave,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              _step(
                iconColor: AppColors.success,
                icon: Icons.check,
                title: "Create",
              ),

              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),

              _step(
                iconColor: AppColors.success,
                icon: Icons.check,
                title: "Review",
              ),

              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ),

              _statusWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusWidget() {
    if (status == 1) {
      return _step(
        iconColor: AppColors.success,
        icon: Icons.check,
        title: "Approved",
      );
    }

    if (status == 2) {
      return _step(
        iconColor: AppColors.rejected,
        icon: Icons.close,
        title: "Rejected",
      );
    }

    return _step(
      iconColor: AppColors.pending,
      icon: Icons.remove,
      title: "Pending",
    );
  }

  Widget _step({
    required Color iconColor,
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: iconColor,
          child: Icon(
            icon,
            size: 10,
            color: AppColors.white,
          ),
        ),

        const SizedBox(width: 4),

        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}