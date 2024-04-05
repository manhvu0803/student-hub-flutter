import 'package:flutter/material.dart';

class PageScreen extends StatelessWidget {
  final String title;

  final Widget child;

  final Widget? bottomNavigationBar;

  final PreferredSizeWidget? appBarBottom;

  const PageScreen({
    super.key,
    this.title = "StudentHub",
    required this.child,
    this.bottomNavigationBar,
    this.appBarBottom
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        bottom: appBarBottom,
      ),
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(child: child),
    );
  }
}