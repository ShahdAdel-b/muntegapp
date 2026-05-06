import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'role_selection_page.dart';
import 'home_page.dart';
import 'storesetup_page.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  String role = "customer";

  @override
  void initState() {
    super.initState();
    loadRole();
  }

  // ================= LOAD ROLE =================

  Future loadRole() async {

    final prefs = await SharedPreferences.getInstance();

    final savedRole = prefs.getString("role");

    if (savedRole != null) {

      setState(() {
        role = savedRole;
      });
    }
  }

  // ================= LOGIN =================

  Future login() async {

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {

      showMessage("أكمل جميع الحقول");
      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      // 🔥 تسجيل الدخول

      final userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(

        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user!;

      // 🔥 تحقق الإيميل

      if (!user.emailVerified) {

        showMessage("يرجى التحقق من بريدك الإلكتروني أولاً");

        setState(() {
          isLoading = false;
        });

        return;
      }

      // 🔥 جلب بيانات المستخدم الحقيقية

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {

        showMessage("تعذر العثور على بيانات الحساب");

        setState(() {
          isLoading = false;
        });

        return;
      }

      // 🔥 الرول الحقيقي من فايرستور

      final realRole = doc['role'] ?? 'customer';

      // 🔥 تحديث SharedPreferences

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        "role",
        realRole,
      );

      // 🔥 تحديث role داخل الصفحة

      setState(() {
        role = realRole;
      });

      // 🔥 لو متجر

      if (realRole == "store") {

        final storeCompleted =
            doc['storeCompleted'] ?? false;

        // لو ماكمل بيانات متجره

        if (!storeCompleted) {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => StoreSetupPage(),
            ),
          );

          return;
        }
      }

      // 🔥 دخول طبيعي

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      );

    }

    on FirebaseAuthException catch (e) {

      String message = "حدث خطأ";

      if (e.code == 'user-not-found') {
        message = "الحساب غير موجود";
      }

      else if (e.code == 'wrong-password') {
        message = "كلمة المرور غير صحيحة";
      }

      else if (e.code == 'invalid-email') {
        message = "البريد الإلكتروني غير صالح";
      }

      else if (e.code == 'invalid-credential') {
        message = "بيانات الدخول غير صحيحة";
      }

      showMessage(message);
    }

    catch (e) {

      showMessage("حدث خطأ غير متوقع");
    }

    setState(() {
      isLoading = false;
    });
  }

  // ================= MESSAGE =================

  void showMessage(String msg) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // ================= INPUT =================

  Widget buildInput({

    required String hint,
    required IconData icon,
    required TextEditingController controller,

    bool isPassword = false,

  }) {

    return Container(

      height: 75,

      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.symmetric(horizontal: 18),

      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F5),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xFF8BC34A),
            size: 28,
          ),

          const SizedBox(width: 14),

          Expanded(

            child: TextField(

              controller: controller,

              obscureText:
              isPassword
                  ? obscurePassword
                  : false,

              decoration: InputDecoration(

                border: InputBorder.none,

                hintText: hint,

                hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),

              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),

          if (isPassword)

            GestureDetector(

              onTap: () {

                setState(() {
                  obscurePassword =
                  !obscurePassword;
                });
              },

              child: Icon(

                obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,

                color: Colors.grey[700],
              ),
            ),
        ],
      ),
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(

            children: [

              // 🔥 HEADER

              Container(

                width: double.infinity,

                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 45,
                ),

                decoration: const BoxDecoration(

                  color: Color(0xFFA8D45A),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                ),

                child: Column(

                  children: [

                    // 🔥 BACK BUTTON

                    Padding(

                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),

                      child: Align(

                        alignment:
                        Alignment.centerLeft,

                        child: GestureDetector(

                          onTap: () {

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const RoleSelectionPage(),
                              ),
                            );
                          },

                          child: Container(

                            padding:
                            const EdgeInsets.all(10),

                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.18),

                              borderRadius:
                              BorderRadius.circular(15),
                            ),

                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔥 LOGO

                    Container(

                      width: 95,
                      height: 95,

                      decoration: BoxDecoration(
                        color:
                        Colors.white.withOpacity(0.18),

                        borderRadius:
                        BorderRadius.circular(30),
                      ),

                      child: const Icon(
                        Icons.shopping_bag_rounded,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(

                      "مرحبًا بعودتك",

                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(

                      role == "store"
                          ? "قم بإدارة متجرك بكل سهولة ✨"
                          : "استكشف أفضل المتاجر والمنتجات ✨",

                      style: TextStyle(
                        fontSize: 17,
                        color:
                        Colors.white.withOpacity(0.95),
                      ),
                    ),
                  ],
                ),
              ),

              // 🔥 FORM

              Transform.translate(

                offset: const Offset(0, -20),

                child: Container(

                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),

                  padding: const EdgeInsets.all(26),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(35),

                    boxShadow: [

                      BoxShadow(
                        color:
                        Colors.black.withOpacity(0.06),

                        blurRadius: 18,

                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Column(

                    children: [

                      buildInput(
                        hint: "البريد الإلكتروني",
                        icon: Icons.email_outlined,
                        controller: emailController,
                      ),

                      buildInput(
                        hint: "كلمة المرور",
                        icon:
                        Icons.lock_outline_rounded,
                        controller:
                        passwordController,
                        isPassword: true,
                      ),

                      const SizedBox(height: 12),

                      // 🔥 FORGOT PASSWORD

                      Align(

                        alignment:
                        Alignment.centerRight,

                        child: Text(

                          "نسيت كلمة المرور؟",

                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // 🔥 LOGIN BUTTON

                      SizedBox(

                        width: double.infinity,
                        height: 63,

                        child: ElevatedButton(

                          onPressed:
                          isLoading
                              ? null
                              : login,

                          style:
                          ElevatedButton.styleFrom(

                            backgroundColor:
                            const Color(0xFF8BC53F),

                            elevation: 0,

                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(22),
                            ),
                          ),

                          child: isLoading

                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )

                              : const Text(

                            "تسجيل الدخول",

                            style: TextStyle(
                              fontSize: 21,
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: [

                          Expanded(
                            child: Divider(
                              color:
                              Colors.grey[300],
                            ),
                          ),

                          const Padding(
                            padding:
                            EdgeInsets.symmetric(
                                horizontal: 12),
                            child: Text("أو"),
                          ),

                          Expanded(
                            child: Divider(
                              color:
                              Colors.grey[300],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // 🔥 CREATE ACCOUNT

                      GestureDetector(

                        onTap: () {

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const RoleSelectionPage(),
                            ),
                          );
                        },

                        child: RichText(

                          text: const TextSpan(

                            style: TextStyle(
                              fontSize: 17,
                              color:
                              Colors.black87,
                            ),

                            children: [

                              TextSpan(
                                text:
                                "ليس لديك حساب؟ ",
                              ),

                              TextSpan(
                                text:
                                "أنشئ حسابك الآن",

                                style: TextStyle(
                                  color:
                                  Color(0xFF8BC34A),

                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}