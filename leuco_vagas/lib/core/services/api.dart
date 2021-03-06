import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leuco_vagas/core/models/Candidate.dart';

import 'package:leuco_vagas/core/models/Job.dart';

class Api {
  Firestore _db = Firestore.instance;

  void createJob(
    String name,
    String role,
    List<String> requirements,
    List<String> skills,
  ) async {
    Job job = Job(
      name: name,
      role: role,
      requirements: requirements,
      skills: skills,
    );

    await _db.collection('jobs').add(job.toJson());
  }

  void createCandidate(
    String jobId,
    String name,
    String age,
    String course,
    String college,
    List<dynamic> emails,
    List<dynamic> cellphones,
    List<dynamic> experience,
    List<dynamic> skills,
  ) async {
    Candidate candidate = Candidate(
      jobId: jobId,
      name: name,
      age: age,
      course: course,
      college: college,
      emails: emails,
      cellphones: cellphones,
      experience: experience,
      skills: skills,
    );

    await _db.collection('candidates').add(candidate.toJson());
  }

  Stream<QuerySnapshot> streamJobs() {
    return _db.collection('jobs').snapshots();
  }

  Stream<QuerySnapshot> streamCandidates(String job) {
    return _db
        .collection('candidates')
        .where('jobId', isEqualTo: job)
        .snapshots();
  }

  void updateJob(
    String id,
    String name,
    String role,
    List<String> requirements,
    List<String> skills,
  ) async {
    Job job = Job(
      id: id,
      name: name,
      role: role,
      requirements: requirements,
      skills: skills,
    );

    await _db.collection('jobs').document(job.id).updateData(job.toJson());
  }

  void updateCandidate(
    String id,
    String jobId,
    String name,
    String age,
    String course,
    String college,
    List<dynamic> emails,
    List<dynamic> cellphones,
    List<dynamic> experience,
    List<dynamic> skills,
  ) async {
    Candidate candidate = Candidate(
      id: id,
      jobId: jobId,
      name: name,
      age: age,
      course: course,
      college: college,
      emails: emails,
      cellphones: cellphones,
      experience: experience,
      skills: skills,
    );

    await _db
        .collection('candidates')
        .document(candidate.id)
        .updateData(candidate.toJson());
  }

  void deleteJob(String id) async {
    await _db.collection('jobs').document(id).delete();
  }

  void deleteCandidate(String id) async {
    await _db.collection('candidates').document(id).delete();
  }

  void reAddJob(Job job) async {
    await _db.collection('jobs').document(job.id).setData(job.toJson());
  }

  void reAddCandidate(Candidate candidate) async {
    await _db.collection('candidates').document(candidate.id).setData(
          candidate.toJson(),
        );
  }
}
