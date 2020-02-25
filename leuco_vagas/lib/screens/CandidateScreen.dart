import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:leuco_vagas/widgets/AboutCandidate.dart';
import 'package:leuco_vagas/widgets/ExperienceCandidate.dart';

class CandidateScreen extends StatefulWidget {
  final DocumentSnapshot candidate;

  CandidateScreen(this.candidate);

  @override
  _CandidateScreenState createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> candidate = widget.candidate.data;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.candidate.data['name'].toUpperCase(),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Column(
        children: <Widget>[
          AboutCandidate(candidate['about']),
          ExperienceCandidate(candidate['experience']),
        ],
      ),
    );
  }
}
