import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/service/database_service.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //reg

  Future regWithEmailPass(String fullName, String email, String password) async {
    try {
      //something

      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;
      // if (user != null) {
      // add user to database
      await DatabaseServices(uid: user.uid).updateUserData(fullName, email);

      return true;
      // }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return e.message;
    }
  }

  //login

  //logout

  Future signOut() async {
    await firebaseAuth.signOut();
  }
}
