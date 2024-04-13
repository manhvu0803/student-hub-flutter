import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/pages/login_page.dart';
import 'package:student_hub_flutter/widgets/icon_text_field.dart';
import 'package:student_hub_flutter/client/client.dart' as client;

class SignUpInfoContainer extends StatefulWidget {
  final bool isStudent;

  final void Function()? onCreateAccount;

  const SignUpInfoContainer({
    super.key,
    required this.isStudent,
    this.onCreateAccount
  });

  @override
  State<SignUpInfoContainer> createState() => _SignUpInfoContainerState();
}


class _SignUpInfoContainerState extends State<SignUpInfoContainer> {
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
                  obscureText: true,
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
            onPressed: () => _signUp(context),
            child: const Text("Create account")
          )
        ]
      ),
    );
  }

  void _signUp(BuildContext context) async {
    if (!_agreedToTerms) {
      context.showTextSnackBar("You are required to agree to the Terms of Service");
      return;
    }

    context.showRequestLoad(
      request: () => client.signUp(_email, _password, _fullName, widget.isStudent),
      onRequestDone: () {
        context.pushReplacement((context) => const LoginPage());
        context.showTextSnackBar("Please check your inbox and verify the email address");
      }
    );
  }
}