import 'package:flutter/material.dart';

class DashboardMenuCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isPrimary;
  final VoidCallback onTap;
  final double iconSize;

  const DashboardMenuCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.isPrimary = false,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 130,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            gradient: isPrimary
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff042222),
                      Color(0xff03624C),
                    ],
                  )
                : null,

            color: isPrimary ? null : Colors.white,

            border: isPrimary
                ? null
                : Border.all(
                    color: const Color(0xffE0E0E0),
                  ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    isPrimary ? Colors.white : const Color(0xff042222),

                child: Image.asset(
                  imagePath,
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.contain,
                  color: isPrimary
                      ? const Color(0xff042222)
                      : Colors.white,
                ),
              ),

              const Spacer(),

              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isPrimary
                      ? Colors.white
                      : const Color(0xff042222),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}