import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leuco_vagas/core/models/Job.dart';
import 'package:leuco_vagas/ui/views/CreateJobView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Firestore _db = Firestore.instance;

  List<dynamic> _jobs;

  Stream<QuerySnapshot> _streamJobs() {
    return _db.collection('jobs').snapshots();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leuco Vagas',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Container(
        child: StreamBuilder(
          stream: _streamJobs(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              _jobs = snapshot.data.documents
                  .map((doc) => Job.fromMap(doc.data, doc.documentID))
                  .toList();

              return ListView.builder(
                itemCount: _jobs.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(
                    _jobs[i].name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_jobs[i].role),
                ),
              );
            } else {
              return Text('fetching');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateJobView())),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
    );
  }
}
