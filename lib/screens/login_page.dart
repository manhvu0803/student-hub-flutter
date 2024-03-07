import 'package:flutter/material.dart';
import 'package:student_hub_flutter/context_extension.dart';
import 'package:student_hub_flutter/screens/sign_up_page.dart';
import 'package:student_hub_flutter/widgets/extra_option_container.dart';
import 'package:student_hub_flutter/widgets/icon_text_field.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Stack(
          children: [
            _LogInContainer(),
            BottomExtraOption.materialRoute(
              text: "Don't have an account?",
              buttonText: "Sign up",
              builder: (context) => const SignupPage(),
            )
          ]
        ),
      ),
    );
  }
}

class _LogInContainer extends StatefulWidget {
  @override
  State<_LogInContainer> createState() => _LogInContainerState();
}

class _LogInContainerState extends State<_LogInContainer> {
  String _username = "";

  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Log in with StudentHub",
          style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        IconTextField(
          icon: Icons.person,
          onChange: (value) => _username = value,
          hintText: "Username or email",
        ),
        const SizedBox(height: 16),
        IconTextField(
          icon: Icons.lock,
          onChange: (value) => _password = value,
          hintText: "Password",
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: () => print("Login: $_username $_password"),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text("Log in", style: TextStyle(fontSize: 18))
          )
        )
      ]
    );
  }
}