import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/category.dart';
import 'package:student_hub_flutter/models/project.dart';
import 'package:student_hub_flutter/models/student_user.dart';
import 'student_profile_files.dart';

class StudentProfileExperience extends StatefulWidget {
  const StudentProfileExperience({super.key, required this.studentUser});
  final StudentUser studentUser;
  @override
  State<StudentProfileExperience> createState() => _StudentProfileExperience();
}

class _StudentProfileExperience extends State<StudentProfileExperience> {
  List<Project> list = [Project()];

  List<Widget> populateSkills(List<Category> skillset) {
    List<Widget> builder = [];
    for (var category in skillset) {
      builder.add(Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green,
        ),
        child: Text(category.name),
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
              Text("Welcome",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text("Tell us", style: Theme.of(context).textTheme.bodyMedium),
              Row(children: <Widget>[
                Text("Projects",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
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
                                  Text(proj.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(
                                      "${proj.createdAt.month}/${proj.createdAt.year}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium)
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
                            Text(proj.description),
                            Text("Skillset",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () {},
                                child: const SizedBox(
                                  height: 50,
                                )),
                          ],
                        );
                      })),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentProfileFiles(studentUser: widget.studentUser)));
                }, child: const Text("Next")),
              )
            ],
          ),
        )));
  }
}
