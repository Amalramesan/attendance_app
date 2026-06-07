import 'package:flutter/material.dart';

class RecentActivityCard extends StatelessWidget {
  final String date;
  final String markInTime;
  final String markOutTime;

  const RecentActivityCard({
    super.key,
    required this.date,
    required this.markInTime,
    required this.markOutTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            backgroundImage: const AssetImage('assets/icons/recenticon.png'),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),

                const SizedBox(height: 4),

                Text(
                  _getAttendanceText(),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getAttendanceText() {
    final inTime = markInTime.trim();
    final outTime = markOutTime.trim();

    if (inTime == 'Not Marked' && outTime == 'Not Marked') {
      return 'No attendance marked yet';
    }

    if (inTime != 'Not Marked' && outTime == 'Not Marked') {
      return 'Marked in at $inTime';
    }

    return 'Marked in at $inTime | Marked out at $outTime';
  }
}
