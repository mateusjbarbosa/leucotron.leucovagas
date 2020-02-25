import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateScreen extends StatefulWidget {
  final DocumentSnapshot candidate;

  CandidateScreen(this.candidate);

  @override
  _CandidateScreenState createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: DraggableScrollableSheet(
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Sobre ele".toUpperCase(),
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Dados".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Experiência".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        },
        initialChildSize: 0.6,
        minChildSize: 0.6,
        maxChildSize: 0.8,
      ),
    );
  }
}
