import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/post.dart';

class PostProjectConfirm extends StatefulWidget {
  const PostProjectConfirm({super.key, required this.post});
  final Post post;
  @override
  State<PostProjectConfirm> createState() => _PostProjectConfirm();
}

class _PostProjectConfirm extends State<PostProjectConfirm> {
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
              Text("4/4",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text("Title", style: Theme.of(context).textTheme.bodyMedium),
              const Divider(
                height: 5,
              ),
              Text("desc", style: Theme.of(context).textTheme.bodyMedium),
              const Divider(
                height: 5,
              ),
              Text("Scope", style: Theme.of(context).textTheme.bodyMedium),
              Text("Students required",
                  style: Theme.of(context).textTheme.bodyMedium),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text("Post job"),
                ),
              )
            ],
          ),
        )));
  }
}
