import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:leuco_vagas/core/models/Candidate.dart';

import 'package:leuco_vagas/core/services/api.dart';
import 'package:leuco_vagas/ui/shared/BuildTextField.dart';

class UpdateCandidateView extends StatefulWidget {
  final Candidate candidate;

  UpdateCandidateView(this.candidate);

  @override
  _UpdateCandidateViewState createState() => _UpdateCandidateViewState();
}

class _UpdateCandidateViewState extends State<UpdateCandidateView> {
  Api _api = Api();

  Candidate _candidate = Candidate();

  List<dynamic> _experiences = List<dynamic>();
  List<dynamic> _emails = List<String>();
  List<dynamic> _cellphones = List<String>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  TextEditingController _collegeController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();

  TextEditingController _companyController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _durationController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _cellphoneController = TextEditingController();

  void _initCandidate(Candidate candidate) {
    _candidate = candidate;

    _nameController.text = _candidate.name;
    _ageController.text = _candidate.age;
    _courseController.text = _candidate.course;
    _collegeController.text = _candidate.college;
    _emails = _candidate.emails;
    _cellphones = _candidate.cellphones;
    _experiences = _candidate.experience;
    _skillsController.text = _candidate.skills.join(', ');
  }

  void _updateCandidate() {
    _api.updateCandidate(
      _candidate.id,
      _candidate.jobId,
      _nameController.text,
      _ageController.text,
      _courseController.text,
      _collegeController.text,
      _emails,
      _cellphones,
      _experiences,
      _skillsController.text.split(', '),
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    _initCandidate(widget.candidate);

    super.initState();
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

  void _editEmail(String email) {
    _emailController.text = email;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar e-mail'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTextFieldDialog('E-mail', _emailController),
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
                    _emailController.clear();
                  },
                );
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: FlatButton(
                child: Text('Editar', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  _emails.remove(email);
                  _emails.add(_emailController.text);

                  setState(
                    () {
                      _emailController.clear();
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

  void _editCellphone(String cellphone) {
    _cellphoneController.text = cellphone;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar telefone/celular'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTextFieldDialog('Telefone/celular', _cellphoneController),
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
                    _emailController.clear();
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
                  _cellphones.remove(cellphone);
                  _cellphones.add(_cellphoneController.text);

                  setState(
                    () {
                      _cellphoneController.clear();
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

  void _editExperience(LinkedHashMap<String, dynamic> experience) {
    _companyController.text = experience['company'];
    _jobController.text = experience['job'];
    _durationController.text = experience['duration'];
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

  void _addEmail() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar e-mail'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTextFieldDialog('E-mail', _emailController),
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
                    _emailController.clear();
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
                  _emails.add(_emailController.text);

                  setState(
                    () {
                      _emailController.clear();
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

  void _addCellphone() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar telefone/celular'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTextFieldDialog('Telefone/celular', _cellphoneController),
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
                    _emailController.clear();
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
                  _cellphones.add(_cellphoneController.text);

                  setState(
                    () {
                      _cellphoneController.clear();
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
          'Editar candidato',
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
                      'E-mails'.toUpperCase(),
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
                itemCount: _emails.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 15.0),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                _editEmail(_emails[i]);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _emails.remove(_emails[i]);
                              });
                            },
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        _emails[i],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 15.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  child: FlatButton(
                    onPressed: _addEmail,
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text('Adicionar e-mail'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, top: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Telefones/Celulares'.toUpperCase(),
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
                itemCount: _cellphones.length,
                itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 15.0),
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              _editCellphone(_cellphones[i]);
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _cellphones.remove(_cellphones[i]);
                            });
                          },
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      _cellphones[i],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 15.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  child: FlatButton(
                    onPressed: _addCellphone,
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text('Adicionar telefone/celular'),
                  ),
                ),
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
                itemCount: _experiences.length,
                itemBuilder: (_, i) => ListTile(
                  onTap: () {
                    _editExperience(_experiences[i]);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            _editExperience(_experiences[i]);
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _experiences.remove(_experiences[i]);
                          });
                        },
                        child: Icon(
                          Icons.remove_circle,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
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
              BuildTextField('Habilidades  | separe por ,', _skillsController),
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateCandidate,
        child: Icon(Icons.save),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
    );
  }
}
