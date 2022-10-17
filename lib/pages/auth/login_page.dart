import 'package:firechat/shared/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login'),
            kVerticalSpaceM,
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Email',
                filled: true,
              ),
            ),
            kVerticalSpaceM,
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Password',
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
