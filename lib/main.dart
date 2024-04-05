import 'package:flutter/material.dart';
import 'package:student_hub_flutter/screens/company/project_page.dart';
import 'package:student_hub_flutter/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.05
        )
      ),
      home: const ProjectPage(projectName: "projectName"),
    );
  }
}