import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/student_user.dart';
import 'package:student_hub_flutter/screens/Profile/student_profile_experience.dart';

class StudentProfileBasic extends StatefulWidget {
  const StudentProfileBasic({super.key});

  @override
  State<StudentProfileBasic> createState() => _StudentProfileBasic();
}

class _StudentProfileBasic extends State<StudentProfileBasic> {
  late StudentUser user;
  List<String> list = ["Fullstack", "Backend"];
  late String? techstackChoice;

  @override
  void initState() {
    super.initState();
    // fetch user
    user = StudentUser()..techStack = list[0];
    techstackChoice = user.techStack;
  }

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
              Text("Welcome",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text("Tell us", style: Theme.of(context).textTheme.bodyMedium),
              Text("Techstack",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: techstackChoice,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    techstackChoice = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: Theme.of(context).textTheme.bodyMedium),
                  );
                }).toList(),
              ),
              Text("Skillset",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              TextButton(
                  onPressed: () {},
                  child: SizedBox(
                    height: 50,
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.green,
                          ),
                          child: Text("Sql",
                              style: Theme.of(context).textTheme.bodyMedium),
                        )
                      ],
                    ),
                  )),
              Row(children: <Widget>[
                Text("Language",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
              ]),
              Text("English and other",
                  style: Theme.of(context).textTheme.bodyMedium),
              Row(children: <Widget>[
                Text("Education",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
              ]),
              Row(children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Education",
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text("infomation",
                        style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
              ]),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return StudentProfileExperience(studentUser: user);
                      }));
                    },
                    child: const Text("Next")),
              )
            ],
          ),
        )));
  }
}
