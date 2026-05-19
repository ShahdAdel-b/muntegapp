import 'package:flutter/material.dart';

class ProductOptionCard extends StatelessWidget {
  final bool selected;
  final String title;
  final IconData icon;
  final Color primaryColor;
  final VoidCallback onTap;

  const ProductOptionCard({
    super.key,
    required this.selected,
    required this.title,
    required this.icon,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? primaryColor.withOpacity(.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? primaryColor : const Color(0xffE5E7EB),
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 42,
                    color: selected ? primaryColor : const Color(0xffCBD5E1),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: selected ? primaryColor : const Color(0xff374151),
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: primaryColor,
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}