import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/company_user.dart';
import 'package:student_hub_flutter/models/student_user.dart';
import 'package:student_hub_flutter/screens/Profile/company_profile.dart';
import 'package:student_hub_flutter/screens/Profile/student_profile_basic.dart';

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
      body: Center(
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: .9,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("current acc",
                        style: Theme.of(context).textTheme.bodyMedium),
                    subtitle: Text("Company",
                        style: Theme.of(context).textTheme.bodySmall),
                    onTap: () {},
                  ),
                  ExpansionTile(
                    title: Text("other accc",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    children: <Widget>[
                      ListTile(
                        title: Text("acc1",
                            style: Theme.of(context).textTheme.bodyMedium),
                        subtitle: Text("Student",
                            style: Theme.of(context).textTheme.bodySmall),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text("acc2",
                            style: Theme.of(context).textTheme.bodyMedium),
                        subtitle: Text("Student",
                            style: Theme.of(context).textTheme.bodySmall),
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
                        title: Text("Profile",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            // return CompanyProfile();
                            return const StudentProfileBasic();
                          }));
                        },
                      ),
                      ListTile(
                        title: Text("Settings",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text("Logout",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        onTap: () {},
                        tileColor: Colors.red,
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
