import 'package:flutter/material.dart';

import 'shipping_payment_screen.dart';

import '../../widgets/setup_store/add_method_button.dart';
import '../../widgets/setup_store/section_title.dart';
import '../../widgets/setup_store/setup_card.dart';
import '../../widgets/setup_store/setup_header.dart';
import '../../widgets/setup_store/setup_navigation_buttons.dart';
import '../../widgets/setup_store/setup_steps.dart';
import '../../models/store_setup_data.dart';

class ContactInfoScreen extends StatefulWidget {

  final StoreSetupData setupData;

  const ContactInfoScreen({
    super.key,
    required this.setupData,
  });

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  bool phone = true;
  bool email = true;
  bool instagram = true;
  bool telegram = true;
  bool tiktok = true;
  bool facebook = false;

  final phoneController = TextEditingController(text: "777123456");
  final emailController = TextEditingController(text: "store@gmail.com");
  final instagramController = TextEditingController(text: "@hadram_store");
  final telegramController = TextEditingController(text: "t.me/hadram_store");
  final tiktokController = TextEditingController(text: "@hadram_store");
  final facebookController = TextEditingController(text: "Hadram Store");

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    instagramController.dispose();
    telegramController.dispose();
    tiktokController.dispose();
    facebookController.dispose();
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
                title: "معلومات التواصل",
                subtitle: "أضف طرق التواصل مع عملائك",
                step: "2 من 4",
              ),
              const SetupSteps(currentStep: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 12),
                  child: Column(
                    children: [
                      _contactCard(),
                      const SizedBox(height: 12),
                      _previewCard(),
                      const SizedBox(height: 12),
                      _noteBox(),
                    ],
                  ),
                ),
              ),
              SetupNavigationButtons(
                onNext: () {
                  widget.setupData.phone = phoneController.text;
                  widget.setupData.email = emailController.text;
                  widget.setupData.instagram = instagramController.text;
                  widget.setupData.telegram = telegramController.text;
                  widget.setupData.tiktok = tiktokController.text;
                  widget.setupData.facebook = facebookController.text;

                  widget.setupData.phoneEnabled = phone;
                  widget.setupData.emailEnabled = email;
                  widget.setupData.instagramEnabled = instagram;
                  widget.setupData.telegramEnabled = telegram;
                  widget.setupData.tiktokEnabled = tiktok;
                  widget.setupData.facebookEnabled = facebook;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShippingPaymentScreen(
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

  Widget _contactCard() {
    return SetupCard(
      child: Column(
        children: [
          const SectionTitle(
            title: "طرق التواصل",
            subtitle: "اختر طرق التواصل التي ترغب بعرضها في متجرك",
            icon: Icons.phone_rounded,
          ),
          const SizedBox(height: 18),
          _contactRow(
            title: "رقم الجوال",
            subtitle: "تواصل مباشر عبر واتساب",
            icon: Icons.chat_rounded,
            iconColor: Color(0xff11A85A),
            iconBg: Color(0xffEAF8F0),
            controller: phoneController,
            enabled: phone,
            onChanged: (v) => setState(() => phone = v),
          ),
          _contactRow(
            title: "البريد الإلكتروني",
            subtitle: "للاستفسارات والدعم",
            icon: Icons.email_outlined,
            iconColor: Color(0xff1593C9),
            iconBg: Color(0xffEAF7FF),
            controller: emailController,
            enabled: email,
            onChanged: (v) => setState(() => email = v),
          ),
          _contactRow(
            title: "انستقرام",
            subtitle: "تابعنا على انستقرام",
            icon: Icons.camera_alt_outlined,
            iconColor: Color(0xffE1306C),
            iconBg: Color(0xffFFF0F5),
            controller: instagramController,
            enabled: instagram,
            onChanged: (v) => setState(() => instagram = v),
          ),
          _contactRow(
            title: "تيليجرام",
            subtitle: "انضم لقناة التحديثات",
            icon: Icons.send_rounded,
            iconColor: Color(0xff229ED9),
            iconBg: Color(0xffEAF7FF),
            controller: telegramController,
            enabled: telegram,
            onChanged: (v) => setState(() => telegram = v),
          ),
          _contactRow(
            title: "تيك توك",
            subtitle: "تابعنا على تيك توك",
            icon: Icons.music_note_rounded,
            iconColor: Colors.black,
            iconBg: Color(0xffF3F4F6),
            controller: tiktokController,
            enabled: tiktok,
            onChanged: (v) => setState(() => tiktok = v),
          ),
          _contactRow(
            title: "فيسبوك",
            subtitle: "صفحتنا على فيسبوك",
            icon: Icons.facebook_rounded,
            iconColor: Color(0xff1877F2),
            iconBg: Color(0xffEEF5FF),
            controller: facebookController,
            enabled: facebook,
            onChanged: (v) => setState(() => facebook = v),
          ),
        ],
      ),
    );
  }

  Widget _contactRow({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required TextEditingController controller,
    required bool enabled,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xffEEF0F3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.018),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Transform.scale(
            scale: .78,
            child: Switch(
              value: enabled,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xff087A45),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xffC8CDD5),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 42,
              child: TextField(
                controller: controller,
                enabled: enabled,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: enabled
                      ? const Color(0xff111827)
                      : const Color(0xff9CA3AF),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: enabled ? Colors.white : const Color(0xffF9FAFB),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 8,
                  ),
                  border: _border(),
                  enabledBorder: _border(),
                  disabledBorder: _border(color: const Color(0xffE5E7EB)),
                  focusedBorder: _border(color: const Color(0xff087A45)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 86,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 9.2,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6B7280),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _previewCard() {
    final items = [
      if (phone) ["واتساب", Icons.chat_rounded, const Color(0xff14B84A)],
      if (email) ["البريد", Icons.email_outlined, const Color(0xff2F8FE8)],
      if (instagram)
        ["انستقرام", Icons.camera_alt_outlined, const Color(0xffE1306C)],
      if (telegram) ["تيليجرام", Icons.send_rounded, const Color(0xff229ED9)],
      if (tiktok) ["تيك توك", Icons.music_note_rounded, Colors.black],
      if (facebook) ["فيسبوك", Icons.facebook_rounded, const Color(0xff1877F2)],
    ];

    return SetupCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: "معاينة طرق التواصل",
            subtitle: "سيتم عرضها في صفحة المتجر",
            icon: Icons.remove_red_eye_outlined,
            small: true,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 78,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (items[index][2] as Color).withOpacity(.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        items[index][1] as IconData,
                        color: items[index][2] as Color,
                        size: 25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      items[index][0] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff111827),
                      ),
                    ),
                  ],
                );
              },
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
        color: const Color(0xffEEF6F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xff087A45), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "ستظهر أيقونات التواصل المختارة في صفحة المتجر لتمكين عملائك من التواصل معك بسهولة.",
              style: TextStyle(
                fontSize: 10.5,
                height: 1.5,
                color: Color(0xff6B7280),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _border({
    Color color = const Color(0xffE5E7EB),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}