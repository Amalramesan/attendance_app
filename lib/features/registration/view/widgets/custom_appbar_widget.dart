import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack ?? () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}