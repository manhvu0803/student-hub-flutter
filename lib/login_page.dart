import 'package:flutter/material.dart';
import 'package:student_hub_flutter/context_extension.dart';
import 'package:student_hub_flutter/widgets/screen_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenPage(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Stack(
          children: [
            _LogInContainer(),
            _SignUpContainer()
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
  static TextStyle _getHintStyle(BuildContext context) {
    var theme = Theme.of(context);
    var hintStyle = theme.inputDecorationTheme.hintStyle ?? theme.textTheme.labelLarge;
    return hintStyle!.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.normal);
  }

  final _usernameInputController = TextEditingController();

  final _passwordInputController = TextEditingController();

  @override
  void dispose() {
    _usernameInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hintStyle = _getHintStyle(context);

    return Column(
      children: [
        Text(
          "Log in with StudentHub",
          style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        TextField(
          controller: _usernameInputController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            hintText: "Username or email",
            hintStyle: hintStyle
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordInputController,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            hintText: "Password",
            hintStyle: hintStyle
          ),
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text("Log in", style: TextStyle(fontSize: 18))
          )
        )
      ]
    );
  }
}

class _SignUpContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            const Text("Don't have an account?"),
            const SizedBox(height: 4),
            FilledButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                child: Text("Sign up", style: TextStyle(fontSize: 16),),
              )
            )
        ],
      ),
    );
  }
}