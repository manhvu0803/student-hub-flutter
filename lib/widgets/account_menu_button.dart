import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/screens/pages/change_password_page.dart';
import 'package:student_hub_flutter/screens/pages/login_page.dart';
import 'package:student_hub_flutter/screens/profile/company_profile.dart';
import 'package:student_hub_flutter/screens/profile/student_profile_basic.dart';
import 'package:student_hub_flutter/client.dart' as client;
import 'package:student_hub_flutter/settings.dart' as settings;

import 'icon_text.dart';

class AccountMenuButton extends StatefulWidget {
  const AccountMenuButton({super.key});

  @override
  State<AccountMenuButton> createState() => _AccountMenuButtonState();
}

class _AccountMenuButtonState extends State<AccountMenuButton> {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          child: Text("Switch to ${settings.isStudent ? "company" : "student"}"),
          onPressed: () => settings.isStudent = !settings.isStudent,
        ),
        MenuItemButton(
          child: const Text("Student profile"),
          onPressed: () => context.pushRoute((context) => const StudentProfileBasic()),
        ),
        MenuItemButton(
          child: const Text("Company profile"),
          onPressed: () => context.pushRoute((context) => const CompanyProfile()),
        ),
        const Divider(),
        MenuItemButton(
          child: Row(
            children: [
              const Text("Dark mode"),
              const SizedBox(width: 4),
              Switch(
                onChanged: (value) => setState(() => settings.isDarkMode = value),
                value: settings.isDarkMode,
              ),
            ],
          ),
          onPressed: () => setState(() => settings.isDarkMode = !settings.isDarkMode),
        ),
        const Divider(),
        MenuItemButton(
          child: const IconText(Icons.password, "Change password", distance: 6,),
          onPressed: () => context.pushReplacement((context) => const ChangePasswordPage()),
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