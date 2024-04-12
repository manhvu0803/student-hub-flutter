import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/widgets/icon_text_field.dart';

class SignUpInfoContainer extends StatefulWidget {
  final void Function()? onCreateAccount;

  const SignUpInfoContainer({
    super.key,
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

  void _signUp(BuildContext context) {
    if (_agreedToTerms) {
      print("Sign up $_fullName $_email $_password");
      widget.onCreateAccount?.call();
      return;
    }

    ScaffoldMessenger
      .of(context)
      .showSnackBar(const SnackBar(
        content: Text(
          "You are required to agree to the Terms of Service",
          textAlign: TextAlign.center,
        )
      ));
  }
}