import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/student_user.dart';

class StudentProfileFiles extends StatefulWidget {
  const StudentProfileFiles({super.key, required this.studentUser});
  final StudentUser studentUser;
  @override
  State<StudentProfileFiles> createState() => _StudentProfileFiles();
}

class _StudentProfileFiles extends State<StudentProfileFiles> {
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
              Text("CV & Transcript",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text("tell us", style: Theme.of(context).textTheme.bodyMedium),
              Text("Resume/CV",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("Upload pdf"),
                ),
              ),
              Text("Transcript",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("Upload pdf"),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child:
                    TextButton(onPressed: () {
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                      //   return HomePage();
                      // }), (route) => false);
                    }, child: const Text("Continue")),
              )
            ],
          ),
        )));
  }
}
