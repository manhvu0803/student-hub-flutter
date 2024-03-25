import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/post.dart';
import 'package:student_hub_flutter/screens/Post/post_project_confirm.dart';

class PostProjectDesc extends StatefulWidget {
  const PostProjectDesc({super.key, required this.post});
  final Post post;
  @override
  State<PostProjectDesc> createState() => _PostProjectDesc();
}

class _PostProjectDesc extends State<PostProjectDesc> {
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    descController = TextEditingController(text: widget.post.desc);
  }

  @override
  void dispose() {
    descController.dispose();
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
                Text("3/4", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                Text("this help", style: Theme.of(context).textTheme.bodyMedium),
              TextField(
                controller: descController,
                autofocus: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child:
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PostProjectConfirm(post: widget.post)));
                    }, child: const Text("Review")),
              )
            ],
          ),
        )));
  }
}
