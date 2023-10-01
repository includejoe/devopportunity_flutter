import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_opportunity/user/domain/models/experience.dart';

class ResumeModel {
  final String id;
  final String userId;
  final String summary;
  final List<ExperienceModel> experiences;

  const ResumeModel({
    required this.id,
    required this.userId,
    required this.summary,
    required this.experiences,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "summary": summary,
    "experiences": experiences
  };

  static ResumeModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ResumeModel (
      id: snapshot["id"],
      userId: snapshot["userId"],
      summary: snapshot["summary"],
      experiences: snapshot["experiences"].map((e) => ExperienceModel.fromSnap(e)).toList()
    );
  }
}