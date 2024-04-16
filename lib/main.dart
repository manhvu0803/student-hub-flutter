import 'package:flutter/material.dart';
import 'package:student_hub_flutter/screens/pages/home_page.dart';
import 'package:student_hub_flutter/screens/pages/login_page.dart';
import 'package:student_hub_flutter/widgets/loading_view.dart';
import 'client.dart' as client;
import 'widgets/page_screen.dart';
import 'settings.dart' as settings;

void main() async {
  runApp(const StudentHubApp());
}

class StudentHubApp extends StatefulWidget {
  const StudentHubApp({super.key});

  @override
  State<StudentHubApp> createState() => _StudentHubAppState();
}

class _StudentHubAppState extends State<StudentHubApp> {
  @override
  void initState() {
    super.initState();
    settings.addChangeListener(_onSettingsChange);
  }

  @override
  void dispose() {
    settings.removeListener(_onSettingsChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentHub',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: settings.isDarkMode ? Brightness.dark : Brightness.light
        )
      ),
      home: FutureBuilder(
        future: client.init(),
        builder: _homeBuilder
      )
    );
  }

  Widget _homeBuilder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
      return const PageScreen(child: LoadingView());
    }

    if ((snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.done)
      && (snapshot.hasError || client.user == null)) {
      return const LoginPage();
    }

    return const HomePage(isStudentUser: false);
  }

  void _onSettingsChange() => setState(() {});
}