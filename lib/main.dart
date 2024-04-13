import 'package:flutter/material.dart';
import 'package:student_hub_flutter/screens/pages/landing_page.dart';
import './client/client.dart' as client;

void main() async {
  runApp(const MyApp());
  client.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentHub',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.05
        )
      ),
      home: const LandingPage()
    );
  }
}