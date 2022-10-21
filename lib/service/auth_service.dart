import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/service/database_service.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //reg

  Future regWithEmailPass(String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;

      // add user to database
      await DatabaseServices(uid: user.uid).savingUserData(fullName, email);

      return true;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return e.message;
    }
  }

  //login

  Future loginWithEmailPass(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return e.message;
    }
  }

  //logout

  Future signOut() async {
    await firebaseAuth.signOut();
  }
}
