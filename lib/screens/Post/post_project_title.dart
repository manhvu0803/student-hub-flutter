import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_hub_flutter/models/post.dart';

class PostProjectTitle extends StatefulWidget {
  const PostProjectTitle({super.key, this.post});
  final Post? post;
  @override
  State<PostProjectTitle> createState() => _PostProjectTitle();
}

class _PostProjectTitle extends State<PostProjectTitle> {
  late TextEditingController titleController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    if (widget.post != null) {
      titleController.text = widget.post!.title;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
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
              const Text("1/4"),
              const Text("this help"),
              TextField(
                controller: titleController,
                autofocus: true,
              ),
              const Text("Example"),
              const Text("ex1, ex2"),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: const Text("Next: Scope")))
            ],
          ),
        )));
  }
}
