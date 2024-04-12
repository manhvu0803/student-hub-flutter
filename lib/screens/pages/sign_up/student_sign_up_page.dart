import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/pages/home_page.dart';
import 'package:student_hub_flutter/widgets/extra_option_container.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';
import 'package:student_hub_flutter/client/client.dart' as client;

import 'company_sign_up_page.dart';
import 'sign_up_info_container.dart';

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
              const SizedBox(height: 24),
              Text(
                "Signing up for students",
                style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const SignUpInfoContainer(isStudent: true),
              const SizedBox(height: 165),
              BottomExtraOption(
                text: "Looking for students?",
                buttonText: "Sign up for companies",
                onButtonClick: () => context.pushReplacement((context) => const CompanySignUpPage())
              )
            ]
          )
        )
      )
    );
  }
}