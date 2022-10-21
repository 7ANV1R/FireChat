import 'package:firechat/pages/auth/login_page.dart';
import 'package:firechat/service/auth_service.dart';
import 'package:firechat/service/sf_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = "";
  String _userEmail = "";
  AuthServices authServices = AuthServices();
  SharedPrefServices sharedPrefServices = SharedPrefServices();

  @override
  void initState() {
    super.initState();

    getUserInfo();
  }

  void signOut() async {
    sharedPrefServices.setUserEmail(userEmail: "");
    sharedPrefServices.setUserName(userName: "");
    sharedPrefServices.setUserLoggedInStatus(isLoggedIn: false);
    await authServices.signOut();
    // nav
    if (!mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }

  void getUserInfo() {
    SharedPrefServices.getUserEmail().then((value) {
      if (value != null) {
        setState(() {
          _userEmail = value;
        });
      }
    });
    SharedPrefServices.getUserName().then((value) {
      if (value != null) {
        setState(() {
          _userName = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_userName),
          Text(_userEmail),
          ElevatedButton(
            onPressed: signOut,
            child: const Text('LogOut'),
          ),
        ],
      ),
    );
  }
}
