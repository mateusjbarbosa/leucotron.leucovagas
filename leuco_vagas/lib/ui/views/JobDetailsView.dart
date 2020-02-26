import 'package:flutter/material.dart';

import 'package:leuco_vagas/core/models/Candidate.dart';
import 'package:leuco_vagas/core/models/Job.dart';

import 'package:leuco_vagas/core/services/api.dart';
import 'package:leuco_vagas/ui/views/CreateCandidateView.dart';

class JobDetailsView extends StatefulWidget {
  final Job job;

  JobDetailsView(this.job);

  @override
  _JobDetailsViewState createState() => _JobDetailsViewState();
}

class _JobDetailsViewState extends State<JobDetailsView> {
  Api _api = Api();

  Job _job = Job();

  List<dynamic> _candidates;

  Widget _detailJob(String field, IconData icon, List<dynamic> data) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18.0, top: 15.0),
          child: Row(
            children: <Widget>[
              Text(
                field.toUpperCase(),
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
                    icon,
                    color: Theme.of(context).primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      data[i],
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
    _job = widget.job;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _job.name,
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
            _detailJob('Requisitos', Icons.school, _job.requirements),
            _detailJob('Habilidades desejadas', Icons.code, _job.skills),
            Padding(
              padding: EdgeInsets.only(left: 18.0, top: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Candidatos'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: _api.streamCandidates(),
              initialData: _candidates,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _candidates = snapshot.data.documents
                      .map((doc) => Candidate.fromMap(doc.data, doc.documentID))
                      .toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _candidates.length,
                    itemBuilder: (context, i) => ListTile(
                      title: Text(
                        _candidates[i].name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _candidates[i].course,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateCandidateView())),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
    );
  }
}
