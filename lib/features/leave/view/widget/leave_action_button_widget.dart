import 'package:attendance_app/core/theams/app_colors.dart';
import 'package:flutter/material.dart';

class LeaveActionButtons extends StatelessWidget {
  final VoidCallback onApply;
  final VoidCallback onLeaveList;

  const LeaveActionButtons({
    super.key,
    required this.onApply,
    required this.onLeaveList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [
                AppColors.gradientStart,
                AppColors.gradientEnd,
              ],
            ),
          ),
          child: ElevatedButton(
            onPressed: onApply,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 42),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              "Apply",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onLeaveList,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 42),
              padding: EdgeInsets.zero,
              side: const BorderSide(
                color: Color(0xff083C3A),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              "Leave List",
              style: TextStyle(
                color: Color(0xff083C3A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}