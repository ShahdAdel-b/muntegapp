import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_page.dart';
import 'login_page.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {

  // 🔥 حفظ الرول للمستخدم الجديد
  Future<void> saveRoleAndContinue(String role) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('role', role);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterPage(role: role),
      ),
    );
  }

  // 🔥 الذهاب للوغ إن مباشرة
  Future<void> goToLogin() async {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF6F7F9),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(

            children: [

              // 🔥 HEADER

              Container(

                width: double.infinity,

                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 50,
                ),

                decoration: const BoxDecoration(

                  color: Color(0xFF9CCC65),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                ),

                child: Column(
                  children: [

                    // 🔥 LOGO

                    Container(

                      height: 95,
                      width: 95,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(28),
                      ),

                      child: const Icon(
                        Icons.storefront_rounded,
                        size: 52,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(

                      "مرحبًا بك في منتج ✨",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Padding(

                      padding: EdgeInsets.symmetric(horizontal: 35),

                      child: Text(

                        "اختر طريقة استخدام التطبيق وابدأ رحلتك معنا بسهولة 💚",

                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 22),

                child: Column(

                  children: [

                    // 🛍️ CUSTOMER

                    buildRoleCard(

                      title: "الدخول كزبون",

                      subtitle:
                      "استكشف المنتجات والمتاجر واطلب بسهولة",

                      icon: Icons.shopping_bag_outlined,

                      role: "customer",
                    ),

                    const SizedBox(height: 22),

                    // 🏪 STORE

                    buildRoleCard(

                      title: "الدخول كصاحب متجر",

                      subtitle:
                      "أنشئ متجرك وابدأ بيع منتجاتك الآن",

                      icon: Icons.store_mall_directory_outlined,

                      role: "store",
                    ),

                    const SizedBox(height: 35),

                    // 🔥 LOGIN OPTION

                    Row(
                      children: [

                        Expanded(
                          child: Divider(
                            color: Colors.grey[300],
                          ),
                        ),

                        Padding(

                          padding:
                          const EdgeInsets.symmetric(horizontal: 12),

                          child: Text(
                            "أو",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    GestureDetector(

                      onTap: goToLogin,

                      child: Container(

                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),

                        decoration: BoxDecoration(

                          color: Colors.white,

                          borderRadius: BorderRadius.circular(24),

                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),

                          boxShadow: [

                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),

                        child: const Center(

                          child: Text(

                            "لدي حساب بالفعل",

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8BC34A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              Text(

                "MUNTEG © 2026",

                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  // ================= CARD =================

  Widget buildRoleCard({

    required String title,
    required String subtitle,
    required IconData icon,
    required String role,

  }) {

    return InkWell(

      borderRadius: BorderRadius.circular(30),

      onTap: () {
        saveRoleAndContinue(role);
      },

      child: Container(

        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(30),

          boxShadow: [

            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: Row(
          children: [

            // 🔥 ICON

            Container(

              height: 75,
              width: 75,

              decoration: BoxDecoration(
                color: const Color(0xFFF1F8E9),
                borderRadius: BorderRadius.circular(24),
              ),

              child: Icon(
                icon,
                size: 38,
                color: const Color(0xFF8BC34A),
              ),
            ),

            const SizedBox(width: 18),

            // 🔥 TEXT

            Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    title,

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(

                    subtitle,

                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}