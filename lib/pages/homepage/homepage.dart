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

  @override
  void initState() {
    super.initState();

    getUserInfo();
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
            onPressed: () {},
            child: const Text('LogOut'),
          ),
        ],
      ),
    );
  }
}
