import 'package:flutter/material.dart';
class ProfileSection extends StatelessWidget {
  final String location;

  const ProfileSection({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xff083C3A),
              width: 2,
            ),
          ),
          child: Image.asset(
            "assets/images/profile icon.png",
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          "Hi User",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          "Sales Executive",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),

        Text(
          "@$location",
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}