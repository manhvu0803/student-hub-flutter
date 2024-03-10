import 'dart:math';

import 'package:flutter/material.dart';

class StudentProfileExperience extends StatefulWidget {
  const StudentProfileExperience({super.key});

  @override
  State<StudentProfileExperience> createState() => _StudentProfileExperience();
}

class Project {
  String name = '';
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();
  String desc = '';
  List<String> skillset = List.empty();

  Project(this.name, this.timeStart, this.timeEnd, this.desc, this.skillset);
}

class _StudentProfileExperience extends State<StudentProfileExperience> {
  List<Project> list = [
    Project("name", DateTime.now(), DateTime.now(), "desc", ["SQL", "Node"])
  ];

  List<Widget> populateSkills(Project proj) {
    List<Widget> builder = [];
    for (String e in proj.skillset) {
      builder.add(Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green,
        ),
        child: Text(e),
      ));
    }
    return builder;
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
              const Text("Welcome"),
              const Text("Tell us"),
              Row(children: <Widget>[
                const Text("Projects"),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
              ]),
              Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final proj = list[index];
                        return Column(
                          children: [
                            Row(children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(proj.name),
                                  Text(
                                      "${proj.timeStart.month}/${proj.timeStart.year} - ${proj.timeEnd.month}/${proj.timeEnd.year}")
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.abc)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.abc)),
                            ]),
                            Text(proj.desc),
                            const Text("Skillset"),
                            TextButton(
                                onPressed: () {},
                                child: SizedBox(
                                  height: 50,
                                  child: Wrap(children: populateSkills(proj)),
                                )),
                          ],
                        );
                      })),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text("Next")),
              )
            ],
          ),
        )));
  }
}
