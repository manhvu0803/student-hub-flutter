import 'package:flutter/material.dart';
import 'package:student_hub_flutter/login_page.dart';
import 'package:student_hub_flutter/widgets/screen_page.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ScreenPage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 64),
            Text(
              'Build your product with high skilled student',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 32),
            Text(
              "StudentHub is university market place to connect high-skilled student and company on a real-world project",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const _UserTypeButton(Icons.person, "Student"),
            const _UserTypeButton(Icons.apartment, "Company"),
            const SizedBox(height: 32),
            Text(
              "Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class _UserTypeButton extends StatelessWidget {
  final IconData icon;

  final String text;

  const _UserTypeButton(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).secondaryHeaderColor),
        child: SizedBox(
          height: 60,
          width: 180,
          child: ListTile(
            leading: Icon(icon),
            title: Text(text),
          ),
        )
      ),
    );
  }
}
