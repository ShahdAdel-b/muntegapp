import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddMethodButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AddMethodButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(13),
      onTap: onTap,
      child: DottedBorder(
        color: const Color(0xffCBD5E1),
        strokeWidth: 1,
        dashPattern: const [6, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(13),
        child: Container(
          height: 44,
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_rounded,
                color: Color(0xff087A45),
                size: 20,
              ),

              const SizedBox(width: 7),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff087A45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}