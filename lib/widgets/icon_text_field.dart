import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  static TextStyle _getHintStyle(BuildContext context) {
    var theme = Theme.of(context);
    var hintStyle = theme.inputDecorationTheme.hintStyle ?? theme.textTheme.labelLarge;
    return hintStyle!.copyWith(fontWeight: FontWeight.normal);
  }

  final void Function(String)? onChange;

  final TextEditingController? controller;

  final bool obscureText;

  final IconData icon;

  final String? hintText;

  const IconTextField({
    super.key,
    this.onChange,
    this.controller,
    this.obscureText = false,
    required this.icon,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: _getHintStyle(context)
      ),
    );
  }
}