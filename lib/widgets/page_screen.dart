import 'package:flutter/material.dart';

class PageScreen extends StatelessWidget {
  final String title;

  final Widget child;

  final Widget? bottomNavigationBar;

  final PreferredSizeWidget? appBarBottom;

  final bool hasBackButton;

  final Widget? floatingActionButton;

  final void Function()? customBackButtonCallback;

  const PageScreen({
    super.key,
    this.title = "StudentHub",
    required this.child,
    this.bottomNavigationBar,
    this.appBarBottom,
    bool? hasBackButton,
    this.customBackButtonCallback,
    this.floatingActionButton
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
      floatingActionButton: floatingActionButton,
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