import 'package:flutter/material.dart';
import 'package:leuco_vagas/core/models/Candidate.dart';

class UpdateCandidateView extends StatefulWidget {
  final Candidate candidate;

  UpdateCandidateView(this.candidate);

  @override
  _UpdateCandidateViewState createState() => _UpdateCandidateViewState();
}

class _UpdateCandidateViewState extends State<UpdateCandidateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar candidato',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
    );
  }
}
