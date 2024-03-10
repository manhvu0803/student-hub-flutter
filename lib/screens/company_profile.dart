import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key, required this.firstCreate});
  final bool firstCreate;

  @override
  State<CompanyProfile> createState() => _CompanyProfile();
}

class _CompanyProfile extends State<CompanyProfile> {
  TextEditingController? nameController;
  TextEditingController? websiteController;
  TextEditingController? descController;
  int? radioChoice;

  @override
  void initState() {
    super.initState();
    if (widget.firstCreate) {
      nameController = TextEditingController();
      websiteController = TextEditingController();
      descController = TextEditingController();
      radioChoice = 0;
    } else {
      nameController = TextEditingController(text: "val");
      websiteController = TextEditingController(text: "val");
      descController = TextEditingController(text: "val");
      radioChoice = 1;
    }

    setState(() {});
  }

  List<Widget> buildChildren() {
    List<Widget> builder = List.empty();
    if (widget.firstCreate) {
      builder.addAll([
        const Text("walcome"),
        const Text("Tell us"),
      ]);
    }
    builder.addAll([
      const Align(
        alignment: Alignment.centerLeft,
        child: Text("How many"),
      ),
      ListTile(
        title: const Text('Option 1'),
        leading: Radio<int>(
          value: 0,
          groupValue: radioChoice,
          onChanged: (value) {
            setState(() {
              radioChoice = value!;
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Option 1'),
        leading: Radio<int>(
          value: 1,
          groupValue: radioChoice,
          onChanged: (value) {
            setState(() {
              radioChoice = value!;
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Option 1'),
        leading: Radio<int>(
          value: 2,
          groupValue: radioChoice,
          onChanged: (value) {
            setState(() {
              radioChoice = value!;
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Option 1'),
        leading: Radio<int>(
          value: 3,
          groupValue: radioChoice,
          onChanged: (value) {
            setState(() {
              radioChoice = value!;
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Option 1'),
        leading: Radio<int>(
          value: 4,
          groupValue: radioChoice,
          onChanged: (value) {
            setState(() {
              radioChoice = value!;
            });
          },
        ),
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text("Company"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Company name',
          ),
          controller: nameController,
        ),
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text("Website"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Website url',
          ),
          controller: websiteController,
        ),
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text("Description"),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Describe company',
          ),
          controller: descController,
        ),
      ),
    ]);
    if (widget.firstCreate) {
      builder.add(Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                padding: const EdgeInsets.all(15)),
            child: const Text("Continue"),
          )));
    } else {
      builder.add(Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  padding: const EdgeInsets.all(15)),
              child: const Text("Edit"),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  padding: const EdgeInsets.all(15)),
              child: const Text("Cancel"),
            )
          ],
        ),
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
            children: buildChildren(),
          ),
        )));
  }
}
