import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/views/chat_list_view.dart';
import 'package:student_hub_flutter/screens/company/company_dashboard.dart';
import 'package:student_hub_flutter/screens/views/notification_list_view.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

class HomePage extends StatefulWidget {
  final bool isStudentUser;

  const HomePage({
    super.key,
    required this.isStudentUser
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      bottomNavigationBar: NavigationBar(
        indicatorColor: context.colorScheme.inversePrimary,
        selectedIndex: _selectedTabIndex,
        onDestinationSelected: (index) => setState(() => _selectedTabIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: "Dashboard"
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: "Projects"
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble),
            label: "Messages"
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: "Alerts"
          )
        ]
      ),
      child: _getChildWidget()
    );
  }

  Widget _getChildWidget() {
    return switch (_selectedTabIndex) {
      1 => Container(),
      2 => const ChatListView(),
      3 => const NotificationListView(),
      _ => widget.isStudentUser ? Container() : const CompanyDashboard(),
    };
  }
}