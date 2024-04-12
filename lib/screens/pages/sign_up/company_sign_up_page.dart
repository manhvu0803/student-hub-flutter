import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/pages/home_page.dart';
import 'package:student_hub_flutter/widgets/extra_option_container.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

import 'sign_up_info_container.dart';
import 'student_sign_up_page.dart';

class CompanySignUpPage extends StatelessWidget {
  const CompanySignUpPage({super.key});

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
                "Signing up for company",
                style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SignUpInfoContainer(
                onCreateAccount: () => context.pushRoute((context) => const HomePage(isStudentUser: false))
              ),
              const SizedBox(height: 165),
              BottomExtraOption.materialRoute(
                text: "Looking for a project?",
                buttonText: "Sign up for students",
                builder: (context) => const StudentSignUpPage()
              )
            ]
          )
        )
      )
    );
  }
}