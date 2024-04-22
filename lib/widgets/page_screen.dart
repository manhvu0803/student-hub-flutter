import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/widgets/account_menu_button.dart';

class PageScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBarBottom;
  final bool? hasBackButton;
  final Widget? floatingActionButton;
  final void Function()? customBackButtonCallback;
  final List<Widget>? actions;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const PageScreen({
    super.key,
    this.title = "StudentHub",
    required this.child,
    this.bottomNavigationBar,
    this.appBarBottom,
    this.hasBackButton,
    this.customBackButtonCallback,
    this.floatingActionButton,
    this.actions,
    this.floatingActionButtonLocation
  });

  PageScreen.account({
    super.key,
    this.title = "StudentHub",
    required this.child,
    this.bottomNavigationBar,
    this.appBarBottom,
    this.hasBackButton,
    this.customBackButtonCallback,
    this.floatingActionButton,
    this.floatingActionButtonLocation
  }) : actions = [const AccountMenuButton()];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: context.textTheme.apply(fontSizeFactor: 1.1)
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: _getBackButton(context),
          actions: actions,
          bottom: appBarBottom,
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        body: SafeArea(child: child),
      ),
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