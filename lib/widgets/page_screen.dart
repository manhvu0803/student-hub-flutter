import 'package:flutter/material.dart';

class PageScreen extends StatelessWidget {
  final String title;

  final Widget child;

  final Widget? bottomNavigationBar;

  final PreferredSizeWidget? appBarBottom;

  final bool hasBackButton;

  final void Function()? customBackButtonCallback;

  const PageScreen({
    super.key,
    this.title = "StudentHub",
    required this.child,
    this.bottomNavigationBar,
    this.appBarBottom,
    bool? hasBackButton,
    this.customBackButtonCallback
  }) : hasBackButton = hasBackButton ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        leading: _getBackButton(context),
        bottom: appBarBottom,
      ),
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(child: child),
    );
  }

  IconButton? _getBackButton(BuildContext context) {
    if (!hasBackButton) {
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