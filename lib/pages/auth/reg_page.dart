import 'package:firechat/pages/auth/login_page.dart';
import 'package:firechat/shared/ui_helper.dart';
import 'package:flutter/material.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
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
              const Text('Registration'),
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
