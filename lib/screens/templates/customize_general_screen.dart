import 'package:flutter/material.dart';
import '../../widgets/templates/color_picker_dialog.dart';
import '../../widgets/templates/font_selector.dart';
import '../../widgets/templates/store_preview_widget.dart';
import '../../widgets/templates/header_style_option.dart';
import '../../widgets/templates/nav_style_option.dart';
import 'customize_products_screen.dart';

class CustomizeGeneralScreen extends StatefulWidget {
  const CustomizeGeneralScreen({super.key});

  @override
  State<CustomizeGeneralScreen> createState() => _CustomizeGeneralScreenState();
}

class _CustomizeGeneralScreenState extends State<CustomizeGeneralScreen> {
  int selectedTab = 0;
  int selectedFont = 0;
  int selectedHeader = 0;
  int selectedNav = 0;

  Color primaryColor = const Color(0xff2E6B4E);
  Color secondaryColor = const Color(0xffA8C5A2);
  Color backgroundColor = const Color(0xffF7F5F0);
  Color textColor = const Color(0xff1F2937);

  Color buttonColor = const Color(0xff2E6B4E);
  Color buttonTextColor = Colors.white;
  double buttonRadius = 10;

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAF9),
        body: SafeArea(
          child: Column(
            children: [
              _header(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 12),
                  child: Column(
                    children: [
                      _tabs(),
                      const SizedBox(height: 12),
                      StorePreviewWidget(
                        primaryColor: primaryColor,
                        secondaryColor: secondaryColor,
                        backgroundColor: backgroundColor,
                        textColor: textColor,
                        selectedFont: selectedFont,
                        selectedHeader: selectedHeader,
                        selectedNav: selectedNav,
                        buttonColor: buttonColor,
                        buttonTextColor: buttonTextColor,
                        buttonRadius: buttonRadius,
                      ),
                      const SizedBox(height: 12),
                      _colorsCard(),
                      const SizedBox(height: 12),
                      _fontsCard(),
                      const SizedBox(height: 12),
                      _headerStyleCard(),
                      const SizedBox(height: 12),
                      _bottomNavCard(),
                      const SizedBox(height: 12),
                      _buttonsCard(),
                    ],
                  ),
                ),
              ),
              _bottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 22),
          ),
          const Expanded(
            child: Column(
              children: [
                Text(
                  "تخصيص القالب",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff111827),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "صمم متجرك ليعكس هويتك",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B7280),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 42,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_rounded, color: Colors.white, size: 19),
              label: const Text(
                "حفظ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff087A45),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    final tabs = [
      ["تخصيص", Icons.brush_rounded],
      ["معاينة المتجر", Icons.remove_red_eye_outlined],
      ["إعدادات المتجر", Icons.settings_outlined],
    ];

    return _card(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final active = selectedTab == index;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(13),
              onTap: () => setState(() => selectedTab = index),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: active ? const Color(0xffEAF5EF) : Colors.transparent,
                  borderRadius: BorderRadius.circular(13),
                  border: Border(
                    bottom: BorderSide(
                      color: active ? const Color(0xff087A45) : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabs[index][1] as IconData,
                      size: 19,
                      color: active ? const Color(0xff087A45) : const Color(0xff6B7280),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tabs[index][0] as String,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        color: active ? const Color(0xff087A45) : const Color(0xff374151),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _colorsCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("1. الألوان", Icons.palette_outlined),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _colorItem(
                  title: "اللون الأساسي",
                  color: primaryColor,
                  onTap: () {
                    _openColorPicker("اللون الأساسي", primaryColor, (color) {
                      setState(() => primaryColor = color);
                    });
                  },
                ),
              ),
              Expanded(
                child: _colorItem(
                  title: "اللون الثانوي",
                  color: secondaryColor,
                  onTap: () {
                    _openColorPicker("اللون الثانوي", secondaryColor, (color) {
                      setState(() => secondaryColor = color);
                    });
                  },
                ),
              ),
              Expanded(
                child: _colorItem(
                  title: "لون الخلفية",
                  color: backgroundColor,
                  onTap: () {
                    _openColorPicker("لون الخلفية", backgroundColor, (color) {
                      setState(() => backgroundColor = color);
                    });
                  },
                ),
              ),
              Expanded(
                child: _colorItem(
                  title: "لون النص",
                  color: textColor,
                  onTap: () {
                    _openColorPicker("لون النص", textColor, (color) {
                      setState(() => textColor = color);
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fontsCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("2. الخطوط", Icons.text_fields_rounded),
          const SizedBox(height: 14),
          FontSelector(
            selectedFont: selectedFont,
            primaryColor: primaryColor,
            textColor: textColor,
            onChanged: (index) {
              setState(() => selectedFont = index);
            },
          ),
        ],
      ),
    );
  }

  Widget _headerStyleCard() {
    final items = ["كامل العرض", "شفاف", "مركزي", "مضغوط"];

    return _optionCard(
      title: "3. نمط الرأس (الهيدر)",
      icon: Icons.workspace_premium_outlined,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: List.generate(items.length, (index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: HeaderStyleOption(
                index: index,
                selectedIndex: selectedHeader,
                title: items[index],
                primaryColor: primaryColor,
                onTap: () {
                  setState(() => selectedHeader = index);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _bottomNavCard() {
    final items = ["أيقونات مع نص", "أيقونات فقط", "نقط في المنتصف", "بدون شريط"];

    return _optionCard(
      title: "4. شريط التنقل السفلي",
      icon: Icons.language_rounded,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: List.generate(items.length, (index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: NavStyleOption(
                index: index,
                selectedIndex: selectedNav,
                title: items[index],
                primaryColor: primaryColor,
                onTap: () {
                  setState(() => selectedNav = index);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buttonsCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("5. تخصيص الأزرار", Icons.smart_button_rounded),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _colorItem(
                  title: "لون الزر",
                  color: buttonColor,
                  onTap: () {
                    _openColorPicker("لون الزر", buttonColor, (color) {
                      setState(() => buttonColor = color);
                    });
                  },
                ),
              ),
              Expanded(
                child: _colorItem(
                  title: "لون النص",
                  color: buttonTextColor,
                  onTap: () {
                    _openColorPicker("لون النص", buttonTextColor, (color) {
                      setState(() => buttonTextColor = color);
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            "استدارة الزر",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xff111827),
            ),
          ),
          Slider(
            value: buttonRadius,
            min: 0,
            max: 30,
            activeColor: primaryColor,
            inactiveColor: const Color(0xffE5E7EB),
            onChanged: (value) {
              setState(() => buttonRadius = value);
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(buttonRadius),
              ),
              child: Text(
                "تسوق الآن",
                style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      color: const Color(0xffF8FAF9),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xff334155),
                side: const BorderSide(color: Color(0xffCBD5E1)),
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "السابق",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomizeProductsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text("التالي"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorItem({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: Color(0xff111827),
              ),
            ),
            const SizedBox(height: 12),
            CircleAvatar(radius: 17, backgroundColor: color),
            const SizedBox(height: 8),
            Text(
              colorToHex(color),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openColorPicker(
      String title,
      Color currentColor,
      Function(Color) onChanged,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return ColorPickerDialog(
          title: title,
          initialColor: currentColor,
          onColorChanged: onChanged,
        );
      },
    );
  }

  Widget _optionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(title, icon),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xff374151)),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Color(0xff111827),
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