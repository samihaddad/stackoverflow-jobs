import 'package:flutter/material.dart';
import 'package:so_jobs/ui/screens/jobs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: JobsScreen2(),
    );
  }
}