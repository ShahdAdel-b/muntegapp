import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'email_verification_page.dart';
import 'role_selection_page.dart';
import '../setup_store/store_info_screen.dart';

class SplashScreen extends StatefulWidget {
@override
_SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
void initState() {
super.initState();

Timer(Duration(seconds: 3), () async {

User? user = FirebaseAuth.instance.currentUser;

// 👤 لو المستخدم موجود
if (user != null) {

// 🔄 نحدث بياناته
await user.reload();
user = FirebaseAuth.instance.currentUser;

// ✉️ لو تحقق الإيميل
if (user != null && user.emailVerified) {

try {
final doc = await FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .get();

final role = doc.data()?['role'] ?? 'customer';

// 🔀 التوجيه حسب الدور
if (role == 'store') {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => StoreInfoScreen()),
);
} else {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => HomePage()),
);
}

} catch (e) {
// لو صار خطأ نوديه للهوم احتياط
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => HomePage()),
);
}

} else {
// ❗ لم يتم التحقق من الإيميل
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => EmailVerificationPage()),
);
}

} else {
// 🚪 المستخدم غير مسجل
Navigator.pushReplacement(
context,
    MaterialPageRoute(builder: (_) => RoleSelectionPage()),
);
}

});
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xFFF6F6F6),
body: Center(
child: Text(
"MUNTEG",
style: TextStyle(
fontSize: 30,
fontWeight: FontWeight.bold,
color: Color(0xFF8BC34A),
),
),
),
);
}
}
