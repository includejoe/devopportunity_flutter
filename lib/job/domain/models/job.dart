import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';

class JobModel {
  final String id;
  final UserModel user;
  final String jobTitle;
  final String description;
  final String skillsRequired;
  final String onSiteRemote;
  final String datePosted;
  final String experienceLevel;

  const JobModel({
    required this.id,
    required this.user,
    required this.jobTitle,
    required this.description,
    required this.skillsRequired,
    required this.onSiteRemote,
    required this.datePosted,
    required this.experienceLevel,
  });

  static JobModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return JobModel (
      id: snapshot["id"],
      user: UserModel.fromSnap(snapshot["user"]),
      jobTitle: snapshot["jobTitle"],
      description: snapshot["description"],
      skillsRequired: snapshot["skillsRequired"],
      onSiteRemote: snapshot["onSiteRemote"],
      datePosted: snapshot["datePosted"],
      experienceLevel: snapshot["experienceLevel"],
    );
  }
}