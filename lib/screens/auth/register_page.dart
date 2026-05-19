import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../setup_store/store_info_screen.dart';
import 'email_verification_page.dart';
import 'role_selection_page.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  final String role;

  const RegisterPage({
    super.key,
    required this.role,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;
  bool isLoading = false;
  bool acceptWeakPassword = false;

  String passwordStrength = "";
  Color passwordStrengthColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      checkPasswordStrength(passwordController.text);
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void checkPasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        passwordStrength = "";
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        passwordStrength = "ضعيفة";
        passwordStrengthColor = Colors.red;
      });
    } else if (password.length < 9) {
      setState(() {
        passwordStrength = "متوسطة";
        passwordStrengthColor = Colors.orange;
      });
    } else {
      setState(() {
        passwordStrength = "قوية";
        passwordStrengthColor = Colors.green;
      });
    }
  }

  Future<void> register() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showMessage("أكمل جميع البيانات");
      return;
    }

    if (passwordController.text.length < 6 && !acceptWeakPassword) {
      showMessage("كلمة المرور ضعيفة جدًا، وافق على المتابعة أو غيّرها");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showMessage("كلمتا المرور غير متطابقتين");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user!;

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': usernameController.text.trim(),
        'email': user.email,
        'bio': '',
        'role': widget.role,
        'storeCompleted': false,
        'createdAt': Timestamp.now(),
      });

      await user.sendEmailVerification();

      if (!mounted) return;

      showMessage("تم إنشاء الحساب ✨");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => EmailVerificationPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? "حدث خطأ أثناء إنشاء الحساب");
    } catch (e) {
      showMessage("حدث خطأ أثناء إنشاء الحساب");
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });

      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user!;

      final userDoc =
      FirebaseFirestore.instance.collection('users').doc(user.uid);

      final doc = await userDoc.get();

      if (!doc.exists) {
        await userDoc.set({
          'username': user.displayName ?? '',
          'email': user.email,
          'bio': '',
          'role': widget.role,
          'storeCompleted': false,
          'createdAt': Timestamp.now(),
        });
      }

      if (!mounted) return;

      if (widget.role == "store") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StoreInfoScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Google FirebaseAuthException: ${e.code} - ${e.message}");
      showMessage("فشل تسجيل قوقل: ${e.message ?? e.code}");
    } catch (e) {
      debugPrint("Google Sign In Error: $e");
      showMessage("فشل تسجيل قوقل");
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Widget buildInput({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? toggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF8BC34A),
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: toggle,
          )
              : null,
          filled: true,
          fillColor: const Color(0xFFF3F5F7),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFB8D77A),
                        Color(0xFF8BC34A),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RoleSelectionPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: const Icon(
                                Icons.storefront_rounded,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "إنشاء حساب",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.role == "store"
                                  ? "ابدأ رحلتك كصاحب متجر ✨"
                                  : "اكتشف أفضل المتاجر بسهولة ✨",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          buildInput(
                            hint: "اسم المستخدم",
                            icon: Icons.person_outline,
                            controller: usernameController,
                          ),
                          buildInput(
                            hint: "البريد الإلكتروني",
                            icon: Icons.email_outlined,
                            controller: emailController,
                          ),
                          buildInput(
                            hint: "كلمة المرور",
                            icon: Icons.lock_outline,
                            controller: passwordController,
                            isPassword: true,
                            obscure: obscurePassword,
                            toggle: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          if (passwordStrength.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                                right: 5,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "قوة كلمة المرور: $passwordStrength",
                                  style: TextStyle(
                                    color: passwordStrengthColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          if (passwordStrength == "ضعيفة")
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.85,
                                  child: Checkbox(
                                    value: acceptWeakPassword,
                                    activeColor: const Color(0xFF8BC34A),
                                    onChanged: (value) {
                                      setState(() {
                                        acceptWeakPassword = value!;
                                      });
                                    },
                                  ),
                                ),
                                const Expanded(
                                  child: Text(
                                    "أوافق على استخدام كلمة مرور ضعيفة",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          buildInput(
                            hint: "تأكيد كلمة المرور",
                            icon: Icons.lock_outline,
                            controller: confirmPasswordController,
                            isPassword: true,
                            obscure: obscureConfirm,
                            toggle: () {
                              setState(() {
                                obscureConfirm = !obscureConfirm;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8BC34A),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : const Text(
                                "إنشاء الحساب",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(color: Colors.grey[300]),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text("أو"),
                              ),
                              Expanded(
                                child: Divider(color: Colors.grey[300]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: OutlinedButton(
                              onPressed: isLoading ? null : signInWithGoogle,
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.g_mobiledata_rounded,
                                    size: 34,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      "المتابعة عبر قوقل",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}