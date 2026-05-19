import 'package:flutter/material.dart';

class NavStyleOption extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String title;
  final Color primaryColor;
  final VoidCallback onTap;

  const NavStyleOption({
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
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 118,
            height: 82,
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
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
                _navMockup(),
                const SizedBox(height: 6),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
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
                  border: Border.all(color: Colors.white, width: 2),
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

  Widget _navMockup() {
    if (index == 0) return _iconsWithText();
    if (index == 1) return _iconsOnly();
    if (index == 2) return _centerDots();
    return _noBar();
  }

  Widget _iconsWithText() {
    return Container(
      height: 32,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withOpacity(.09) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffEEF0F3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home_outlined, color: isSelected ? primaryColor : const Color(0xff374151), size: 14),
          Icon(Icons.category_outlined, color: isSelected ? primaryColor : const Color(0xff374151), size: 14),
          Icon(Icons.shopping_bag_outlined, color: isSelected ? primaryColor : const Color(0xff374151), size: 14),
        ],
      ),
    );
  }

  Widget _iconsOnly() {
    return Container(
      height: 32,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffEEF0F3)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.shopping_bag_outlined, color: Color(0xff374151), size: 14),
          Icon(Icons.local_mall_outlined, color: Color(0xff374151), size: 14),
          Icon(Icons.card_giftcard_rounded, color: Color(0xff374151), size: 14),
        ],
      ),
    );
  }

  Widget _centerDots() {
    return Container(
      height: 32,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffEEF0F3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xff111827), shape: BoxShape.circle)),
          const SizedBox(width: 10),
          _smallDot(),
          const SizedBox(width: 10),
          _smallDot(),
          const SizedBox(width: 10),
          _smallDot(),
        ],
      ),
    );
  }

  Widget _noBar() {
    return Container(
      height: 32,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffEEF0F3)),
      ),
      child: Container(
        width: 62,
        height: 2,
        color: const Color(0xff9CA3AF),
      ),
    );
  }

  Widget _smallDot() {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xffCBD5E1), width: 1.4),
      ),
    );
  }
}