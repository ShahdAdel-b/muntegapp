
import 'package:flutter/material.dart';
import 'home_page.dart';

class TemplatesPage extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xFFF6F6F6),

body: Column(
children: [

// 🔶 الهيدر الليموني
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

SizedBox(height: 30),

// 🧠 العنوان
Text(
"اختر قالب متجرك",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 20),

// 🧱 Templates مؤقتة
Expanded(
child: ListView(
padding: EdgeInsets.symmetric(horizontal: 20),
children: [

templateCard("قالب بسيط", Icons.storefront),
templateCard("قالب عصري", Icons.design_services),
templateCard("قالب احترافي", Icons.workspace_premium),

],
),
),

// ⬇ زر إكمال
Padding(
padding: EdgeInsets.all(20),
child: ElevatedButton(
onPressed: () {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => HomePage()),
);
},
style: ElevatedButton.styleFrom(
backgroundColor: Color(0xFF8BC34A),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(25),
),
minimumSize: Size(double.infinity, 50),
),
child: Text(
"متابعة إلى التطبيق",
style: TextStyle(color: Colors.white),
),
),
)
],
),
);
}

// 🎨 كارد القالب
Widget templateCard(String title, IconData icon) {
return Container(
margin: EdgeInsets.only(bottom: 15),
padding: EdgeInsets.all(20),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
boxShadow: [
BoxShadow(
color: Colors.black12,
blurRadius: 10,
offset: Offset(0, 5),
)
],
),
child: Row(
children: [
Icon(icon, size: 30, color: Color(0xFF8BC34A)),
SizedBox(width: 15),
Text(
title,
style: TextStyle(fontSize: 16),
),
],
),
);
}
}

