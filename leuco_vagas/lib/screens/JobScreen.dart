import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:leuco_vagas/screens/CandidateScreen.dart';

class JobScreen extends StatefulWidget {
  final DocumentSnapshot job;

  JobScreen(this.job);

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  Future _getCandidates() async {
    final firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection("candidate").getDocuments();

    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Container(
            height: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Theme.of(context).accentColor,
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 250.0,
                  child: AutoSizeText(
                    widget.job.data["name"].toUpperCase(),
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 10.0,
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Sobre a vaga",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, left: 20.0, bottom: 10.0),
                        child: Text(
                          "Candidatos".toUpperCase(),
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: FutureBuilder(
                        future: _getCandidates(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text(
                                "Buscando candidatos...",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                DocumentSnapshot candidate = snapshot.data[i];

                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CandidateScreen(candidate),
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white60,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 25.0,
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  candidate.data["name"],
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  candidate.data["about"]
                                                      ["course"],
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
