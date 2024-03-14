import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_hub_flutter/models/post.dart';
import 'package:student_hub_flutter/screens/Post/post_project_desc.dart';

class PostProjectScope extends StatefulWidget {
  const PostProjectScope({super.key, required this.post});
  final Post post;
  @override
  State<PostProjectScope> createState() => _PostProjectScope();
}

class _PostProjectScope extends State<PostProjectScope> {
  late TextEditingController scopeController;
  late String projectLength;

  @override
  void initState() {
    super.initState();
    scopeController =
        TextEditingController(text: widget.post.noStudent.toString());
    projectLength = widget.post.length;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scopeController.dispose();
    super.dispose();
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
              Text("2/4",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text("this help", style: Theme.of(context).textTheme.bodyMedium),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("How Long",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text("1 - 3 months",
                    style: Theme.of(context).textTheme.bodyMedium),
                leading: Radio<String>(
                  value: "1 - 3 months",
                  groupValue: projectLength,
                  onChanged: (value) {
                    setState(() {
                      projectLength = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("3 - 6 months",
                    style: Theme.of(context).textTheme.bodyMedium),
                leading: Radio<String>(
                  value: "3 - 6 months",
                  groupValue: projectLength,
                  onChanged: (value) {
                    setState(() {
                      projectLength = value!;
                    });
                  },
                ),
              ),
              Text("How many",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              TextField(
                controller: scopeController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostProjectDesc(post: widget.post)));
                      }, child: const Text("Next: Desc")))
            ],
          ),
        )));
  }
}
