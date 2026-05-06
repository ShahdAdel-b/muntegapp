import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'storesetup_page.dart';

class EmailVerificationPage extends StatefulWidget {
  @override
  _EmailVerificationPageState createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {

  User? user;
  Timer? timer;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    // 🔥 تحقق تلقائي كل 3 ثواني
    timer = Timer.periodic(
      Duration(seconds: 3),
          (_) => checkEmailVerified(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // 🔥 الدالة الأساسية
  Future checkEmailVerified() async {
    if (isLoading) return;

    try {
      await user?.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user != null && user!.emailVerified) {

        setState(() => isLoading = true);
        timer?.cancel();

        // 🧠 نجيب بيانات المستخدم
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        final data = doc.data();

        // ✅ نضمن وجود role
        final role = (data != null && data.containsKey('role'))
            ? data['role']
            : 'user';

        // 🔀 التوجيه حسب الدور
        if (role == 'store') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => StoreSetupPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        }
      }

    } catch (e) {
      print("Verification error: $e"); // 👈 مهم للتشخيص
    }
  }

  Future resendEmail() async {
    try {
      await user?.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم إعادة إرسال الإيميل")),
      );
    } catch (e) {
      print("Resend error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),

      body: Column(
        children: [

          // 🔶 الهيدر
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Color(0xFFB8D77A),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFF8FBF6B),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 40),

          Icon(Icons.mark_email_read,
              size: 80, color: Color(0xFF8BC34A)),

          SizedBox(height: 20),

          Text(
            "تحقق من بريدك الإلكتروني",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),

          Text(
            "افتح الإيميل واضغط الرابط ✉️\nوسيتم تحويلك تلقائيًا",
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 30),

          isLoading
              ? CircularProgressIndicator(color: Color(0xFF8BC34A))
              : ElevatedButton(
            onPressed: checkEmailVerified,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8BC34A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              minimumSize: Size(200, 45),
            ),
            child: Text("تحققت"),
          ),

          SizedBox(height: 15),

          TextButton(
            onPressed: resendEmail,
            child: Text("إعادة إرسال الإيميل"),
          ),
        ],
      ),
    );
  }
}