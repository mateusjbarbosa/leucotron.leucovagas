import 'package:flutter/material.dart';

import 'package:leuco_vagas/core/models/Candidate.dart';

class CandidateDetailsView extends StatefulWidget {
  final Candidate candidate;

  CandidateDetailsView(this.candidate);

  @override
  _CandidateDetailsViewState createState() => _CandidateDetailsViewState();
}

class _CandidateDetailsViewState extends State<CandidateDetailsView> {
  Candidate _candidate = Candidate();

  Widget _aboutCandidate(List<dynamic> data) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18.0, top: 15.0),
          child: Row(
            children: <Widget>[
              Text(
                'Sobre'.toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (_, i) {
            return Padding(
              padding: EdgeInsets.only(left: 18.0, top: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    data[i][1],
                    color: Theme.of(context).primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      data[i][0],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    _candidate = widget.candidate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _candidate.name,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _aboutCandidate(
              [
                [_candidate.name, Icons.account_circle],
                [_candidate.age, Icons.cake],
                [_candidate.course, Icons.library_books],
                [_candidate.college, Icons.school],
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0, top: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Experiência'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _candidate.experience.length,
              itemBuilder: (_, i) {
                return ListTile(
                  title: Text(
                    _candidate.experience[i]['company'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _candidate.experience[i]['job'] +
                        ' | ' +
                        _candidate.experience[i]['duration'],
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0, top: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Habilidades'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _candidate.skills.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.code,
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          _candidate.skills[i],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
