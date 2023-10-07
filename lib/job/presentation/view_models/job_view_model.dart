import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_opportunity/job/domain/models/job.dart';
import 'package:dev_opportunity/user/domain/models/experience.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class JobViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = const Uuid();

  // Get All Jobs
  Future<List<JobModel?>?> getAllJobs() async {
    List<JobModel?>? jobs;

    try {
      QuerySnapshot snapshot = await _firestore
        .collection("jobs")
        .orderBy("timestamp", descending: true)
        .get();
      jobs = snapshot.docs.map((e) => JobModel.fromSnap(e)).toList();

    } catch(error) {
      debugPrint(error.toString());
      jobs = null;
    }

    return jobs;
  }

  // Get User Jobs Posted
  Future<List<JobModel?>?> getUserJobsPosted(String userId) async {
    List<JobModel?>? jobs;

    try {
        QuerySnapshot snapshot = await _firestore
          .collection("jobs")
          .where("userId", isEqualTo: userId)
          .orderBy("timestamp", descending: true)
          .get();
        jobs = snapshot.docs.map((e) => JobModel.fromSnap(e)).toList();
    } catch(error) {
      debugPrint(error.toString());
      jobs = null;
    }

    return jobs;
  }

  // Add Job
  Future<bool> addJob({
    String? id,
    required String companyName,
    required String jobTitle,
    required String description,
    required String skillsRequired,
    required String location,
    required String type,
    required String experienceLevel,
    required bool opened,
    String? userProfilePic,
  }) async {
    bool successful = false;
    User currentUser = _auth.currentUser!;

    try {
      CollectionReference jobs = _firestore.collection("jobs");
      final newId = uuid.v4();

      // if id is not null, then we are updating the document
      await jobs.doc(id ?? newId).set({
        "id": id ?? newId,
        "userId": currentUser.uid,
        "companyName": companyName,
        "jobTitle": jobTitle,
        "description": description,
        "skillsRequired": skillsRequired,
        "location": location,
        "type": type,
        "experienceLevel": experienceLevel,
        "opened": opened,
        "userProfilePic": userProfilePic,
        "datePosted": DateTime.now().toString(),
        "timestamp": FieldValue.serverTimestamp()
      }, SetOptions(merge: true));

      successful = true;
    } catch(error) {
      successful = false;
    }

    return successful;
  }

  // Update Open Status
  Future<bool> updateJobOpened({
    required String id,
    required bool opened,
  }) async {
    bool successful = false;

    try {
      CollectionReference jobs = _firestore.collection("jobs");

      // if id is not null, then we are updating the document
      await jobs.doc(id).set({
        "opened": opened,
        "timestamp": FieldValue.serverTimestamp()
      }, SetOptions(merge: true));

      successful = true;
    } catch(error) {
      successful = false;
    }

    return successful;
  }

  // Delete Job
  Future<bool> deleteExperience({required String id}) async {
    bool successful = false;

    try {
      CollectionReference jobs = _firestore.collection("jobs");
      await jobs.doc(id).delete();
      successful = true;
    } catch(error) {
      successful = false;
    }
    return successful;
  }
}