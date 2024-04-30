import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_theme_extension.dart';
import 'package:student_hub_flutter/screens/student/student_dashboard.dart';
import 'package:student_hub_flutter/screens/views/meeting_list_view.dart';
import 'package:student_hub_flutter/screens/views/chat_list_view.dart';
import 'package:student_hub_flutter/screens/company/company_dashboard.dart';
import 'package:student_hub_flutter/screens/views/notification_list_view.dart';
import 'package:student_hub_flutter/screens/student/project_search_list_view.dart';
import 'package:student_hub_flutter/widgets.dart';
import 'package:student_hub_flutter/settings.dart' as settings;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    settings.addChangeListener(_onRoleChange);
  }

  @override
  void dispose() {
    super.dispose();
    settings.removeListener(_onRoleChange);
  }

  void _onRoleChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageScreen.account(
      bottomNavigationBar: NavigationBar(
        indicatorColor: context.colorScheme.inversePrimary,
        selectedIndex: _selectedTabIndex,
        onDestinationSelected: (index) => setState(() => _selectedTabIndex = index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: "Dashboard"
          ),
          _get2ndDestination(),
          const NavigationDestination(
            icon: Icon(Icons.chat_bubble),
            label: "Messages"
          ),
          const NavigationDestination(
            icon: Icon(Icons.notifications),
            label: "Alerts"
          ),
          const NavigationDestination(
            icon: Icon(Icons.people),
            label: "Interviews"
          )
        ]
      ),
      child: _getChildWidget()
    );
  }

  Widget _getChildWidget() {
    return switch (_selectedTabIndex) {
      0 => settings.isStudent ? const StudentDashboard() : const CompanyDashboard(),
      1 => const ProjectSearchListView(),
      2 => const ChatListView(),
      3 => const NotificationListView(),
      _ => const MeetingListView(),
    };
  }

  Widget _get2ndDestination() {
    return const NavigationDestination(
      icon: Icon(Icons.list),
      label: "Projects"
    );
  }
}