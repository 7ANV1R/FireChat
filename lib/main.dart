import 'package:firebase_core/firebase_core.dart';
import 'package:firechat/pages/auth/login_page.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
