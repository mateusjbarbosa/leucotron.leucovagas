import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leuco_vagas/core/models/Job.dart';

class CreateJobView extends StatefulWidget {
  @override
  _CreateJobViewState createState() => _CreateJobViewState();
}

class _CreateJobViewState extends State<CreateJobView> {
  Firestore _db = Firestore.instance;

  Job _job = Job();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _requirementsController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();

  void _clearControllers() {
    _nameController.clear();
    _roleController.clear();
    _requirementsController.clear();
    _skillsController.clear();
  }

  void _createJob() async {
    String name = _nameController.text;
    String role = _roleController.text;
    List<String> requirements = _requirementsController.text.split(', ');
    List<String> skills = _skillsController.text.split(', ');

    _job =
        Job(name: name, role: role, requirements: requirements, skills: skills);

    DocumentReference ref = await _db.collection('jobs').add(_job.toJson());

    _job.id = ref.documentID;

    _clearControllers();
    Navigator.pop(context);
  }

  _buildTextField(String field, TextEditingController _controller) {
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
        Padding(
          padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 20.0),
          child: TextField(
            controller: _controller,
            style: TextStyle(fontSize: 20.0),
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Criar vaga',
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
              _buildTextField('Nome da vaga', _nameController),
              _buildTextField('Cargo', _roleController),
              _buildTextField('Requisitos', _requirementsController),
              _buildTextField('Habilidades', _skillsController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createJob,
        child: Icon(Icons.save),
        elevation: 0.0,
      ),
    );
  }
}
