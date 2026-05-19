import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSelector extends StatelessWidget {
  final int selectedFont;
  final Function(int index) onChanged;
  final Color primaryColor;
  final Color textColor;

  const FontSelector({
    super.key,
    required this.selectedFont,
    required this.onChanged,
    required this.primaryColor,
    required this.textColor,
  });

  static final List<String> fonts = [
    "Noto Sans Arabic",
    "Tajawal",
    "Almarai",
    "Amiri",
    "Changa",
    "Readex Pro",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: List.generate(fonts.length, (index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: _FontBox(
                index: index,
                selectedFont: selectedFont,
                onChanged: onChanged,
                primaryColor: primaryColor,
                textColor: textColor,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _FontBox extends StatelessWidget {
  final int index;
  final int selectedFont;
  final Function(int index) onChanged;
  final Color primaryColor;
  final Color textColor;

  const _FontBox({
    required this.index,
    required this.selectedFont,
    required this.onChanged,
    required this.primaryColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final active = selectedFont == index;
    final fontName = FontSelector.fonts[index];

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => onChanged(index),
      child: Container(
        width: 190,
        height: 70,
        padding: const EdgeInsets.fromLTRB(9, 7, 9, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active ? primaryColor : const Color(0xffE5E7EB),
            width: active ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    fontName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff6B7280),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: active ? primaryColor : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: active ? primaryColor : const Color(0xffCBD5E1),
                    ),
                  ),
                  child: active
                      ? const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 14,
                  )
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "تجربة تسوق رائعة",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.getFont(
                fontName,
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}