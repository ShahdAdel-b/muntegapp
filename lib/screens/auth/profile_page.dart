import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final user = FirebaseAuth.instance.currentUser;

  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  // 📥 تحميل البيانات (FIXED 🔥)
  Future loadUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;

        usernameController.text = data['username'] ?? '';
        bioController.text = data['bio'] ?? '';
      }
    } catch (e) {
      print("Error loading profile: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  // 💾 حفظ التعديلات
  Future saveData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'username': usernameController.text.trim(),
        'bio': bioController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم حفظ التعديلات ✅")),
      );

    } catch (e) {
      print("Error saving: $e");
    }
  }

  // 🔤 حقل إدخال جميل
  Widget input(String hint, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),

      body: Column(
        children: [

          // 🔶 الهيدر الليموني
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color(0xFFB8D77A),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [

                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFF8FBF6B),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                  ),
                ),

                // 👤 صورة البروفايل
                Positioned(
                  bottom: 30,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF8BC34A),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Text(
            "البروفايل",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            user?.email ?? "",
            style: TextStyle(color: Colors.grey[700]),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [

                input("اسم المستخدم", usernameController),
                input("نبذة عنك", bioController),

                SizedBox(height: 20),

                // 💾 زر حفظ
                ElevatedButton(
                  onPressed: saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8BC34A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size(double.infinity, 50),
                    elevation: 4,
                  ),
                  child: Text(
                    "حفظ التغييرات",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // 🔙 رجوع
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    "رجوع",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}