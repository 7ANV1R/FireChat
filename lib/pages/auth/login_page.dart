import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/pages/auth/reg_page.dart';
import 'package:firechat/pages/homepage/homepage.dart';
import 'package:firechat/service/auth_service.dart';
import 'package:firechat/service/database_service.dart';
import 'package:firechat/service/sf_services.dart';
import 'package:firechat/shared/ui_helper.dart';
import 'package:firechat/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();
  SharedPrefServices sharedPrefServices = SharedPrefServices();

  login({required String email, required String password}) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authServices.loginWithEmailPass(email, password).then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).getUserData(email);
          // save sf
          sharedPrefServices.setUserLoggedInStatus(isLoggedIn: true);
          sharedPrefServices.setUserName(userName: snapshot.docs[0]['fullName']);
          sharedPrefServices.setUserEmail(userEmail: email);

          if (!mounted) return;

          // nav
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));

          setState(() {
            _isLoading = false;
          });
        } else {
          showGeneralSnakbar(
            context: context,
            message: value,
            backgroundColor: Colors.red,
          );
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Login'),
                    kVerticalSpaceM,
                    TextFormField(
                      controller: emailTextController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    kVerticalSpaceM,
                    TextFormField(
                      controller: passTextController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        filled: true,
                      ),
                    ),
                    kVerticalSpaceM,
                    ElevatedButton(
                      onPressed: () {
                        login(email: emailTextController.text, password: passTextController.text);
                      },
                      child: const Text('Login'),
                    ),
                    Row(
                      children: [
                        const Text('New user?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegPage(),
                              ),
                            );
                          },
                          child: const Text('sign up'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
