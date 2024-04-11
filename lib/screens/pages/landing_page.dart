import 'package:flutter/material.dart';
import 'package:student_hub_flutter/screens/pages/login_page.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreen(
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
            const _UserTypeButton(Icons.school, "Student"),
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
          width: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(text),
              const SizedBox(width: 12)
            ],
          ),
        )
      ),
    );
  }
}
