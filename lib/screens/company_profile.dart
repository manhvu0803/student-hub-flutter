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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text("walcome"),
        const Text("Tell us"),
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
      ],
    );
  }
}
