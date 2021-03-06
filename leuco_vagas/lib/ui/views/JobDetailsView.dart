import 'package:flutter/material.dart';

import 'package:leuco_vagas/core/models/Candidate.dart';
import 'package:leuco_vagas/core/models/Job.dart';

import 'package:leuco_vagas/core/services/api.dart';
import 'package:leuco_vagas/ui/views/CandidateDetailsView.dart';
import 'package:leuco_vagas/ui/views/CreateCandidateView.dart';
import 'package:leuco_vagas/ui/views/UpdateCandidateView.dart';

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
              stream: _api.streamCandidates(_job.id),
              initialData: _candidates,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _candidates = snapshot.data.documents
                      .map((doc) => Candidate.fromMap(doc.data, doc.documentID))
                      .toList();

                  if (_candidates.isEmpty) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                          'Não há candidatos!'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _candidates.length,
                      itemBuilder: (context, i) => Dismissible(
                        key: Key(DateTime.now().toString()),
                        direction: DismissDirection.horizontal,
                        onDismissed: (d) {
                          if (d == DismissDirection.startToEnd) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateCandidateView(_candidates[i])));
                          } else {
                            Candidate candidateTemp = _candidates[i];

                            _api.deleteCandidate(_candidates[i].id);

                            final snackbar = SnackBar(
                                content:
                                    Text("Candidato excluído com sucesso!"),
                                action: SnackBarAction(
                                    label: "Desfazer",
                                    textColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    onPressed: () {
                                      setState(() {
                                        _api.reAddCandidate(candidateTemp);
                                      });
                                    }),
                                backgroundColor: Theme.of(context).primaryColor,
                                elevation: 0.0,
                                duration: Duration(seconds: 10));

                            Scaffold.of(context).showSnackBar(snackbar);
                          }
                        },
                        background: Container(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.only(left: 18),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.edit, color: Colors.white)
                              ]),
                        ),
                        secondaryBackground: Container(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.only(right: 18),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.delete, color: Colors.white)
                              ]),
                        ),
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CandidateDetailsView(_candidates[i]),
                            ),
                          ),
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
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateCandidateView(_job.id))),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
    );
  }
}
