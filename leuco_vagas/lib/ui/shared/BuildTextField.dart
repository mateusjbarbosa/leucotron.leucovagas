import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  final String field;
  final TextEditingController _controller;

  BuildTextField(this.field, this._controller);

  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18.0, top: 15.0),
          child: Row(
            children: <Widget>[
              Text(
                widget.field.toUpperCase(),
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
            controller: widget._controller,
            style: TextStyle(fontSize: 20.0),
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}
