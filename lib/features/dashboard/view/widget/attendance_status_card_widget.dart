import 'package:flutter/material.dart';

class AttendanceStatusCard extends StatelessWidget {
  final String shiftStartTime;
  final String attendanceStatus;
  final String? markInTime;
  final String? markOutTime;
  final VoidCallback onMarkIn;
  final VoidCallback onMarkOut;

  const AttendanceStatusCard({
    super.key,
    required this.attendanceStatus,
    required this.shiftStartTime,
    required this.onMarkIn,
    required this.onMarkOut,
    this.markInTime,
    this.markOutTime,
  });

  @override
  Widget build(BuildContext context) {
    if (attendanceStatus == 'not_marked_in') {
      return _buildMarkInCard();
    }

    if (attendanceStatus == 'marked_in') {
      return _buildMarkOutCard();
    }

    return _buildCompletedCard();
  }

  Widget _buildMarkInCard() {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Start Your Day!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "Your shift starts at $shiftStartTime",
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onMarkIn,
            style: _buttonStyle(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/logout.png', width: 18, height: 18),
                const SizedBox(width: 6),
                const Text("Mark In"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkOutCard() {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Work Started",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Checked In at ${markInTime ?? '--:--'}",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onMarkOut,
            style: _buttonStyle(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/markout.png', width: 18, height: 18),
                const SizedBox(width: 6),
                const Text("Mark Out"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCard() {
    return Container(
      height: 105,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: _cardDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Your Day Completed",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Started at ${markInTime ?? '--:--'}   Ended at ${markOutTime ?? '--:--'}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      gradient: const LinearGradient(
        colors: [Color(0xff042222), Color(0xff03624C)],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
  }
}
