import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String name;
  final String headline;
  final String? bio;
  final String? profilePic;

  const UserModel({
    required this.email,
    required this.uid,
    required this.name,
    required this.headline,
    this.bio,
    this.profilePic,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "email": email,
    "profilePic": profilePic,
    "bio": bio,
    "headline": headline
  };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel (
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      profilePic: snapshot["profilePic"],
      bio: snapshot["bio"],
      headline: snapshot["headline"]
    );
  }
}