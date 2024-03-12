import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/post.dart';

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
    // TODO: implement initState
    super.initState();
    descController = TextEditingController(text: widget.post.desc);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              const Text("3/4"),
              const Text("this help"),
              TextField(
                controller: descController,
                autofocus: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child:
                    TextButton(onPressed: () {}, child: const Text("Review")),
              )
            ],
          ),
        )));
  }
}
