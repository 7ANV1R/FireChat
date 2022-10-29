import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/pages/homepage/widget/app_drawer.dart';
import 'package:firechat/service/auth_service.dart';
import 'package:firechat/service/database_service.dart';
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
  String _userImgPath = "";
  AuthServices authServices = AuthServices();
  SharedPrefServices sharedPrefServices = SharedPrefServices();

  @override
  void initState() {
    super.initState();

    getUserInfo();
    getUserImg();
  }

  void getUserImg() async {
    QuerySnapshot snapshot = await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserData(FirebaseAuth.instance.currentUser!.email!);

    setState(() {
      _userImgPath = snapshot.docs[0]['profileImage'];
    });
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
      appBar: AppBar(
        title: const Text('All Conversation'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ))
        ],
      ),
      drawer: AppDrawer(userImgPath: _userImgPath, userName: _userName, userEmail: _userEmail),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_userName),
          Text(_userEmail),
        ],
      ),
    );
  }
}
