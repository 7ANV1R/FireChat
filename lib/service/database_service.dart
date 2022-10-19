import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;

  DatabaseServices({this.uid});

  // collection ref
  final CollectionReference userCollectionRef = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollectionRef = FirebaseFirestore.instance.collection("groups");

  // updating user data

  Future updateUserData(String fullName, String email) async {
    return userCollectionRef.doc(uid).set({
      "uid": uid,
      "fullName": fullName,
      "email": email,
      "profileImage":
          "https://images.contentstack.io/v3/assets/bltb6530b271fddd0b1/bltc825c6589eda7717/5eb7cdc6ee88132a6f6cfc25/V_AGENTS_587x900_Viper.png",
      "groups": [],
    });
  }
}
