import 'package:flutter/material.dart';

class NormalProductsCustomizationScreen extends StatefulWidget {
  const NormalProductsCustomizationScreen({super.key});

  @override
  State<NormalProductsCustomizationScreen> createState() =>
      _NormalProductsCustomizationScreenState();
}

class _NormalProductsCustomizationScreenState
    extends State<NormalProductsCustomizationScreen> {
  final Color primaryColor = const Color(0xff6D28D9);

  int selectedColumns = 3;
  double productSpacing = 16;
  int selectedRatio = 0;
  bool showCategoryBar = true;
  int selectedSortStyle = 0;

  final ratios = ["1:1", "4:5", "3:4"];

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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                  child: Column(
                    children: [
                      _previewCard(),
                      const SizedBox(height: 12),
                      _settingsCard(),
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
                  "عرض منتجات عادي",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B7280),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _previewCard() {
    return _card(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "1. عرض منتجات عادي",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0xff087A45),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xffEEF0F3)),
            ),
            child: Column(
              children: [
                _miniStoreHeader(),
                const SizedBox(height: 12),
                if (showCategoryBar) _categoryTabs(),
                if (showCategoryBar) const SizedBox(height: 12),
                _productsGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniStoreHeader() {
    return Row(
      children: [
        const Icon(Icons.menu_rounded, size: 18, color: Color(0xff111827)),
        const Spacer(),
        const Text(
          "اسم متجرك",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: Color(0xff111827),
          ),
        ),
        const Spacer(),
        const Icon(Icons.search_rounded, size: 18, color: Color(0xff111827)),
      ],
    );
  }

  Widget _categoryTabs() {
    final tabs = ["الكل", "عطور", "عناية", "مكياج", "الإكسسوارات"];

    return Row(
      children: List.generate(tabs.length, (index) {
        final active = index == 0;

        return Expanded(
          child: Container(
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: active ? const Color(0xff087A45) : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              tabs[index],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                color: active
                    ? const Color(0xff087A45)
                    : const Color(0xff64748B),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _productsGrid() {
    final products = [
      ["عطر فاخر", "120 ر.ي"],
      ["عطر مسك", "120 ر.ي"],
      ["عطر فرنسي", "120 ر.ي"],
      ["مسك مطهر", "120 ر.ي"],
      ["سيروم الوجه", "120 ر.ي"],
      ["زيت الجسم", "120 ر.ي"],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: selectedColumns,
        crossAxisSpacing: productSpacing / 3,
        mainAxisSpacing: productSpacing / 3,
        childAspectRatio: _previewRatioValue(),
      ),
      itemBuilder: (context, index) {
        return _productMiniCard(
          title: products[index][0],
          price: products[index][1],
          index: index,
        );
      },
    );
  }

  double _previewRatioValue() {
    if (selectedRatio == 1) return .78;
    if (selectedRatio == 2) return .72;
    return .82;
  }

  Widget _productMiniCard({
    required String title,
    required String price,
    required int index,
  }) {
    final colors = [
      const Color(0xffF2D8C9),
      const Color(0xffE9D8C7),
      const Color(0xffF0DFCF),
      const Color(0xffEFE7DD),
      const Color(0xffD8B088),
      const Color(0xffE6C6A8),
    ];

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Icon(
                  Icons.local_drink_rounded,
                  size: 22,
                  color: Colors.brown.shade700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 7.5,
              fontWeight: FontWeight.w900,
              color: Color(0xff111827),
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.w800,
              color: Color(0xff475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsCard() {
    return _card(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("2. تخصيص التخطيط"),
          const SizedBox(height: 14),
          _columnsSelector(),
          const SizedBox(height: 16),
          _spacingSlider(),
          const SizedBox(height: 16),
          _ratioSelector(),
          const SizedBox(height: 16),
          _categorySwitch(),
          const SizedBox(height: 16),
          _sortStyleSelector(),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w900,
        color: Color(0xff111827),
      ),
    );
  }

  Widget _columnsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "عدد المنتجات في الصف",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xff64748B),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [4, 3, 2].map((value) {
            final active = selectedColumns == value;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedColumns = value),
                child: Container(
                  height: 38,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active ? primaryColor.withOpacity(.08) : Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: active ? primaryColor : const Color(0xffE5E7EB),
                      width: active ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    "$value",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: active ? primaryColor : const Color(0xff334155),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _spacingSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "مسافة بين المنتجات",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xff64748B),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: productSpacing,
                min: 4,
                max: 28,
                activeColor: primaryColor,
                inactiveColor: const Color(0xffE5E7EB),
                onChanged: (value) {
                  setState(() => productSpacing = value);
                },
              ),
            ),
            _valueBox("${productSpacing.round()}"),
          ],
        ),
      ],
    );
  }

  Widget _ratioSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "نسبة أبعاد الصورة",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xff64748B),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(ratios.length, (index) {
            final active = selectedRatio == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedRatio = index),
                child: Container(
                  height: 38,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active ? primaryColor.withOpacity(.08) : Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: active ? primaryColor : const Color(0xffE5E7EB),
                      width: active ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    ratios[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: active ? primaryColor : const Color(0xff334155),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _categorySwitch() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "إظهار شريط التصنيفات",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xff111827),
            ),
          ),
        ),
        Switch(
          value: showCategoryBar,
          activeColor: Colors.white,
          activeTrackColor: primaryColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xffCBD5E1),
          onChanged: (value) {
            setState(() => showCategoryBar = value);
          },
        ),
      ],
    );
  }

  Widget _sortStyleSelector() {
    final items = ["أعلى اليمين", "أسفل اليسار"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "نمط شارة الخصم",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xff64748B),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(items.length, (index) {
            final active = selectedSortStyle == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedSortStyle = index),
                child: Container(
                  height: 38,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active ? primaryColor.withOpacity(.08) : Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: active ? primaryColor : const Color(0xffE5E7EB),
                      width: active ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    items[index],
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: active ? primaryColor : const Color(0xff334155),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _valueBox(String text) {
    return Container(
      width: 42,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xffE5E7EB)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: Color(0xff334155),
        ),
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
                minimumSize: const Size(double.infinity, 50),
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
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text("التالي"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
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
}