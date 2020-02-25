import 'package:flutter/material.dart';

class SkillsCandidate extends StatefulWidget {
  final List candidate;

  SkillsCandidate(this.candidate);

  @override
  _SkillsCandidateState createState() => _SkillsCandidateState();
}

class _SkillsCandidateState extends State<SkillsCandidate> {
  _buildSkillItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10.0, bottom: 5.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 15.0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
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
              padding: EdgeInsets.only(left: 18.0, top: 20.0, bottom: 5.0),
              child: Text(
                'Habilidades'.toUpperCase(),
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
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: candidate.length,
          itemBuilder: (_, i) {
            return _buildSkillItem(candidate[i]);
          },
        ),
      ],
    );
  }
}
