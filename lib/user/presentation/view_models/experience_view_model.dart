import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_opportunity/user/domain/models/experience.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ExperienceViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = const Uuid();

  // Get Experiences
  Future<List<ExperienceModel?>?> getUserExperiences() async {
    User currentUser = _auth.currentUser!;
    List<ExperienceModel?>? experiences;

    try {
      QuerySnapshot snapshot = await _firestore
          .collection("experiences")
          .where("userId", isEqualTo: currentUser.uid)
          .get();

      experiences = snapshot.docs.map((e) => ExperienceModel.fromSnap(e)).toList();
    } catch(error) {
      debugPrint(error.toString());
      experiences = null;
    }

    return experiences;
  }

  // Add Experience
  Future<bool> addExperience({
    required String company,
    required String jobTitle,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    bool successful = false;
    User currentUser = _auth.currentUser!;

    try {
      CollectionReference experiences = _firestore.collection("experiences");

      await experiences.add({
        "id": uuid.v4(),
        "userId": currentUser.uid,
        "company": company,
        "jobTitle": jobTitle,
        "description": description,
        "startDate": startDate,
        "endDate": endDate
      });

      successful = true;
    } catch(error) {
      successful = false;
    }

    return successful;
  }

  // Update Experience
  Future<bool> updateExperience({
    required String id,
    required String company,
    required String jobTitle,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    bool successful = false;
    User currentUser = _auth.currentUser!;

    try {
      ExperienceModel experience = ExperienceModel(
        id: id,
        userId: currentUser.uid,
        company: company,
        jobTitle: jobTitle,
        description: description,
        startDate: startDate,
        endDate: endDate
      );

      await _firestore.collection("users").doc(id).set(experience.toJson());
      successful = true;
    } catch(error) {
      successful = false;
    }
    return successful;
  }

  // Delete Experience
  Future<bool> deleteExperience({required String id}) async {
    bool successful = false;

    try {
      CollectionReference experiences = _firestore.collection("experiences");
      await experiences.doc(id).delete();
      successful = true;
    } catch(error) {
      successful = false;
    }
    return successful;
  }
}