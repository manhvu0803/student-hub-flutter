import 'package:flutter/material.dart';
import 'package:student_hub_flutter/settings.dart' as settings;

class GenericSettingsMenuButton extends StatefulWidget {
  const GenericSettingsMenuButton({super.key});

  @override
  State<GenericSettingsMenuButton> createState() => _GenericSettingsMenuButtonState();
}

class _GenericSettingsMenuButtonState extends State<GenericSettingsMenuButton> {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
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
      ],
      builder: (context, controller, child) => IconButton(
        onPressed: () => controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(Icons.more_vert)
      ),
    );
  }
}