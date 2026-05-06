import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      // 🟢 القائمة الجانبية
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8BC34A),
                Color(0xFFB8D77A),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: Column(
            children: [

              SizedBox(height: 60),

              // 👤 صورة
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: Icon(Icons.person,
                    size: 50, color: Color(0xFF8BC34A)),
              ),

              SizedBox(height: 15),

              Text(
                "اسم المستخدم",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),

              Text(
                user?.email ?? "",
                style: TextStyle(color: Colors.white70),
              ),

              SizedBox(height: 30),

              // 📄 البروفايل
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text("البروفايل",
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfilePage()),
                  );
                },
              ),

              // ✏️ تعديل
              ListTile(
                leading: Icon(Icons.edit, color: Colors.white),
                title: Text("تعديل البيانات",
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),

              Spacer(),

              // 🚪 تسجيل خروج
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text("تسجيل الخروج",
                    style: TextStyle(color: Colors.white)),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                        (route) => false,
                  );
                },
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),

      backgroundColor: Color(0xFFF6F6F6),

      body: Column(
        children: [

          // 🔶 الهيدر
          Stack(
            children: [
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

              // 🍔 زر القائمة (المهم!)
              Positioned(
                top: 50,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.menu,
                        color: Color(0xFF8BC34A)),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 30),

          Text(
            "مرحبًا 👋",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            user?.email ?? "",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),

          SizedBox(height: 30),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
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
                Icon(Icons.person, color: Color(0xFF8BC34A)),
                SizedBox(width: 10),
                Text("حسابك جاهز ✔"),
              ],
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
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
                "تسجيل الخروج",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}