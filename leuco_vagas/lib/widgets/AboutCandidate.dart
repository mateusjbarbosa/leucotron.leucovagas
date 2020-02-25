import 'dart:collection';

import 'package:flutter/material.dart';

class AboutCandidate extends StatefulWidget {
  final LinkedHashMap candidate;

  AboutCandidate(this.candidate);

  @override
  _AboutCandidateState createState() => _AboutCandidateState();
}

class _AboutCandidateState extends State<AboutCandidate> {
  _buildAboutItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10.0, bottom: 5.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 15.0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 18.0),
              child: Text(
                text,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LinkedHashMap candidate = widget.candidate;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 18.0, top: 10.0, bottom: 5.0),
              child: Text(
                'Sobre ele'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        _buildAboutItem(candidate['age'] + ' anos'),
        _buildAboutItem(candidate['course']),
        _buildAboutItem(candidate['college']),
        _buildAboutItem(candidate['email']),
        _buildAboutItem(candidate['cellphone']),
      ],
    );
  }
}
