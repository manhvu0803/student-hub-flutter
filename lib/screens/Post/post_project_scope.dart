import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_hub_flutter/models/post.dart';

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
    scopeController = TextEditingController(text: widget.post.scope);
    projectLength = widget.post.scope;
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
              const Text("2/4"),
              const Text("this help"),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("How Long"),
              ),
              ListTile(
                title: const Text("1 - 3 months"),
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
                title: const Text("3 - 6 months"),
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
              Text("How many"),
              TextField(
                controller: scopeController,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: const Text("Next: Desc")))
            ],
          ),
        )));
  }
}
