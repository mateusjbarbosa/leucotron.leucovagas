import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF311B92),
        accentColor: Color(0xFF5641B5),
      ),
      title: 'Leuco Vagas',
      home: HomeScreen(),
    ),
  );
}
