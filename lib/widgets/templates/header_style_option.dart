import 'package:flutter/material.dart';

class HeaderStyleOption extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String title;
  final Color primaryColor;
  final VoidCallback onTap;

  const HeaderStyleOption({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.title,
    required this.primaryColor,
    required this.onTap,
  });

  bool get isSelected => index == selectedIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            width: 132,
            height: 72,
            padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withOpacity(.06) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? primaryColor : const Color(0xffE5E7EB),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Column(
              children: [
                _headerMockup(),
                const Spacer(),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff374151),
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _headerMockup() {
    if (index == 0) return _fullWidthHeader();
    if (index == 1) return _transparentHeader();
    if (index == 2) return _centerHeader();
    return _compactHeader();
  }

  Widget _fullWidthHeader() {
    return Container(
      height: 32,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(.95),
            primaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.menu_rounded, color: Colors.white, size: 16),
          Spacer(),
          Icon(Icons.search_rounded, color: Colors.white, size: 15),
          SizedBox(width: 10),
          Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 15),
        ],
      ),
    );
  }

  Widget _transparentHeader() {
    return Container(
      height: 32,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffEEF0F3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.menu_rounded, color: Color(0xff111827), size: 16),
          Spacer(),
          Icon(Icons.search_rounded, color: Color(0xff111827), size: 15),
          SizedBox(width: 10),
          Icon(Icons.shopping_cart_outlined, color: Color(0xff111827), size: 15),
        ],
      ),
    );
  }

  Widget _centerHeader() {
    return Container(
      height: 32,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffEEF0F3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_rounded, color: Color(0xff111827), size: 15),
          const SizedBox(height: 6),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 14,
            ),
          ),
          const Spacer(),
          const Icon(Icons.search_rounded, color: Color(0xff111827), size: 15),
          const SizedBox(width: 8),
          const Icon(Icons.person_outline_rounded, color: Color(0xff111827), size: 15),
        ],
      ),
    );
  }

  Widget _compactHeader() {
    return Container(
      height: 32,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(.13),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor.withOpacity(.18)),
      ),
      child: Row(
        children: [
          Icon(Icons.menu_rounded, color: primaryColor, size: 16),
          const Spacer(),
          Icon(Icons.search_rounded, color: primaryColor, size: 15),
          const SizedBox(width: 10),
          Icon(Icons.shopping_cart_outlined, color: primaryColor, size: 15),
        ],
      ),
    );
  }
}