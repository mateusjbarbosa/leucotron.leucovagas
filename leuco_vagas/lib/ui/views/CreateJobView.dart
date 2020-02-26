import 'package:flutter/material.dart';

import 'package:leuco_vagas/core/services/api.dart';

import 'package:leuco_vagas/ui/shared/BuildTextField.dart';

class CreateJobView extends StatefulWidget {
  @override
  _CreateJobViewState createState() => _CreateJobViewState();
}

class _CreateJobViewState extends State<CreateJobView> {
  Api _api = Api();

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

  void _createJob() {
    _api.createJob(
      _nameController.text,
      _roleController.text,
      _requirementsController.text.split(', '),
      _skillsController.text.split(', '),
    );

    _clearControllers();
    Navigator.pop(context);
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
              BuildTextField('Nome da vaga', _nameController),
              BuildTextField('Cargo', _roleController),
              BuildTextField('Requisitos', _requirementsController),
              BuildTextField('Habilidades', _skillsController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createJob,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.save),
        elevation: 0.0,
      ),
    );
  }
}
