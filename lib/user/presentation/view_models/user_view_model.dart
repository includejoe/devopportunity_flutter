import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';

class UserViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get User Details
  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot = await _firestore
        .collection("users")
        .doc(currentUser.uid)
        .get();

    return UserModel.fromSnap(snapshot);
  }

  // Register New User
  Future<String> registerUser({
    required String email,
    required String password,
    required String name,
    required String headline,
  }) async {
    String response = "";
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      UserModel user = UserModel(
          email: email,
          uid: credentials.user!.uid,
          name: name,
          headline: headline
      );

      await _firestore.collection("users").doc(credentials.user!.uid).set(user.toJson());

      response = "success";
    } on FirebaseAuthException catch(error) {
      if(error.code == "invalid-email") {
        response = "Your email is not a valid email";
      } else if(error.code == "weak-password") {
        response = "Your password must be 6 characters or more";
      }
    } catch(error) {
      response = error.toString();
    }

    return response;
  }

  // Login User
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String response = "";

    try {
      if(email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        response = "success";
      }
    } on FirebaseAuthException catch(error) {
      if(error.code == "wrong-password") {
        response = "Invalid Credentials";
      } else if(error.code == "user-not-found") {
        response = "Invalid Credentials";
      }
    } catch (error) {
      response = error.toString();
    }

    return response;
  }
}