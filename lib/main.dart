import 'package:firebase_core/firebase_core.dart';
import 'package:firechat/pages/auth/login_page.dart';
import 'package:firechat/pages/homepage/homepage.dart';
import 'package:firechat/service/sf_services.dart';
import 'package:firechat/shared/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: ConstantValue.apiKey,
        appId: ConstantValue.appId,
        messagingSenderId: ConstantValue.messagingSenderId,
        projectId: ConstantValue.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isUser = false;

  @override
  void initState() {
    super.initState();

    getUserLoggedInStatus();
  }

  void getUserLoggedInStatus() {
    SharedPrefServices.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isUser = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isUser ? const HomePage() : const LoginPage(),
    );
  }
}
