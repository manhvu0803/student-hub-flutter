import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/pages/login_page.dart';
import 'package:student_hub_flutter/settings.dart' as settings;
import 'package:student_hub_flutter/widgets/extra_option_container.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';
import 'company_sign_up_page.dart';
import 'student_sign_up_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Stack(
          children: [
            _AccountTypeChooser(),
            BottomExtraOption.materialRoute(
              text: "Already have an account?",
              buttonText: "Log in",
              builder: (context) => const LoginPage(),
            )
          ]
        ),
      ),
    );
  }
}

class _AccountTypeChooser extends StatefulWidget {
  @override
  State<_AccountTypeChooser> createState() => _AccountTypeChooserState();
}

class _AccountTypeChooserState extends State<_AccountTypeChooser> {
  bool? _isStudent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Who are you?",
          style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 20),
        _AccountTypeOption(
          icon: Icons.school,
          title: "Student",
          subtitle: "I am a student ready for work",
          value: true,
          groupValue: _isStudent,
          onChanged: _setAccountType,
        ),
        const SizedBox(height: 24),
        _AccountTypeOption(
          icon: Icons.apartment,
          title: "Company",
          subtitle: "I represent a company looking for developers",
          value: false,
          groupValue: _isStudent,
          onChanged: _setAccountType,
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () => _onCreateAccountPressed(context),
          child: const Text(
            "Create account",
            textScaler: TextScaler.linear(1.1),
          )
        )
      ]
    );
  }

  void _setAccountType<T>(bool? value) {
    settings.setProfileType(isStudent: value ?? settings.isStudent);
    setState(() => _isStudent = value);
  }

  void _onCreateAccountPressed(BuildContext context) {
    if (_isStudent ?? true) {
      context.pushRoute((context) => const StudentSignUpPage());
      return;
    }

    context.pushRoute((context) => const CompanySignUpPage());
  }
}

class _AccountTypeOption<T> extends StatelessWidget {
  final IconData icon;

  final String title;

  final String? subtitle;

  final T value;

  final T? groupValue;

  final void Function(T?) onChanged;

  const _AccountTypeOption({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(80),
        color: (groupValue == value) ? Theme.of(context).primaryColor.withOpacity(0.25) : null
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(80),
        onTap: () => onChanged(value),
        child: SizedBox(
          height: 90,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                leading: Icon(icon, size: 35),
                title: Text(title),
                subtitle: (subtitle == null) ? null : Text(subtitle!),
                trailing: Radio(
                  value: value,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}