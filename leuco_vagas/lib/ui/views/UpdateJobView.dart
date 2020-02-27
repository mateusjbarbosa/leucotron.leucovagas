import 'package:flutter/material.dart';

import 'package:leuco_vagas/core/services/api.dart';

import 'package:leuco_vagas/core/models/Job.dart';

import 'package:leuco_vagas/ui/shared/BuildTextField.dart';

class UpdateJobView extends StatefulWidget {
  final Job job;

  UpdateJobView(this.job);

  @override
  _UpdateJobViewState createState() => _UpdateJobViewState();
}

class _UpdateJobViewState extends State<UpdateJobView> {
  Api _api = Api();

  Job _job = Job();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _requirementsController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();

  void initJob(Job job) {
    _job = job;

    _nameController.text = _job.name;
    _roleController.text = _job.role;
    _requirementsController.text = _job.requirements.join(', ');
    _skillsController.text = _job.skills.join(', ');
  }

  void _updateJob() {
    _api.updateJob(
      _job.id,
      _nameController.text,
      _roleController.text,
      _requirementsController.text.split(', '),
      _skillsController.text.split(', '),
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    initJob(widget.job);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar vaga',
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
              BuildTextField(
                  'Requisitos | separe por ,', _requirementsController),
              BuildTextField('Habilidades | separe por ,', _skillsController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateJob,
        child: Icon(Icons.save),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
    );
  }
}
