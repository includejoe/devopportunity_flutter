import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_opportunity/base/utils/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';

class UserViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get User Details
  Future<UserModel?> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore
        .collection("users")
        .doc(currentUser.uid)
        .get();

    return UserModel.fromSnap(snapshot);
  }

  // Register New User
  Future<bool> registerUser({
    required String email,
    required String password,
    required String name,
    required String headline,
  }) async {
    bool successful = false;

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

      successful = true;
    } catch(error) {
      successful = false;
    }

    return successful;
  }

  // Login User
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    bool successful = false;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      successful = true;
    } catch (error) {
      successful = false;
    }

    return successful;
  }

  // Update User
  Future<bool> updateUser({
    required String name,
    required String headline,
    required String bio,
    required String? imageUrl,
    Uint8List? profileImage
  }) async {
    bool successful = false;

    if (profileImage != null) {
      imageUrl = await StorageMethods().uploadImageToStorage("profile_pics", profileImage, false);
    }

    UserModel user = UserModel(
      email: _auth.currentUser!.email!,
      uid: _auth.currentUser!.uid,
      name: name,
      headline: headline,
      bio: bio,
      profilePic: imageUrl
    );

    try {
      await _firestore.collection("users").doc(_auth.currentUser!.uid).set(user.toJson());
      successful = true;
    } catch(error) {
      successful = false;
    }
    return successful;
  }

  // Sign Out
  Future<bool> signOut() async {
    bool successful = false;

    try {
      await _auth.signOut();
      successful = true;
    } catch(error) {
      successful = false;
    }

    return successful;
  }
}