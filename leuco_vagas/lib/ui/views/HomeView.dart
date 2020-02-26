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

  void _deleteJob(String id) async {
    await _db.collection('jobs').document(id).delete();
  }

  void _reAddJob(Job job) async {
    await _db.collection('jobs').document(job.id).setData(job.toJson());
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
                itemBuilder: (context, i) => Dismissible(
                  key: Key(DateTime.now().toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (d) {
                    if (d == DismissDirection.startToEnd) {
                    } else {
                      Job jobTemp = _jobs[i];

                      _deleteJob(_jobs[i].id);

                      final snackbar = SnackBar(
                          content: Text("Vaga excluída com sucesso!"),
                          action: SnackBarAction(
                              label: "Desfazer",
                              textColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              onPressed: () {
                                setState(() {
                                  _reAddJob(jobTemp);
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
                    title: Text(
                      _jobs[i].name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_jobs[i].role),
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
