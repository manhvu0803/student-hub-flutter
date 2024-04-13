import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/screens/Profile/profile_page.dart';

class PageScreen extends StatelessWidget {
  final String title;

  final Widget child;

  final Widget? bottomNavigationBar;

  final PreferredSizeWidget? appBarBottom;

  final bool? hasBackButton;

  final Widget? floatingActionButton;

  final bool useTrailingButton;

  final void Function()? customBackButtonCallback;

  final List<Widget>? customActions;

  const PageScreen({
    super.key,
    this.title = "StudentHub",
    required this.child,
    this.bottomNavigationBar,
    this.appBarBottom,
    this.hasBackButton,
    this.customBackButtonCallback,
    this.floatingActionButton,
    this.useTrailingButton = true,
    this.customActions
  });

  @override
  Widget build(BuildContext context) {
    var actions = customActions ?? [
      if (useTrailingButton) IconButton(
        onPressed: () => context.pushRoute((context) => const ProfilePage()),
        icon: const Icon(Icons.person)
      )
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        leading: _getBackButton(context),
        actions: actions,
        bottom: appBarBottom,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(child: child),
    );
  }

  IconButton? _getBackButton(BuildContext context) {
    if (!(hasBackButton ?? false) && !Navigator.canPop(context)) {
      return null;
    }

    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => _onBackButtonPressed(context)
    );
  }

  void _onBackButtonPressed(BuildContext context) {
    if (customBackButtonCallback != null) {
      customBackButtonCallback!.call();
      return;
    }

    Navigator.pop(context);
  }
}