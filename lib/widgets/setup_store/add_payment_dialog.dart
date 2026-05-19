import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddPaymentDialog extends StatefulWidget {
  final Function(String name) onSave;

  const AddPaymentDialog({
    super.key,
    required this.onSave,
  });

  @override
  State<AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  String? paymentType;
  bool isActive = true;
  Color selectedColor = const Color(0xff7C3AED);

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
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .88,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _header(),
                const SizedBox(height: 16),

                _dialogInput(
                  title: "اسم طريقة الدفع *",
                  hint: "مثال: مدى، فيزا، أبل باي...",
                  controller: nameController,
                ),

                const SizedBox(height: 12),

                _dialogDropdown(),

                const SizedBox(height: 12),

                _dialogInput(
                  title: "وصف اختياري",
                  hint: "اكتب وصفاً مختصراً عن طريقة الدفع...",
                  controller: descController,
                  maxLines: 3,
                ),

                const SizedBox(height: 12),

                _uploadBox(),

                const SizedBox(height: 14),

                _colorPicker(),

                const SizedBox(height: 14),

                _statusSwitch(),

                const SizedBox(height: 14),

                _noteBox(),

                const SizedBox(height: 16),

                _buttons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close_rounded,
            size: 24,
            color: Color(0xff374151),
          ),
        ),
        const Spacer(),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xffF3E8FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.payment_rounded,
            color: Color(0xff7C3AED),
            size: 21,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          "إضافة طريقة دفع جديدة",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Color(0xff111827),
          ),
        ),
        const Spacer(),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _dialogInput({
    required String title,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(title),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 10,
              color: Color(0xff9CA3AF),
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(color: const Color(0xff7C3AED)),
          ),
        ),
      ],
    );
  }

  Widget _dialogDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("نوع طريقة الدفع *"),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: paymentType,
          isExpanded: true,
          items: const [
            "تحويل بنكي",
            "محفظة إلكترونية",
            "بطاقة بنكية",
            "كاش",
          ]
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
              .toList(),
          onChanged: (v) => setState(() => paymentType = v),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
          decoration: InputDecoration(
            hintText: "اختر نوع الدفع",
            hintStyle: const TextStyle(
              fontSize: 10,
              color: Color(0xff9CA3AF),
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(color: const Color(0xff7C3AED)),
          ),
        ),
      ],
    );
  }

  Widget _uploadBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("شعار طريقة الدفع"),
        const SizedBox(height: 6),
        DottedBorder(
          color: const Color(0xffA78BFA),
          strokeWidth: 1,
          dashPattern: const [6, 4],
          borderType: BorderType.RRect,
          radius: const Radius.circular(13),
          child: Container(
            height: 92,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: Color(0xff7C3AED),
                  size: 26,
                ),
                SizedBox(height: 6),
                Text(
                  "اضغط لرفع صورة",
                  style: TextStyle(
                    color: Color(0xff7C3AED),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "PNG, JPG - الحد الأقصى 2MB",
                  style: TextStyle(
                    color: Color(0xff6B7280),
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _colorPicker() {
    final colors = [
      const Color(0xff7C3AED),
      const Color(0xff22C55E),
      const Color(0xff2F8FE8),
      const Color(0xffF59E0B),
      const Color(0xffEF4444),
      const Color(0xffA1A1AA),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("لون الأيقونة"),
        const SizedBox(height: 9),
        Row(
          children: colors.map((color) {
            final selected = color.value == selectedColor.value;

            return GestureDetector(
              onTap: () => setState(() => selectedColor = color),
              child: Container(
                margin: const EdgeInsetsDirectional.only(end: 9),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? color : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _statusSwitch() {
    return Row(
      children: [
        _label("الحالة"),
        const Spacer(),
        const Text(
          "تفعيل طريقة الدفع",
          style: TextStyle(
            fontSize: 10.5,
            color: Color(0xff374151),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Transform.scale(
          scale: .78,
          child: Switch(
            value: isActive,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xff7C3AED),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xffC8CDD5),
            onChanged: (v) => setState(() => isActive = v),
          ),
        ),
      ],
    );
  }

  Widget _noteBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xffFAF7FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffDDD6FE)),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Color(0xff7C3AED),
            size: 18,
          ),
          SizedBox(width: 7),
          Expanded(
            child: Text(
              "سيتم عرض طريقة الدفع للعملاء عند إتمام الطلب",
              style: TextStyle(
                fontSize: 9.5,
                color: Color(0xff6B7280),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () {
                final name = nameController.text.trim();
                widget.onSave(name.isEmpty ? "طريقة دفع جديدة" : name);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.save_outlined,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                "حفظ طريقة الدفع",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6D28D9),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 44,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xffE5E7EB)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "إلغاء",
                style: TextStyle(
                  color: Color(0xff111827),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        color: Color(0xff111827),
      ),
    );
  }

  OutlineInputBorder _border({
    Color color = const Color(0xffE5E7EB),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}