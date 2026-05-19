import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool small;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: small ? 36 : 44,
          height: small ? 36 : 44,
          decoration: const BoxDecoration(
            color: Color(0xffEAF5EF),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xff087A45),
            size: small ? 18 : 22,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: small ? 14 : 16,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xff111827),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}