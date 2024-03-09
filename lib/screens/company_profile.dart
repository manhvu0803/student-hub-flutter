import 'package:flutter/material.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key, required this.firstCreate});
  final bool firstCreate;

  @override
  State<CompanyProfile> createState() => _CompanyProfile();
}

class _CompanyProfile extends State<CompanyProfile> {
  int radioChoice = 0;
  String name = "";
  String website = "";
  String desc = "";

  @override
  void initState() {
    super.initState();
    if (!widget.firstCreate) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("walcome"),
        Text("Tell us"),
        Text("How many"),
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
        Text("Company"),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Company name',
            ),
          ),
        ),
        Text("Website"),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Website url',
            ),
            
          ),
        ),
        Text("Description"),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Describe company',
            ),
          ),
        ),
      ],
    );
  }
}
