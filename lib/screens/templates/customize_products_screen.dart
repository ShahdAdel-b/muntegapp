import 'package:flutter/material.dart';
import '../../widgets/templates/product_option_card.dart';
import 'normal_products_customization_screen.dart';

class CustomizeProductsScreen extends StatefulWidget {
  const CustomizeProductsScreen({super.key});

  @override
  State<CustomizeProductsScreen> createState() =>
      _CustomizeProductsScreenState();
}

class _CustomizeProductsScreenState extends State<CustomizeProductsScreen> {
  final Color primaryColor = const Color(0xff6D28D9);

  int selectedCardShape = 0;
  int selectedRatio = 1;
  int selectedTextPosition = 0;
  int selectedBadgeShape = 0;
  Color badgeColor = const Color(0xffEF4444);

  double cardRadius = 12;
  double horizontalSpacing = 16;
  double verticalSpacing = 16;

  bool showImage = true;
  bool showName = true;
  bool showPrice = true;
  bool showOldPrice = false;
  bool showDiscount = true;
  bool showRating = true;
  bool showCartButton = true;

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
                      _cardShapeSection(),
                      const SizedBox(height: 12),
                      _radiusSection(),
                      const SizedBox(height: 12),
                      _ratioSection(),
                      const SizedBox(height: 12),
                      _contentSection(),
                      const SizedBox(height: 12),
                      _textPositionSection(),
                      const SizedBox(height: 12),
                      _discountSection(),
                      const SizedBox(height: 12),
                      _spacingSection(),
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
                  "تخصيص المنتجات (عام)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff111827),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "حدد كيفية عرض المنتجات في متجرك",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B7280),
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.remove_red_eye_outlined, color: primaryColor),
            label: Text(
              "معاينة المتجر",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    final tabs = [
      ["الألوان", Icons.palette_outlined],
      ["الخطوط", Icons.text_fields_rounded],
      ["الأزرار", Icons.smart_button_rounded],
      ["الهيدر", Icons.web_asset_rounded],
      ["الصفحة الرئيسية", Icons.home_outlined],
      ["المنتجات", Icons.inventory_2_outlined],
      ["عام", Icons.settings_outlined],
    ];

    return _card(
      padding: const EdgeInsets.all(6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabs.length, (index) {
            final active = index == 5;

            return Container(
              width: 88,
              height: 62,
              margin: const EdgeInsetsDirectional.only(end: 6),
              decoration: BoxDecoration(
                color: active ? primaryColor.withOpacity(.10) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border(
                  bottom: BorderSide(
                    color: active ? primaryColor : Colors.transparent,
                    width: 2.5,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    tabs[index][1] as IconData,
                    color: active ? primaryColor : const Color(0xff64748B),
                    size: 22,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tabs[index][0] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: active ? primaryColor : const Color(0xff64748B),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _cardShapeSection() {
    final items = [
      ["مستطيل", Icons.crop_portrait_rounded],
      ["زوايا دائرية", Icons.rounded_corner_rounded],
      ["دائري", Icons.circle_outlined],
      ["مميز (بظلال)", Icons.web_asset_rounded],
    ];

    return _section(
      title: "شكل بطاقة المنتج",
      subtitle: "اختر شكل بطاقة المنتج في المتجر",
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(items.length, (index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: ProductOptionCard(
                selected: selectedCardShape == index,
                title: items[index][0] as String,
                icon: items[index][1] as IconData,
                primaryColor: primaryColor,
                onTap: () {
                  setState(() {
                    selectedCardShape = index;
                  });
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _radiusSection() {
    return _section(
      title: "زوايا البطاقة",
      subtitle: "تتحكم في درجة استدارة زوايا بطاقة المنتج",
      child: Row(
        children: [
          _valueBox("0"),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NormalProductsCustomizationScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text("حفظ واستمرار"),
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
          _valueBox("${cardRadius.round()}px"),
        ],
      ),
    );
  }

  Widget _ratioSection() {
    final ratios = ["1:1", "4:5", "3:4", "16:9", "21:9"];

    return _section(
      title: "نسبة صورة المنتج",
      subtitle: "اختر نسبة عرض إلى ارتفاع صورة المنتج",
      child: Row(
        children: List.generate(ratios.length, (index) {
          final active = selectedRatio == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedRatio = index),
              child: Container(
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: active ? primaryColor : const Color(0xffE5E7EB),
                    width: active ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  ratios[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: active ? primaryColor : const Color(0xff334155),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _contentSection() {
    return _section(
      title: "محتوى البطاقة",
      subtitle: "اختر العناصر التي تريد إظهارها في بطاقة المنتج",
      child: Column(
        children: [
          _switchRow("إظهار صورة المنتج", showImage,
                  (v) => setState(() => showImage = v)),
          _switchRow("إظهار اسم المنتج", showName,
                  (v) => setState(() => showName = v)),
          _switchRow("إظهار السعر", showPrice,
                  (v) => setState(() => showPrice = v)),
          _switchRow("إظهار السعر القديم", showOldPrice,
                  (v) => setState(() => showOldPrice = v)),
          _switchRow("إظهار نسبة الخصم", showDiscount,
                  (v) => setState(() => showDiscount = v)),
          _switchRow("إظهار التقييم", showRating,
                  (v) => setState(() => showRating = v)),
          _switchRow("إظهار زر الإضافة للسلة", showCartButton,
                  (v) => setState(() => showCartButton = v)),
        ],
      ),
    );
  }

  Widget _textPositionSection() {
    final items = [
      ["أسفل الصورة", Icons.vertical_align_bottom_rounded],
      ["داخل الصورة", Icons.center_focus_strong_rounded],
      ["على يمين الصورة", Icons.align_horizontal_right_rounded],
      ["على يسار الصورة", Icons.align_horizontal_left_rounded],
    ];

    return _section(
      title: "موقع النص داخل البطاقة",
      subtitle: "حدد مكان النص بالنسبة للصورة",
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(items.length, (index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: ProductOptionCard(
                selected: selectedTextPosition == index,
                title: items[index][0] as String,
                icon: items[index][1] as IconData,
                primaryColor: primaryColor,
                onTap: () {
                  setState(() {
                    selectedTextPosition = index;
                  });
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _discountSection() {
    return Row(
      children: [
        Expanded(
          child: _section(
            title: "شكل شارة الخصم",
            subtitle: "اختر شكل شارة الخصم",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                final active = selectedBadgeShape == index;

                return GestureDetector(
                  onTap: () => setState(() => selectedBadgeShape = index),
                  child: Container(
                    width: 58,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? primaryColor.withOpacity(.06) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: active ? primaryColor : const Color(0xffE5E7EB),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(index == 1 ? 30 : 6),
                      ),
                      child: const Text(
                        "-20%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _section(
            title: "لون شارة الخصم",
            subtitle: "اختر لون شارة الخصم",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _colorDot(const Color(0xffEF4444)),
                _colorDot(const Color(0xffF97316)),
                _colorDot(const Color(0xff16A34A)),
                _colorDot(const Color(0xff2563EB)),
                _colorDot(const Color(0xff6D28D9)),
                _colorDot(const Color(0xffEC4899)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _spacingSection() {
    return _section(
      title: "المسافة بين المنتجات",
      subtitle: "تحكم في المسافة الأفقية والعمودية بين المنتجات",
      child: Column(
        children: [
          _spacingSlider(
            title: "المسافة الأفقية",
            value: horizontalSpacing,
            onChanged: (v) => setState(() => horizontalSpacing = v),
          ),
          const SizedBox(height: 10),
          _spacingSlider(
            title: "المسافة العمودية",
            value: verticalSpacing,
            onChanged: (v) => setState(() => verticalSpacing = v),
          ),
        ],
      ),
    );
  }

  Widget _spacingSlider({
    required String title,
    required double value,
    required Function(double) onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 105,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xff475569),
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 32,
            activeColor: primaryColor,
            inactiveColor: const Color(0xffE5E7EB),
            onChanged: onChanged,
          ),
        ),
        _valueBox("${value.round()}px"),
      ],
    );
  }

  Widget _switchRow(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: primaryColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xffCBD5E1),
            onChanged: onChanged,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff475569),
              ),
            ),
          ),
          const Icon(Icons.drag_handle_rounded, color: Color(0xff94A3B8)),
        ],
      ),
    );
  }

  Widget _colorDot(Color color) {
    final active = badgeColor == color;

    return GestureDetector(
      onTap: () => setState(() => badgeColor = color),
      child: Container(
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: active ? primaryColor : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xff111827),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff64748B),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _valueBox(String text) {
    return Container(
      width: 55,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffE5E7EB)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: Color(0xff334155),
        ),
      ),
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
            color: Colors.black.withOpacity(.025),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      color: const Color(0xffF8FAF9),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border_rounded),
              label: const Text("حفظ كمسودة"),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xff334155),
                side: const BorderSide(color: Color(0xffCBD5E1)),
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text("حفظ واستمرار"),
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
}