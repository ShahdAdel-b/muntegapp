import 'package:flutter/material.dart';

import '../../models/store_setup_data.dart';
import '../../widgets/setup_store/setup_header.dart';
import '../../widgets/setup_store/setup_steps.dart';
import '../../widgets/setup_store/setup_card.dart';
import '../../widgets/setup_store/setup_navigation_buttons.dart';
import '../templates/template_selection_screen.dart';

class ReviewScreen extends StatelessWidget {
  final StoreSetupData setupData;

  const ReviewScreen({
    super.key,
    required this.setupData,
  });

  String _value(String value) {
    return value.trim().isEmpty ? "لم يتم الإدخال" : value;
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
                title: "مراجعة",
                subtitle: "راجع بيانات متجرك قبل النشر",
                step: "4 من 4",
              ),
              const SetupSteps(currentStep: 3),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 12),
                  child: Column(
                    children: [
                      _successBox(),
                      const SizedBox(height: 12),
                      _storeCard(),
                      const SizedBox(height: 12),
                      _contactCard(),
                      const SizedBox(height: 12),
                      _shippingCard(),
                      const SizedBox(height: 12),
                      _paymentCard(),
                      const SizedBox(height: 12),
                      _noteBox(),
                    ],
                  ),
                ),
              ),
              SetupNavigationButtons(
                showBack: true,
                onNext: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TemplateSelectionScreen(),
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

  Widget _successBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xffEEF8F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffD8F0E2)),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xff087A45),
            child: Icon(Icons.check_rounded, color: Colors.white, size: 20),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تم إدخال جميع البيانات المطلوبة",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff087A45),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "راجع البيانات التالية وتأكد منها قبل نشر متجرك",
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storeCard() {
    return SetupCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            title: "بيانات المتجر",
            icon: Icons.storefront_rounded,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: const Color(0xffFCE7F3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    _value(setupData.storeName),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Color(0xffDB2777),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _InfoItem(
                        label: "اسم المتجر",
                        value: _value(setupData.storeName),
                      ),
                    ),
                    Expanded(
                      child: _InfoItem(
                        label: "نوع المتجر",
                        value: _value(setupData.storeType),
                      ),
                    ),
                    Expanded(
                      child: _InfoItem(
                        label: "الفئة الرئيسية",
                        value: _value(setupData.category),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "شعار المتجر",
            style: TextStyle(
              fontSize: 10,
              color: Color(0xff6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactCard() {
    return SetupCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            title: "معلومات التواصل",
            icon: Icons.phone_rounded,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoItem(
                  label: "رقم الجوال",
                  value: _value(setupData.phone),
                ),
              ),
              Expanded(
                child: _InfoItem(
                  label: "البريد الإلكتروني",
                  value: _value(setupData.email),
                ),
              ),
              Expanded(
                child: _InfoItem(
                  label: "حساب إنستقرام",
                  value: _value(setupData.instagram),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shippingCard() {
    return SetupCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            title: "الشحن",
            icon: Icons.local_shipping_outlined,
          ),
          const SizedBox(height: 12),
          _reviewRow(
            title: "توصيل داخل المدينة",
            middle: "رسوم التوصيل: 2,000 ر.ي",
            end: "مدة التوصيل: 1 - 2 يوم",
          ),
          _divider(),
          _reviewRow(
            title: "توصيل خارج المدينة",
            middle: "رسوم التوصيل: 5,000 ر.ي",
            end: "مدة التوصيل: 2 - 4 يوم",
          ),
          _divider(),
          _reviewRow(
            title: "استلام من المتجر",
            middle: "رسوم الخدمة: مجاني",
            end: "مدة التجهيز: في نفس اليوم",
          ),
        ],
      ),
    );
  }

  Widget _paymentCard() {
    return SetupCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            title: "الدفع",
            icon: Icons.payment_rounded,
          ),
          const SizedBox(height: 12),
          _paymentRow("الدفع كاش عند الاستلام", null, true),
          _paymentRow("تحويل عبر العمقي", "الحساب: 770123456", true),
          _paymentRow("تحويل عبر الكريمي", "الحساب: 779876543", true),
          _paymentRow("حوالة بن دول", "الاسم: محمد أحمد علي", true),
          _paymentRow("محفظة إلكترونية", null, false),
        ],
      ),
    );
  }

  Widget _sectionHeader({
    required String title,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 43,
          height: 43,
          decoration: const BoxDecoration(
            color: Color(0xffEAF5EF),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xff087A45), size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xff111827),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit_outlined, size: 18),
          label: const Text(
            "تعديل",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xff111827),
            side: const BorderSide(color: Color(0xffE5E7EB)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _reviewRow({
    required String title,
    required String middle,
    required String end,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Color(0xff111827),
              ),
            ),
          ),
          Expanded(
            child: Text(
              middle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              end,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentRow(String title, String? details, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(
            active ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            color: active ? const Color(0xff087A45) : const Color(0xff9CA3AF),
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Color(0xff111827),
              ),
            ),
          ),
          if (details != null)
            Text(
              details,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xff6B7280),
              ),
            ),
        ],
      ),
    );
  }

  Widget _noteBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xffEEF5FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xff2563EB), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "بعد نشر متجرك يمكن للعملاء رؤية متجرك وطلب منتجاتك",
              style: TextStyle(
                fontSize: 10.5,
                color: Color(0xff2563EB),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      color: const Color(0xffEEF0F3),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: Color(0xff6B7280),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Color(0xff111827),
          ),
        ),
      ],
    );
  }
}