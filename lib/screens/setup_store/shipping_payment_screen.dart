import 'package:flutter/material.dart';

import '../../widgets/setup_store/add_method_button.dart';
import '../../widgets/setup_store/add_payment_dialog.dart';
import '../../widgets/setup_store/section_title.dart';
import '../../widgets/setup_store/setup_card.dart';
import '../../widgets/setup_store/setup_header.dart';
import '../../widgets/setup_store/setup_navigation_buttons.dart';
import '../../widgets/setup_store/setup_steps.dart';
import 'review_screen.dart';
import '../../models/store_setup_data.dart';
import 'review_screen.dart';

class ShippingExtraItem {
  final TextEditingController name = TextEditingController();
  final TextEditingController subtitle = TextEditingController();
  final TextEditingController fee = TextEditingController();
  final TextEditingController time = TextEditingController();

  bool enabled = true;
  String duration = "1 - 2 يوم";

  void dispose() {
    name.dispose();
    subtitle.dispose();
    fee.dispose();
    time.dispose();
  }
}

class ShippingPaymentScreen extends StatefulWidget {
  final StoreSetupData setupData;

  const ShippingPaymentScreen({
    super.key,
    required this.setupData,
  });

  @override
  State<ShippingPaymentScreen> createState() => _ShippingPaymentScreenState();
}

class _ShippingPaymentScreenState extends State<ShippingPaymentScreen> {
  bool cityDelivery = true;
  bool outsideDelivery = true;
  bool pickup = true;

  bool cash = true;
  bool bank = true;
  bool alkarimi = true;
  bool binDawel = true;
  bool wallet = false;

  final List<ShippingExtraItem> extraShipping = [];
  final List<TextEditingController> extraPaymentNames = [];

  final cityFee = TextEditingController(text: "2,000");
  final outsideFee = TextEditingController(text: "5,000");
  final cityTime = TextEditingController(text: "8 ص - 8 م");
  final outsideTime = TextEditingController(text: "8 ص - 6 م");
  final pickupTime = TextEditingController(text: "في نفس اليوم");

  final bankAccount = TextEditingController(text: "770123456");
  final karimiAccount = TextEditingController(text: "779876543");
  final binDawelName = TextEditingController(text: "محمد احمد علي");

  String cityDuration = "1 - 2 يوم";
  String outsideDuration = "2 - 4 يوم";
  String pickupFee = "مجاني";

