import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/auth/splash_screen.dart';
import 'screens/auth/login_page.dart';
import 'screens/auth/register_page.dart';
import 'screens/auth/email_verification_page.dart';
import 'screens/auth/role_selection_page.dart';
import 'screens/auth/home_page.dart';
import 'screens/auth/profile_page.dart';

import 'screens/setup_store/store_info_screen.dart';

import 'screens/templates/template_selection_screen.dart';
import 'screens/templates/preview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, dynamic> defaultTemplate = {
    'name': 'قالب عادي',
    'layout_type': 'grid',
    'desc': 'عرض شبكي منظم للمنتجات',
  };

  final Map<String, dynamic> defaultStoreData = {
    'storeName': 'متجري',
    'description': 'وصف المتجر',
    'category': 'منتجات',
  };

  final Map<String, dynamic> defaultCustomization = {
    'primaryColor': 0xFF2E6B4E,
    'secondaryColor': 0xFFFFC857,
    'backgroundColor': 0xFFF7F5F0,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Montag App',

      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => SplashScreen(),

        '/login': (context) => LoginPage(),

        '/register': (context) => RegisterPage(
          role: 'user',
        ),

        '/email-verification': (context) => EmailVerificationPage(),

        '/role-selection': (context) => RoleSelectionPage(),

        '/home': (context) => HomePage(),

        '/profile': (context) => ProfilePage(),

        '/store-info': (context) => StoreInfoScreen(),

        '/template-selection': (context) => TemplateSelectionScreen(
          storeData: defaultStoreData,
        ),


        '/preview': (context) => PreviewScreen(
          template: defaultTemplate,
          storeData: defaultStoreData,
          customization: defaultCustomization,
        ),
      },
    );
  }
}