import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/pages/auth/login_page.dart';
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
    log('user email ${FirebaseAuth.instance.currentUser!.email!}');
    QuerySnapshot snapshot = await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserData(FirebaseAuth.instance.currentUser!.email!);
    log(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      _userImgPath = snapshot.docs[0]['profileImage'];
    });
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
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(
              height: 48,
            ),
            CircleAvatar(
              radius: 56,
              backgroundColor: Colors.grey,
              child: _userImgPath != ""
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: NetworkImage(_userImgPath),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.person),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              _userName,
              textAlign: TextAlign.center,
            ),
            Text(
              _userEmail,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {},
              selected: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: const Icon(Icons.groups),
              title: const Text('Groups'),
            ),
            ListTile(
              onTap: () {},
              selected: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: const Icon(Icons.account_box_rounded),
              title: const Text('Profile'),
            ),
            ListTile(
              onTap: () {},
              selected: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
            ),
          ],
        ),
      ),
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
