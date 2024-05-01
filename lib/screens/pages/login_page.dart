import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/pages/home_page.dart';
import 'package:student_hub_flutter/screens/pages/sign_up/sign_up_page.dart';
import 'package:student_hub_flutter/screens/profile/company_profile.dart';
import 'package:student_hub_flutter/screens/profile/student_profile_basic.dart';
import 'package:student_hub_flutter/settings.dart' as settings;
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/client.dart' as client;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      hasBackButton: false,
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
  String _username = client.userEmail;
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
          controller: TextEditingController()..text = client.userEmail,
          icon: Icons.person,
          onChange: (value) => _username = value,
          hintText: "Email",
        ),
        const SizedBox(height: 16),
        IconTextField(
          icon: Icons.lock,
          onChange: (value) => _password = value,
          hintText: "Password",
          obscureText: true,
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: () => _onLogInPressed(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text("Log in", style: TextStyle(fontSize: 18))
          )
        ),
        const SizedBox(height: 8),

        TextButton(
          onPressed: () => showAdaptiveDialog(
            context: context,
            builder: (context) => const _ResetPasswordDialog()
          ),
          child: const Text("Forgot your password?")
        )
      ]
    );
  }

  void _onLogInPressed(BuildContext context) async {
    context.showRequestLoad(
      request: () => client.signIn(_username, _password),
      onRequestDone: () {
        if (settings.isStudent && client.user!.student == null) {
          context.pushReplacement((context) => const StudentProfileBasic());
          return;
        }

        if (!settings.isStudent && client.user!.company == null) {
          context.pushReplacement((context) => const CompanyProfile());
          return;
        }

        context.pushReplacement((context) => const HomePage());
      }
    );
  }
}

class _ResetPasswordDialog extends StatelessWidget {
  const _ResetPasswordDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Do you want to reset yout password?"),
      content: const Text("An email with the new password will be sent your email address"),
      actions: [
        TextButton(
          onPressed: () => context.loadWithDialog(
            client.resetPassword(),
            onDone: (data) => Navigator.pop(context)
          ),
          child: const Text("OK")
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel")
        )
      ],
    );
  }
}