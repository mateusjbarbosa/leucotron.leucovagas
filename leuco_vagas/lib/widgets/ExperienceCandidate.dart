import 'dart:collection';

import 'package:flutter/material.dart';

class ExperienceCandidate extends StatefulWidget {
  final List candidate;

  ExperienceCandidate(this.candidate);

  @override
  _ExperienceCandidateState createState() => _ExperienceCandidateState();
}

class _ExperienceCandidateState extends State<ExperienceCandidate> {
  _buildExperienceItem(LinkedHashMap experience) {
    return Padding(
      padding: EdgeInsets.only(left: 2.0),
      child: ListTile(
        title: Text(
          experience['company'],
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          experience['job'] + ' | ' + experience['duration'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List candidate = widget.candidate;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 18.0, top: 30.0, bottom: 5.0),
              child: Text(
                'Experiência'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: candidate.length,
          itemBuilder: (_, i) {
            return _buildExperienceItem(candidate[i]);
          },
        ),
      ],
    );
  }
}
