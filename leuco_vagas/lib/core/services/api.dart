import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:leuco_vagas/core/models/Job.dart';

class Api {
  Firestore _db = Firestore.instance;

  void createJob(String name, String role, List<String> requirements,
      List<String> skills) async {
    Job job =
        Job(name: name, role: role, requirements: requirements, skills: skills);

    await _db.collection('jobs').add(job.toJson());
  }

  Stream<QuerySnapshot> streamJobs() {
    return _db.collection('jobs').snapshots();
  }

  void updateJob(String id, String name, String role, List<String> requirements,
      List<String> skills) async {
    Job job = Job(
      id: id,
      name: name,
      role: role,
      requirements: requirements,
      skills: skills,
    );

    await _db.collection('jobs').document(job.id).updateData(job.toJson());
  }

  void deleteJob(String id) async {
    await _db.collection('jobs').document(id).delete();
  }

  void reAddJob(Job job) async {
    await _db.collection('jobs').document(job.id).setData(job.toJson());
  }
}
