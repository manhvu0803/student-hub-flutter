import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/screens/pages/home_page.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/client.dart' as client;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String _oldPassword = "";
  String _newPassword = "";
  String _rePassword = "";

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      actions: (client.isLogIn()) ? const [AccountMenuButton()] : const [GenericSettingsMenuButton()],
      title: "Change password",
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 32),
            const TitleText("Old password"),
            IconTextField(
              icon: Icons.lock,
              obscureText: true,
              onChange: (value) => _oldPassword = value,
            ),
            const SizedBox(height: 64),
            const TitleText("New password"),
            IconTextField(
              icon: Icons.lock,
              obscureText: true,
              onChange: (value) => _newPassword = value,
            ),
            const SizedBox(height: 32),
            const TitleText("Re-enter new password"),
            IconTextField(
              icon: Icons.lock,
              obscureText: true,
              onChange: (value) => _rePassword = value,
            ),
            const SizedBox(height: 128),
            Align(
              alignment: Alignment.center,
              child: FilledButton(
                onPressed: () => _changePassword(context),
                child: const Text("Change password")
              ),
            )
          ],
        ),
      )
    );
  }

  void _changePassword(BuildContext context) {
    if (_newPassword != _rePassword) {
      context.showTextSnackBar("The new passwords doesn't match");
      return;
    }

    context.loadWithDialog(
      client.changePassword(_oldPassword, _newPassword),
      onDone: (data) {
        context.showTextSnackBar("Password changed!");
        context.pushReplacement((context) => const HomePage());
      }
    );
  }
}