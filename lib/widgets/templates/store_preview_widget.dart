import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'font_selector.dart';

class StorePreviewWidget extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color textColor;
  final int selectedFont;
  final int selectedHeader;
  final int selectedNav;
  final Color buttonColor;
  final Color buttonTextColor;
  final double buttonRadius;

  const StorePreviewWidget({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.selectedFont,
    required this.selectedHeader,
    required this.selectedNav,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.buttonRadius,
  });

  String get currentFont => FontSelector.fonts[selectedFont];

  @override
  Widget build(BuildContext context) {
    return _card(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Column(
          children: [
            _header(),
            _hero(),
            _categories(),
            _bottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    if (selectedHeader == 0) {
      return Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withOpacity(.95),
              primaryColor,
            ],
          ),
        ),
        child: _headerContent(textColorValue: Colors.white),
      );
    }

    if (selectedHeader == 1) {
      return Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white.withOpacity(.78),
        child: _headerContent(textColorValue: textColor),
      );
    }

    if (selectedHeader == 2) {
      return Container(
        height: 74,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "بيت الراحة",
                style: GoogleFonts.getFont(
                  currentFont,
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "للأدوات المنزلية",
                style: GoogleFonts.getFont(
                  currentFont,
                  color: textColor.withOpacity(.70),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      color: primaryColor,
      child: _headerContent(
        textColorValue: Colors.white,
        compact: true,
      ),
    );
  }

  Widget _headerContent({
    required Color textColorValue,
    bool compact = false,
  }) {
    return Row(
      children: [
        Icon(
          Icons.menu_rounded,
          color: textColorValue,
          size: compact ? 24 : 28,
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "بيت الراحة",
              style: GoogleFonts.getFont(
                currentFont,
                color: textColorValue,
                fontSize: compact ? 15 : 17,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "للأدوات المنزلية",
              style: GoogleFonts.getFont(
                currentFont,
                color: textColorValue.withOpacity(.90),
                fontSize: compact ? 9 : 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
        Icon(
          Icons.search_rounded,
          color: textColorValue,
          size: compact ? 23 : 27,
        ),
        SizedBox(width: compact ? 10 : 14),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: textColorValue,
              size: compact ? 23 : 27,
            ),
            Positioned(
              top: -7,
              right: -7,
              child: CircleAvatar(
                radius: compact ? 8 : 10,
                backgroundColor: backgroundColor,
                child: Text(
                  "2",
                  style: GoogleFonts.getFont(
                    currentFont,
                    color: primaryColor,
                    fontSize: compact ? 8 : 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _hero() {
    return Container(
      height: 150,
      width: double.infinity,
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned(
            right: 32,
            top: 34,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "أدوات منزلية\nتناسب حياتك",
                  style: GoogleFonts.getFont(
                    currentFont,
                    fontSize: 22,
                    height: 1.4,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "جودة عالية وتصميم عصري",
                  style: GoogleFonts.getFont(
                    currentFont,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: textColor.withOpacity(.75),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 32,
            bottom: 22,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(buttonRadius),
              ),
              child: Text(
                "تسوق الآن",
                style: GoogleFonts.getFont(
                  currentFont,
                  color: buttonTextColor,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Positioned(
            left: 28,
            bottom: 0,
            child: Icon(
              Icons.chair_rounded,
              size: 118,
              color: secondaryColor.withOpacity(.45),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dot(true),
                _dot(false),
                _dot(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categories() {
    return Container(
      height: 76,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _CategoryIcon(icon: Icons.local_offer_rounded, title: "عروض"),
          _CategoryIcon(icon: Icons.cleaning_services_rounded, title: "التنظيف"),
          _CategoryIcon(icon: Icons.lightbulb_outline_rounded, title: "الديكور"),
          _CategoryIcon(icon: Icons.bed_rounded, title: "غرفة النوم"),
          _CategoryIcon(icon: Icons.soup_kitchen_rounded, title: "المطبخ"),
        ],
      ),
    );
  }
  Widget _navDot(bool active) {
    return Container(
      width: active ? 10 : 8,
      height: active ? 10 : 8,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: active ? primaryColor : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? primaryColor : const Color(0xffCBD5E1),
          width: 1.5,
        ),
      ),
    );
  }
  Widget _dot(bool active) {
    return Container(
      width: active ? 17 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(.55),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
  Widget _bottomNavigationBar() {
    if (selectedNav == 3) {
      return const SizedBox.shrink();
    }

    if (selectedNav == 1) {
      return Container(
        height: 54,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xffEEF0F3)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomNavIconOnly(Icons.home_rounded, true),
            _bottomNavIconOnly(Icons.category_rounded, false),
            _bottomNavIconOnly(Icons.shopping_bag_rounded, false),
            _bottomNavIconOnly(Icons.person_rounded, false),
          ],
        ),
      );
    }

    if (selectedNav == 2) {
      return Container(
        height: 48,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xffEEF0F3)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _navDot(true),
            _navDot(false),
            _navDot(false),
            _navDot(false),
          ],
        ),
      );
    }

    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xffEEF0F3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomNavItem(Icons.home_rounded, "الرئيسية", true),
          _bottomNavItem(Icons.category_rounded, "الأقسام", false),
          _bottomNavItem(Icons.shopping_bag_rounded, "الطلبات", false),
          _bottomNavItem(Icons.person_rounded, "حسابي", false),
        ],
      ),
    );
  }
  Widget _bottomNavIconOnly(IconData icon, bool active) {
    return Icon(
      icon,
      color: active ? primaryColor : const Color(0xff9CA3AF),
      size: 23,
    );
  }

  Widget _bottomNavItem(IconData icon, String title, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: active ? primaryColor : const Color(0xff9CA3AF),
          size: 20,
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: GoogleFonts.getFont(
            currentFont,
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: active ? primaryColor : const Color(0xff6B7280),
          ),
        ),
      ],
    );
  }
  Widget _card({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(12, 15, 12, 15),
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xffEEF0F3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String title;

  const _CategoryIcon({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final preview = context.findAncestorWidgetOfExactType<StorePreviewWidget>();

    final primaryColor = preview?.primaryColor ?? const Color(0xff2E6B4E);
    final selectedFont = preview?.selectedFont ?? 0;
    final currentFont = FontSelector.fonts[selectedFont];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: primaryColor, size: 25),
        const SizedBox(height: 6),
        Text(
          title,
          style: GoogleFonts.getFont(
            currentFont,
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: const Color(0xff111827),
          ),
        ),
      ],
    );
  }
}