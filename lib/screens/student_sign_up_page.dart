import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/home_page.dart';
import 'package:student_hub_flutter/widgets/extra_option_container.dart';
import 'package:student_hub_flutter/widgets/icon_text_field.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

class StudentSignUpPage extends StatelessWidget {
  const StudentSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _SignUpInfoContainer(),
              const SizedBox(height: 165),
              BottomExtraOption.materialRoute(
                text: "Looking for a project?",
                buttonText: "Sign up for companies",
                builder: (context) => const HomePage()
              )
            ]
          )
        )
      )
    );
  }
}

class _SignUpInfoContainer extends StatefulWidget {
  @override
  State<_SignUpInfoContainer> createState() => _SignUpInfoContainerState();
}

class _SignUpInfoContainerState extends State<_SignUpInfoContainer> {
  String _fullName = "";

  String _email = "";

  String _password = "";

  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            "Signing up for students",
            style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                IconTextField(
                  icon: Icons.badge,
                  hintText: "Full name",
                  onChange: (value) => _fullName = value,
                ),
                const SizedBox(height: 16),
                IconTextField(
                  icon: Icons.mail,
                  hintText: "Email",
                  onChange: (value) => _email = value,
                ),
                const SizedBox(height: 16),
                IconTextField(
                  icon: Icons.lock,
                  hintText: "Password",
                  onChange: (value) => _password = value,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
            child: ListTile(
              leading: Checkbox(
                value: _agreedToTerms,
                onChanged: (value) => setState(() => _agreedToTerms = value ?? false)
              ),
              title: Text(
                "I understand and agree to StudentHub Terms of Service",
                style: context.textTheme.bodyMedium
              ),
              minLeadingWidth: 0,
              horizontalTitleGap: 0,
            ),
          ),
          const SizedBox(height: 26),
          FilledButton(
            onPressed: _signUp,
            child: const Text("Create account")
          ),
          const SizedBox(height: 170),
          BottomExtraOption.materialRoute(
            text: "Looking for a project?",
            buttonText: "Sign up for companies",
            builder: (context) => const HomePage()
          )
        ]
      ),
    );
  }

  void _signUp() {
    if (_agreedToTerms) {
      print("Sign up $_fullName $_email $_password");
      return;
    }
  }
}