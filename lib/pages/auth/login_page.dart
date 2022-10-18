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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
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
                decoration: const InputDecoration(
                  hintText: 'Password',
                  filled: true,
                ),
              ),
              kVerticalSpaceM,
              ElevatedButton(
                onPressed: () {
                  formKey.currentState!.validate();
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
