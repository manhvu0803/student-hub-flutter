import 'package:flutter/material.dart';

class StudentProfileBasic extends StatefulWidget {
  const StudentProfileBasic({super.key});

  @override
  State<StudentProfileBasic> createState() => _StudentProfileBasic();
}

class _StudentProfileBasic extends State<StudentProfileBasic> {
  List<String> list = ["Fullstack", "Backend"];
  String techstackChoice = '';

  @override
  void initState() {
    super.initState();
    techstackChoice = list.first;
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
              Text("Welcome"),
              Text("Tell us"),
              Text("Techstack"),
              DropdownButton<String>(
                value: techstackChoice,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    techstackChoice = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Text("Skillset"),
              TextButton(
                  onPressed: () {},
                  child: Container(
                    height: 50,
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.green,
                          ),
                          child: Text("Sql"),
                        )
                      ],
                    ),
                  )),
              Row(children: <Widget>[
                Text("Language"),
                Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
              ]),
              Text("English and other"),
              Row(children: <Widget>[
                Text("Education"),
                Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
              ]),
              Row(children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[Text("Education"), Text("infomation")],
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc)),
              ]),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: Text("Next")),
              )
            ],
          ),
        )));
  }
}
