import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/screens/pages/login_page.dart';
import 'package:student_hub_flutter/screens/profile/company_profile.dart';
import 'package:student_hub_flutter/screens/profile/student_profile_basic.dart';
import 'package:student_hub_flutter/client.dart' as client;

import 'icon_text.dart';

class AccountMenuButton extends StatelessWidget {
  const AccountMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          child: const Text("Student profile"),
          onPressed: () => context.pushRoute((context) => const StudentProfileBasic()),
        ),
        MenuItemButton(
          child: const Text("Company profile"),
          onPressed: () => context.pushRoute((context) => const CompanyProfile()),
        ),
        MenuItemButton(
          child: const IconText(Icons.settings, "Settings"),
          onPressed: () {},
        ),
        MenuItemButton(
          child: const IconText(Icons.logout, "Log out"),
          onPressed: () {
            client.logOut();
            Navigator.popUntil(context, (route) => route.isFirst);
            context.pushReplacement((context) => const LoginPage());
          },
        )
      ],
      builder: (context, controller, child) => IconButton(
        onPressed: () => controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(Icons.person)
      ),
    );
  }
}