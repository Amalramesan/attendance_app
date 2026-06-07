import 'package:attendance_app/core/theams/app_colors.dart';
import 'package:flutter/material.dart';

class RouteSearchField extends StatelessWidget {
  const RouteSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),

        suffixIcon: const Icon(Icons.close, color: AppColors.primary),

        contentPadding: const EdgeInsets.symmetric(vertical: 5),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
