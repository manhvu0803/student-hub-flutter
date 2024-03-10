import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

/* 
column 
  active account
  expandable (other accounts)
    other acc1
    acc2

  Seperator

  column
    profile
    settings
    logout
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Student hub"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
        body: Center(
            child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: .9,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("current acc"),
                      subtitle: Text("Company"),
                      onTap: () {},
                    ),
                    ExpansionTile(
                      title: Text("other accc"),
                      children: <Widget>[
                        ListTile(
                          title: Text("acc1"),
                          subtitle: Text("Student"),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text("acc2"),
                          subtitle: Text("Student"),
                          onTap: () {},
                        )
                      ],
                    ),
                    const Divider(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text("Profile"),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text("Settings"),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text("Logout"),
                          onTap: () {},
                          tileColor: Colors.red,
                        ),
                      ],
                    )
                  ],
                ))));
  }
}
