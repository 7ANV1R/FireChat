import 'package:firechat/pages/auth/login_page.dart';
import 'package:firechat/pages/homepage/homepage.dart';
import 'package:firechat/service/auth_service.dart';
import 'package:firechat/service/sf_services.dart';
import 'package:firechat/shared/ui_helper.dart';
import 'package:firechat/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  bool _isLoading = false;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();
  SharedPrefServices sharedPrefServices = SharedPrefServices();

  register({required String fullName, required String email, required String password}) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authServices.regWithEmailPass(fullName, email, password).then((value) {
        if (value == true) {
          // save sf
          sharedPrefServices.setUserLoggedInStatus(isLoggedIn: true);
          sharedPrefServices.setUserName(userName: fullName);
          sharedPrefServices.setUserEmail(userEmail: email);

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
                    const Text('Registration'),
                    kVerticalSpaceM,
                    TextFormField(
                      controller: nameTextController,
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    kVerticalSpaceM,
                    TextFormField(
                      controller: emailTextController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password can\'t be empty';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    kVerticalSpaceM,
                    ElevatedButton(
                      onPressed: () {
                        register(
                          fullName: nameTextController.text,
                          email: emailTextController.text,
                          password: passTextController.text,
                        );
                      },
                      child: const Text('Sign up'),
                    ),
                    Row(
                      children: [
                        const Text('Already user?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text('log in'),
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