  @override
  void dispose() {
    cityFee.dispose();
    outsideFee.dispose();
    cityTime.dispose();
    outsideTime.dispose();
    pickupTime.dispose();
    bankAccount.dispose();
    karimiAccount.dispose();
    binDawelName.dispose();

    for (final item in extraShipping) {
      item.dispose();
    }
    for (final c in extraPaymentNames) {
      c.dispose();
    }

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
                title: "الشحن والدفع",
                subtitle: "حدد طرق الشحن والدفع المناسبة لعملائك",
                step: "3 من 4",
              ),
              const SetupSteps(currentStep: 2),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 12),
                  child: Column(
                    children: [
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
                onNext: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewScreen(
                        setupData: widget.setupData,
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

  Widget _shippingCard() {
    return SetupCard(
      child: Column(
        children: [
          const SectionTitle(
            title: "طرق الشحن",
            subtitle: "أضف طرق الشحن وحدد رسوم التوصيل ومدة التسليم",
            icon: Icons.local_shipping_outlined,
          ),
          const SizedBox(height: 14),
          _shippingMethod(
            title: "توصيل داخل المدينة",
            subtitle: "توصيل الطلبات داخل نفس المدينة",
            enabled: cityDelivery,
            onChanged: (v) => setState(() => cityDelivery = v),
            feeController: cityFee,
            durationValue: cityDuration,
            durationItems: const ["1 - 2 يوم", "2 - 3 يوم", "في نفس اليوم"],
            onDurationChanged: (v) => setState(() => cityDuration = v!),
            timeController: cityTime,
          ),
          _shippingMethod(
            title: "توصيل خارج المدينة",
            subtitle: "توصيل الطلبات إلى خارج المدينة",
            enabled: outsideDelivery,
            onChanged: (v) => setState(() => outsideDelivery = v),
            feeController: outsideFee,
            durationValue: outsideDuration,
            durationItems: const ["2 - 4 يوم", "3 - 5 أيام", "أسبوع"],
            onDurationChanged: (v) => setState(() => outsideDuration = v!),
            timeController: outsideTime,
          ),
          _pickupMethod(),
          const SizedBox(height: 4),
          ...extraShipping.map(
                (item) => _customShippingMethod(item),
          ),
          AddMethodButton(
            title: "إضافة طريقة شحن جديدة",
            onTap: () {
              setState(() {
                extraShipping.add(ShippingExtraItem());
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _paymentCard() {
    return SetupCard(
      child: Column(
        children: [
          const SectionTitle(
            title: "طرق الدفع",
            subtitle: "اختر طرق الدفع المتاحة لعملائك",
            icon: Icons.payment_rounded,
          ),
          const SizedBox(height: 14),
          _paymentMethod(
            title: "الدفع كاش عند الاستلام",
            subtitle: "يدفع العميل المبلغ عند استلام الطلب",
            icon: Icons.money_rounded,
            iconColor: Color(0xff087A45),
            iconBg: Color(0xffEAF5EF),
            enabled: cash,
            onChanged: (v) => setState(() => cash = v),
          ),
          _paymentMethod(
            title: "تحويل عبر العمقي",
            subtitle: "استلام التحويل على حساب العمقي",
            icon: Icons.account_balance_rounded,
            iconColor: Color(0xff8E44CC),
            iconBg: Color(0xffF3E8FF),
            enabled: bank,
            onChanged: (v) => setState(() => bank = v),
            controller: bankAccount,
            fieldLabel: "رقم الحساب",
          ),
          _paymentMethod(
            title: "تحويل عبر الكريمي",
            subtitle: "استلام التحويل على حساب الكريمي",
            icon: Icons.account_balance_wallet_rounded,
            iconColor: Color(0xff0F9F8A),
            iconBg: Color(0xffE7FAF6),
            enabled: alkarimi,
            onChanged: (v) => setState(() => alkarimi = v),
            controller: karimiAccount,
            fieldLabel: "رقم الحساب",
          ),
          _paymentMethod(
            title: "حوالة بن دول",
            subtitle: "استلام الحوالات عبر بن دول",
            icon: Icons.credit_card_rounded,
            iconColor: Color(0xff0F172A),
            iconBg: Color(0xffEAF0F7),
            enabled: binDawel,
            onChanged: (v) => setState(() => binDawel = v),
            controller: binDawelName,
            fieldLabel: "اسم المستفيد",
          ),
          _paymentMethod(
            title: "محفظة إلكترونية",
            subtitle: "دفع عبر المحفظة الإلكترونية",
            icon: Icons.wallet_rounded,
            iconColor: Color(0xffF97316),
            iconBg: Color(0xffFFF1E8),
            enabled: wallet,
            onChanged: (v) => setState(() => wallet = v),
          ),
          const SizedBox(height: 4),
          ...extraPaymentNames.map(
                (controller) => _customMethodBox(
              nameController: controller,
              hint: "اكتب اسم طريقة الدفع",
              subtitle: "أضف بيانات طريقة الدفع",
              icon: Icons.payment_rounded,

              onDelete: () {
                setState(() {
                  controller.dispose();
                  extraPaymentNames.remove(controller);
                });
              },
            ),
          ),
          AddMethodButton(
            title: "إضافة طريقة دفع جديدة",
            onTap: _showPaymentDialog,
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddPaymentDialog(
          onSave: (name) {
            setState(() {
              extraPaymentNames.add(TextEditingController(text: name));
            });
          },
        );
      },
    );
  }

  Widget _shippingMethod({
    required String title,
    required String subtitle,
    required bool enabled,
    required Function(bool) onChanged,
    required TextEditingController feeController,
    required String durationValue,
    required List<String> durationItems,
    required Function(String?) onDurationChanged,
    required TextEditingController timeController,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: _methodBox(),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Transform.scale(
                scale: .76,
                child: Switch(
                  value: enabled,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xff087A45),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xffC8CDD5),
                  onChanged: onChanged,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _methodTitle(title),
                    const SizedBox(height: 3),
                    _methodSubtitle(subtitle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _smallInput(
                  label: "رسوم التوصيل",
                  controller: feeController,
                  prefix: "ر.س",
                  enabled: enabled,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _smallDropdown(
                  label: "مدة التوصيل",
                  value: durationValue,
                  items: durationItems,
                  onChanged: enabled ? onDurationChanged : null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _smallInput(
                  label: "وقت العمل (اختياري)",
                  controller: timeController,
                  enabled: enabled,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pickupMethod() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: _methodBox(),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Transform.scale(
                scale: .76,
                child: Switch(
                  value: pickup,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xff087A45),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xffC8CDD5),
                  onChanged: (v) => setState(() => pickup = v),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "استلام من المتجر",
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff111827),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "يستلم العميل الطلب من المتجر مباشرة",
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _smallDropdown(
                  label: "رسوم الخدمة",
                  value: pickupFee,
                  items: const ["مجاني", "500", "1,000"],
                  onChanged: pickup
                      ? (v) => setState(() => pickupFee = v!)
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _smallInput(
                  label: "مدة تجهيز الطلب",
                  controller: pickupTime,
                  enabled: pickup,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentMethod({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required bool enabled,
    required Function(bool) onChanged,
    TextEditingController? controller,
    String? fieldLabel,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: _methodBox(),
      child: Row(
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: iconColor, size: 21),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 125,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _methodTitle(title),
                const SizedBox(height: 3),
                _methodSubtitle(subtitle),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (controller != null)
            Expanded(
              child: _smallInput(
                label: fieldLabel ?? "",
                controller: controller,
                enabled: enabled,
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: 8),
          Transform.scale(
            scale: .76,
            child: Switch(
              value: enabled,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xff087A45),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xffC8CDD5),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customMethodBox({
    required TextEditingController nameController,
    required String hint,
    required String subtitle,
    required IconData icon,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: _methodBox(),
      child: Row(
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: const Color(0xffEAF5EF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: const Color(0xff087A45),
              size: 21,
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameController.text.isEmpty
                      ? "طريقة جديدة"
                      : nameController.text,
                  style: const TextStyle(
                    fontSize: 12.2,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 9.2,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B7280),
                  ),
                ),
              ],
            ),
          ),

          Transform.scale(
            scale: .76,
            child: Switch(
              value: true,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xff087A45),
              onChanged: (v) {},
            ),
          ),

          const SizedBox(width: 4),

          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 20,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xffEEF6F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xff087A45), size: 18),
          SizedBox(width: 7),
          Text(
            "يمكنك تفعيل أو تعطيل أي طريقة في أي وقت",
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

  BoxDecoration _methodBox() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xffE5E7EB)),
    );
  }

  Widget _methodTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.2,
        fontWeight: FontWeight.w900,
        color: Color(0xff111827),
      ),
    );
  }

  Widget _methodSubtitle(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 9.2,
        fontWeight: FontWeight.w600,
        color: Color(0xff6B7280),
        height: 1.25,
      ),
    );
  }

  Widget _smallLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 8.8,
        fontWeight: FontWeight.w700,
        color: Color(0xff6B7280),
      ),
    );
  }

  Widget _smallInput({
    required String label,
    required TextEditingController controller,
    String? prefix,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _smallLabel(label),
        const SizedBox(height: 4),
        SizedBox(
          height: 38,
          child: TextField(
            controller: controller,
            enabled: enabled,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: enabled
                  ? const Color(0xff111827)
                  : const Color(0xff9CA3AF),
            ),
            decoration: InputDecoration(
              prefixText: prefix == null ? null : "$prefix  ",
              prefixStyle: const TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: Color(0xff111827),
              ),
              filled: true,
              fillColor: enabled ? Colors.white : const Color(0xffF9FAFB),
              contentPadding: const EdgeInsets.symmetric(horizontal: 9),
              border: _border(),
              enabledBorder: _border(),
              disabledBorder: _border(color: const Color(0xffE5E7EB)),
              focusedBorder: _border(color: const Color(0xff087A45)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _smallDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _smallLabel(label),
        const SizedBox(height: 4),
        SizedBox(
          height: 38,
          child: DropdownButtonFormField<String>(
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
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
                .toList(),
            onChanged: onChanged,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            decoration: InputDecoration(
              filled: true,
              fillColor:
              onChanged == null ? const Color(0xffF9FAFB) : Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 9),
              border: _border(),
              enabledBorder: _border(),
              disabledBorder: _border(color: const Color(0xffE5E7EB)),
              focusedBorder: _border(color: const Color(0xff087A45)),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border({
    Color color = const Color(0xffE5E7EB),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
  Widget _customShippingMethod(ShippingExtraItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: _methodBox(),
      child: Column(
        children: [
          Row(
            children: [
              Transform.scale(
                scale: .76,
                child: Switch(
                  value: item.enabled,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xff087A45),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xffC8CDD5),
                  onChanged: (v) {
                    setState(() {
                      item.enabled = v;
                    });
                  },
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 34,
                      child: TextField(
                        controller: item.name,
                        enabled: item.enabled,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w900,
                        ),
                        decoration: InputDecoration(
                          hintText: "اكتب اسم طريقة الشحن",
                          hintStyle: const TextStyle(
                            fontSize: 10,
                            color: Color(0xff9CA3AF),
                            fontWeight: FontWeight.w600,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 9),
                          border: _border(),
                          enabledBorder: _border(),
                          disabledBorder: _border(color: const Color(0xffE5E7EB)),
                          focusedBorder: _border(color: const Color(0xff087A45)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 34,
                      child: TextField(
                        controller: item.subtitle,
                        enabled: item.enabled,
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: "اكتب وصف مختصر لطريقة الشحن",
                          hintStyle: const TextStyle(
                            fontSize: 9,
                            color: Color(0xff9CA3AF),
                            fontWeight: FontWeight.w500,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 9),
                          border: _border(),
                          enabledBorder: _border(),
                          disabledBorder: _border(color: const Color(0xffE5E7EB)),
                          focusedBorder: _border(color: const Color(0xff087A45)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    item.dispose();
                    extraShipping.remove(item);
                  });
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 20,
                  color: Color(0xff6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _smallInput(
                  label: "رسوم التوصيل",
                  controller: item.fee,
                  prefix: "ر.س",
                  enabled: item.enabled,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _smallDropdown(
                  label: "مدة التوصيل",
                  value: item.duration,
                  items: const ["1 - 2 يوم", "2 - 4 يوم", "أسبوع"],
                  onChanged: item.enabled
                      ? (v) {
                    setState(() {
                      item.duration = v!;
                    });
                  }
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _smallInput(
                  label: "وقت العمل",
                  controller: item.time,
                  enabled: item.enabled,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}