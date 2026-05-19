import 'package:flutter/material.dart';

class SetupInput extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final IconData? icon;
  final int maxLines;
  final bool enabled;

  const SetupInput({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    this.icon,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: Color(0xff111827),
          ),
        ),

        const SizedBox(height: 5),

        TextField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,

          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: enabled
                ? const Color(0xff111827)
                : const Color(0xff9CA3AF),
          ),

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(
              color: Color(0xff9CA3AF),
              fontSize: 10,
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
            fillColor:
            enabled ? Colors.white : const Color(0xffF9FAFB),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),

            border: _border(),
            enabledBorder: _border(),
            disabledBorder:
            _border(color: const Color(0xffE5E7EB)),
            focusedBorder:
            _border(color: const Color(0xff087A45)),
          ),
        ),
      ],
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

class SetupDropdown extends StatelessWidget {
  final String title;
  final String hint;
  final IconData icon;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const SetupDropdown({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: Color(0xff111827),
          ),
        ),

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
            focusedBorder:
            _border(color: const Color(0xff087A45)),
          ),
        ),
      ],
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