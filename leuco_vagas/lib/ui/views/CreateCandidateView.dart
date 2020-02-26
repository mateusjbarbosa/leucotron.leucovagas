import 'package:flutter/material.dart';

import 'package:leuco_vagas/core/services/api.dart';

import 'package:leuco_vagas/ui/shared/BuildTextField.dart';

class CreateCandidateView extends StatefulWidget {
  @override
  _CreateCandidateViewState createState() => _CreateCandidateViewState();
}

class _CreateCandidateViewState extends State<CreateCandidateView> {
  Api _api = Api();

  List<dynamic> _experiences = List<dynamic>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  TextEditingController _collegeController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();

  TextEditingController _companyController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _durationController = TextEditingController();

  void _clearControllers() {
    _nameController.clear();
    _ageController.clear();
    _courseController.clear();
    _collegeController.clear();
    _skillsController.clear();
  }

  void _createCandidate() {
    _api.createCandidate(
      _nameController.text,
      _ageController.text,
      _courseController.text,
      _collegeController.text,
      _experiences,
      _skillsController.text.split(', '),
    );

    _clearControllers();
    Navigator.pop(context);
  }

  Widget _buildTextFieldDialog(String field, TextEditingController controller) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
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
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 20.0),
            keyboardType: TextInputType.text,
          ),
        )
      ],
    );
  }

  void _addExperience() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar experiência'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTextFieldDialog('Empresa', _companyController),
                _buildTextFieldDialog('Cargo', _jobController),
                _buildTextFieldDialog('Duração', _durationController)
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancelar",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                setState(
                  () {
                    _companyController.clear();
                    _jobController.clear();
                    _durationController.clear();
                  },
                );
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: FlatButton(
                child: Text('Adicionar', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  _experiences.add(
                    {
                      'company': _companyController.text,
                      'job': _jobController.text,
                      'duration': _durationController.text,
                    },
                  );

                  setState(
                    () {
                      _companyController.clear();
                      _jobController.clear();
                      _durationController.clear();
                    },
                  );

                  Navigator.pop(context);
                },
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar candidato',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BuildTextField('Nome do candidato', _nameController),
              BuildTextField('Idade', _ageController),
              BuildTextField('Curso', _courseController),
              BuildTextField('Faculdade', _collegeController),
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
                itemCount: _experiences.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(
                    _experiences[i]['company'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _experiences[i]['job'] +
                        ' | ' +
                        _experiences[i]['duration'],
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 15.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  child: FlatButton(
                    onPressed: _addExperience,
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text('Adicionar experiência'),
                  ),
                ),
              ),
              BuildTextField('Habilidades', _skillsController),
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createCandidate,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.save),
        elevation: 0.0,
      ),
    );
  }
}
