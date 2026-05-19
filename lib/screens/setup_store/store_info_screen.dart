import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'contact_info_screen.dart';

import '../../widgets/setup_store/setup_header.dart';
import '../../widgets/setup_store/setup_steps.dart';
import '../../widgets/setup_store/setup_card.dart';
import '../../widgets/setup_store/setup_navigation_buttons.dart';
import '../../widgets/setup_store/section_title.dart';
import '../../models/store_setup_data.dart';

class StoreInfoScreen extends StatefulWidget {
  const StoreInfoScreen({super.key});

  @override
  State<StoreInfoScreen> createState() => _StoreInfoScreenState();
}

class _StoreInfoScreenState extends State<StoreInfoScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final StoreSetupData setupData = StoreSetupData();

  String? storeType;
  String? category;
  String? region;
  String? currency;
  String? year;

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
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
              const SetupHeader(
                title: "بيانات المتجر",
                subtitle: "أدخل معلومات متجرك الأساسية",
                step: "1 من 4",
              ),
              const SetupSteps(currentStep: 0),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 12),
                  child: Column(
                    children: [
                      _mainCard(),
                      const SizedBox(height: 12),
                      _extraCard(),
                      const SizedBox(height: 12),
                      _previewCard(),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              SetupNavigationButtons(
                showBack: false,
                onNext: () {

                  setupData.storeName = nameController.text;
                  setupData.description = descController.text;
                  setupData.storeType = storeType ?? "";
                  setupData.category = category ?? "";
                  setupData.region = region ?? "";
                  setupData.currency = currency ?? "";
                  setupData.year = year ?? "";

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactInfoScreen(
                        setupData: setupData,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainCard() {
    return SetupCard(
      child: Column(
        children: [
          const SectionTitle(
            title: "معلومات المتجر الأساسية",
            subtitle: "أدخل الاسم والوصف ونوع المتجر",
            icon: Icons.storefront_rounded,
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _input(
                      title: "اسم المتجر *",
                      hint: "اكتب اسم متجرك",
                      icon: Icons.storefront_rounded,
                      controller: nameController,
                    ),
                    const SizedBox(height: 10),
                    _input(
                      title: "الوصف التعريفي *",
                      hint: "اكتب وصفاً مختصراً عن متجرك ومنتجاتك",
                      controller: descController,
                      maxLines: 3,
                      helper: "وصف قصير يساعد العملاء على التعرف على متجرك",
                      counter: "${descController.text.length}/200",
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 28),
                child: _logoBox(),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _dropdown(
            title: "نوع المتجر *",
            hint: "اختر نوع متجرك",
            icon: Icons.sell_outlined,
            value: storeType,
            items: const [
              "منتجات منزلية",
              "أطعمة",
              "حلويات",
              "حرف يدوية",
              "ملابس",
            ],
            onChanged: (v) => setState(() => storeType = v),
          ),
          const SizedBox(height: 12),
          _dropdown(
            title: "الفئة الرئيسية *",
            hint: "اختر الفئة الرئيسية للمنتجات",
            icon: Icons.grid_view_rounded,
            value: category,
            items: const [
              "أطعمة",
              "حلويات",
              "عطور",
              "ملابس",
              "إكسسوارات",
            ],
            onChanged: (v) => setState(() => category = v),
          ),
        ],
      ),
    );
  }

  Widget _extraCard() {
    return SetupCard(
      child: Column(
        children: [
          const SectionTitle(
            title: "معلومات المتجر الإضافية",
            subtitle: "بيانات تساعد في ضبط إعدادات المتجر",
            icon: Icons.info_outline_rounded,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _dropdown(
                  title: "منطقة المتجر",
                  hint: "اختر",
                  icon: Icons.location_on_outlined,
                  value: region,
                  items: const [
                    "المكلا",
                    "سيئون",
                    "الشحر",
                    "تريم",
                    "غيل باوزير",
                  ],
                  onChanged: (v) => setState(() => region = v),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _dropdown(
                  title: "العملة",
                  hint: "اختر العملة",
                  icon: Icons.attach_money_rounded,
                  value: currency,
                  items: const [
                    "ريال يمني",
                    "ريال سعودي",
                    "دولار",
                  ],
                  onChanged: (v) => setState(() => currency = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _dropdown(
            title: "سنة تأسيس المتجر",
            hint: "مثال: 2024",
            icon: Icons.calendar_month_rounded,
            value: year,
            items: const ["2026", "2025", "2024", "2023", "2022"],
            onChanged: (v) => setState(() => year = v),
          ),
        ],
      ),
    );
  }

  Widget _previewCard() {
    return SetupCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.remove_red_eye_outlined, size: 20),
              SizedBox(width: 7),
              Text(
                "معاينة المتجر",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameController.text.isEmpty
                          ? "اسم المتجر"
                          : nameController.text,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff111827),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      descController.text.isEmpty
                          ? "وصف قصير عن متجرك ومنتجاتك سيظهر هنا"
                          : descController.text,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        height: 1.5,
                        color: Color(0xff6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F4F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.sell_outlined,
                            size: 15,
                            color: Color(0xff6B7280),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            category ?? "الفئة الرئيسية",
                            style: const TextStyle(
                              fontSize: 10.5,
                              color: Color(0xff6B7280),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Container(
                width: 135,
                height: 105,
                decoration: BoxDecoration(
                  color: const Color(0xffEAF5EF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  size: 58,
                  color: Color(0xff8DBFA5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _logoBox() {
    return DottedBorder(
      color: const Color(0xffCBD5E1),
      strokeWidth: 1.2,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(16),
      child: Container(
        width: 88,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 24,
              color: Color(0xff111827),
            ),
            SizedBox(height: 7),
            Text(
              "شعار المتجر",
              style: TextStyle(
                fontSize: 10,
                color: Color(0xff6B7280),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "JPG, PNG",
              style: TextStyle(
                fontSize: 8.5,
                color: Color(0xff8B94A3),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 7),
            Text(
              "تغيير الشعار",
              style: TextStyle(
                fontSize: 9.5,
                color: Color(0xff087A45),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input({
    required String title,
    required String hint,
    required TextEditingController controller,
    IconData? icon,
    int maxLines = 1,
    String? helper,
    String? counter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(title),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLines > 1 ? 200 : null,
          onChanged: (_) => setState(() {}),
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            counterText: "",
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xff9CA3AF),
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: icon == null
                ? null
                : Icon(
              icon,
              size: 17,
              color: const Color(0xff6B7280),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(color: const Color(0xff087A45)),
          ),
        ),
        if (helper != null || counter != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  helper ?? "",
                  style: const TextStyle(
                    fontSize: 8.8,
                    color: Color(0xff6B7280),
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Text(
                counter ?? "",
                style: const TextStyle(
                  fontSize: 8.8,
                  color: Color(0xff6B7280),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _dropdown({
    required String title,
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(title),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          items: items
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 19,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xff9CA3AF),
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(
              icon,
              size: 16,
              color: const Color(0xff6B7280),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 9,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(color: const Color(0xff087A45)),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.w800,
        color: Color(0xff111827),
      ),
    );
  }

  OutlineInputBorder _border({
    Color color = const Color(0xffE5E7EB),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
    );
  }
}