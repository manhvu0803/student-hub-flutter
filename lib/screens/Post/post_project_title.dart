import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/post.dart';
import 'package:student_hub_flutter/screens/Post/post_project_scope.dart';

class PostProjectTitle extends StatefulWidget {
  const PostProjectTitle({super.key, this.post});
  final Post? post;
  @override
  State<PostProjectTitle> createState() => _PostProjectTitle();
}

class _PostProjectTitle extends State<PostProjectTitle> {
  late TextEditingController titleController;
  Post _post = Post();
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    if (widget.post != null) {
      _post.title = widget.post!.title;
      _post.length = widget.post!.length;
      _post.noStudent = widget.post!.noStudent;
      _post.desc = widget.post!.desc;

      titleController.text = _post.title;
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
               Text("1/4", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
               Text("this help", style: Theme.of(context).textTheme.bodyMedium),
              TextField(
                controller: titleController,
                autofocus: true,
              ),
              Text("Example", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
              Text("ex1, ex2", style: Theme.of(context).textTheme.bodyMedium),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostProjectScope(post: _post)));
                      }, child: const Text("Next: Scope")))
            ],
          ),
        )));
  }
}
