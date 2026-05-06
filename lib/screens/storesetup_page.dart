import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_page.dart';
import 'templates_page.dart';

class StoreSetupPage extends StatefulWidget {
@override
_StoreSetupPageState createState() => _StoreSetupPageState();
}

class _StoreSetupPageState extends State<StoreSetupPage> {

final nameController = TextEditingController();
final bioController = TextEditingController();

String? selectedCategory;
File? imageFile;

bool isLoading = false;

final List<String> categories = [
"أزياء",
"طعام",
"حِرف",
"أخرى"
];

// 📸 اختيار صورة
Future pickImage() async {
final picked = await ImagePicker().pickImage(
source: ImageSource.gallery,
);

if (picked != null) {
setState(() {
imageFile = File(picked.path);
});
}
}

// ☁️ رفع الصورة
Future<String> uploadImage(String uid) async {
final ref = FirebaseStorage.instance
    .ref()
    .child("store_logos/$uid.jpg");

await ref.putFile(imageFile!);
return await ref.getDownloadURL();
}

// 💾 حفظ البيانات
Future saveStore() async {

if (nameController.text.isEmpty ||
selectedCategory == null ||
imageFile == null) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text("اكمل جميع البيانات")),
);
return;
}

setState(() => isLoading = true);

try {
final user = FirebaseAuth.instance.currentUser!;

final imageUrl = await uploadImage(user.uid);

await FirebaseFirestore.instance
    .collection('stores')
    .doc(user.uid)
    .set({
'storeName': nameController.text.trim(),
'bio': bioController.text.trim(),
'category': selectedCategory,
'logo': imageUrl,
'ownerId': user.uid,
'createdAt': Timestamp.now(),
});

await FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .update({
'storeCompleted': true,
});

Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => TemplatesPage()),
);

} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text("حدث خطأ")),
);
}

setState(() => isLoading = false);
}

Widget field({required Widget child}) {
return Container(
padding: EdgeInsets.symmetric(horizontal: 15),
decoration: BoxDecoration(
color: Color(0xFFDDE6C8),
borderRadius: BorderRadius.circular(15),
),
child: child,
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xFFF6F6F6),

body: Center(
child: Padding(
padding: EdgeInsets.all(16),
child: Container(
padding: EdgeInsets.all(20),
decoration: BoxDecoration(
color: Colors.grey[300],
borderRadius: BorderRadius.circular(30),
),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [

Text(
"البيانات الأساسية",
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Color(0xFF2F4F4F)),
),

SizedBox(height: 20),

Align(
alignment: Alignment.centerRight,
child: Text("اسم المتجر:"),
),

field(
child: TextField(
controller: nameController,
decoration: InputDecoration(border: InputBorder.none),
),
),

SizedBox(height: 15),

Align(
alignment: Alignment.centerRight,
child: Text("تصنيف المتجر:"),
),

field(
child: DropdownButtonFormField(
value: selectedCategory,
hint: Text("اختر"),
items: categories.map((cat) {
return DropdownMenuItem(
value: cat,
child: Text(cat),
);
}).toList(),
onChanged: (value) {
setState(() {
selectedCategory = value as String;
});
},
decoration: InputDecoration(
border: InputBorder.none,
),
),
),

SizedBox(height: 15),

Align(
alignment: Alignment.centerRight,
child: Text("نبذة عن المتجر:"),
),

field(
child: TextField(
controller: bioController,
decoration: InputDecoration(border: InputBorder.none),
),
),

SizedBox(height: 15),

Align(
alignment: Alignment.centerRight,
child: Text("اختر أيقونة للمتجر:"),
),

GestureDetector(
onTap: pickImage,
child: Container(
height: 50,
decoration: BoxDecoration(
color: Color(0xFFCBE7A6),
borderRadius: BorderRadius.circular(15),
),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Padding(
padding: EdgeInsets.symmetric(horizontal: 10),
child: Icon(Icons.image),
),
Padding(
padding: EdgeInsets.symmetric(horizontal: 10),
child: Text(
imageFile == null
? "اختيار صورة"
    : "تم اختيار صورة ✔",
),
),
],
),
),
),

SizedBox(height: 25),

Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [

// 🔙 السابق
ElevatedButton(
onPressed: () {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => RegisterPage(role: "store")),
);
},
style: ElevatedButton.styleFrom(
backgroundColor: Color(0xFF8BC34A),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
child: Text("← السابق"),
),

// ➡ التالي
ElevatedButton(
onPressed: isLoading ? null : saveStore,
style: ElevatedButton.styleFrom(
backgroundColor: Color(0xFF8BC34A),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
child: isLoading
? SizedBox(
width: 20,
height: 20,
child: CircularProgressIndicator(
color: Colors.white,
strokeWidth: 2),
)
    : Text("التالي →"),
),
],
)
],
),
),
),
),
);
}
}
