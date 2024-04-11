import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/pages/login_page.dart';
import 'package:student_hub_flutter/screens/pages/student_sign_up_page.dart';
import 'package:student_hub_flutter/widgets/extra_option_container.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

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

enum AccountType {
  company,
  student
}

class _AccountTypeChooser extends StatefulWidget {
  @override
  State<_AccountTypeChooser> createState() => _AccountTypeChooserState();
}

class _AccountTypeChooserState extends State<_AccountTypeChooser> {
  AccountType? _accountType;

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
          value: AccountType.student,
          groupValue: _accountType,
          onChanged: (value) => setState(() =>_accountType = value),
        ),
        const SizedBox(height: 24),
        _AccountTypeOption(
          icon: Icons.apartment,
          title: "Company",
          subtitle: "I represent a company looking for developers",
          value: AccountType.company,
          groupValue: _accountType,
          onChanged: (value) => setState(() =>_accountType = value),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentSignUpPage())),
          child: const Text(
            "Create account",
            textScaler: TextScaler.linear(1.1),
          )
        )
      ]
    );
  }
}

class _AccountTypeOption extends StatelessWidget {
  final IconData icon;

  final String title;

  final String? subtitle;

  final AccountType value;

  final AccountType? groupValue;

  final void Function(AccountType?) onChanged;

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
        borderRadius: BorderRadius.circular(90),
        color: (groupValue == value) ? Theme.of(context).primaryColor.withOpacity(0.25) : null
      ),
      child: InkWell(
        onTap: () => onChanged(value),
        child: SizedBox(
          height: 90,
          child: Center(
            child: ListTile(
              leading: Icon(icon, size: 40),
              title: Text(title),
              subtitle: (subtitle == null) ? null : Text(subtitle!),
              trailing: Radio<AccountType>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}