import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/pages/home_page.dart';
import 'package:student_hub_flutter/screens/pages/login_page.dart';
import 'package:student_hub_flutter/widgets/loading_view.dart';
import 'client/client.dart' as client;
import 'widgets/page_screen.dart';

void main() async {
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark
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

    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: context.textTheme.apply(fontSizeFactor: 1.1)
      ),
      child: const HomePage(isStudentUser: false)
    );
  }
}