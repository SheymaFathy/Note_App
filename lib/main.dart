import 'package:flutter/material.dart';
import 'package:note_app/modules/add_note.dart';
import 'modules/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        fontFamily:'cairo',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          )
        ),
        useMaterial3: true,
      ),
      home:  HomePage(),
      routes: {
        "addnotes": (context) => const AddNotes(),
      },
    );
  }
}

