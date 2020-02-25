import 'package:flutter/material.dart';

import 'package:leuco_vagas/screens/HomeScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF311B92),
        accentColor: Color(0xFF5641B5),
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
      ),
      title: 'Leuco Vagas',
      home: HomeScreen(),
    ),
  );
}
