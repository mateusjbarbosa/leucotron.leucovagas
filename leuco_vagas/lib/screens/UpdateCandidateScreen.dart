import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateCandidateScreen extends StatefulWidget {
  final DocumentSnapshot candidate;

  UpdateCandidateScreen(this.candidate);

  @override
  _UpdateCandidateScreenState createState() => _UpdateCandidateScreenState();
}

class _UpdateCandidateScreenState extends State<UpdateCandidateScreen> {
  _buildAboutItem(String item, double paddingRight,
      TextEditingController controller, TextInputType keyboardType) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: <Widget>[
          Text(item + ': '),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: paddingRight),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _exibirPopUp(_companyController, _jobController, _durationController) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar experiência'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _companyController,
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Empresa"),
                ),
                TextField(
                  controller: _jobController,
                  decoration: InputDecoration(labelText: "Função"),
                ),
                TextField(
                  controller: _durationController,
                  decoration: InputDecoration(labelText: "Duration"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                setState(() {
                  _companyController.clear();
                  _jobController.clear();
                  _durationController.clear();
                });
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                "Atualizar",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> candidate = widget.candidate.data;

    List experience = candidate['experience'];

    TextEditingController _nameController =
        TextEditingController(text: candidate['name']);

    TextEditingController _ageController =
        TextEditingController(text: candidate['about']['age']);

    TextEditingController _courseController =
        TextEditingController(text: candidate['about']['course']);

    TextEditingController _collegeController =
        TextEditingController(text: candidate['about']['college']);

    TextEditingController _emailController =
        TextEditingController(text: candidate['about']['email']);

    TextEditingController _cellphoneController =
        TextEditingController(text: candidate['about']['cellphone']);

    TextEditingController _companyController = TextEditingController();
    TextEditingController _jobController = TextEditingController();
    TextEditingController _durationController = TextEditingController();

    _update() async {
      final firestore = Firestore.instance;

      final id = widget.candidate.documentID;

      final data = {
        'about': {
          'age': _ageController.text,
          'cellphone': _cellphoneController.text,
          'college': _collegeController.text,
          'course': _courseController.text,
          'email': _emailController.text
        },
        'experience': experience,
        'job_id': candidate['job_id'],
        'skills': []
      };

      // await firestore.collection('candidate').document(id).setData(data);
      print(data);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar candidato'.toUpperCase(),
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 18.0, top: 10.0, bottom: 5.0),
                        child: Text(
                          'Sobre você'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildAboutItem(
                      'Nome', 0.0, _nameController, TextInputType.text),
                  _buildAboutItem(
                      'Idade', 250.0, _ageController, TextInputType.number),
                  _buildAboutItem(
                      'Curso', 100.0, _courseController, TextInputType.text),
                  _buildAboutItem(
                      'Faculdade', 0.0, _collegeController, TextInputType.text),
                  _buildAboutItem(
                      'E-mail', 0.0, _emailController, TextInputType.text),
                  _buildAboutItem('Contato', 125.0, _cellphoneController,
                      TextInputType.text),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 18.0, top: 30.0, bottom: 5.0),
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: experience.length,
                    itemBuilder: (_, i) {
                      return Dismissible(
                        key: Key(DateTime.now().toString()),
                        direction: DismissDirection.horizontal,
                        onDismissed: (d) {
                          if (d == DismissDirection.startToEnd) {
                            _companyController.text = experience[i]['company'];
                            _jobController.text = experience[i]['job'];
                            _durationController.text =
                                experience[i]['duration'];

                            _exibirPopUp(_companyController, _jobController,
                                _durationController);
                          } else {}
                        },
                        child: ListTile(
                          title: Text(experience[i]['company']),
                          subtitle: Text(experience[i]['job'] +
                              ' | ' +
                              experience[i]['duration']),
                        ),
                        background: Container(
                          padding: EdgeInsets.only(left: 24),
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.only(right: 24),
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'save',
            child: Icon(Icons.save),
            onPressed: _update,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FloatingActionButton(
              heroTag: 'delete',
              child: Icon(Icons.delete),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
