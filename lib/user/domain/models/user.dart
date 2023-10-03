import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String email;
  late final String uid;
  late final String name;
  late final String headline;
  late final String? bio;
  late final String? skills;
  late final String? profilePic;

  UserModel({
    required this.email,
    required this.uid,
    required this.name,
    required this.headline,
    this.bio,
    this.skills,
    this.profilePic,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "email": email,
    "profilePic": profilePic,
    "bio": bio,
    "skills": skills,
    "headline": headline
  };

  UserModel.fromJson(dynamic json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    headline = json['headline'];
    bio = json['bio'];
    skills = json['skills'];
    profilePic = json['profilePic'];
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel (
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      profilePic: snapshot["profilePic"],
      bio: snapshot["bio"],
      skills: snapshot["skills"],
      headline: snapshot["headline"]
    );
  }
}