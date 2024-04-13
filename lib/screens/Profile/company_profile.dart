import 'package:flutter/material.dart';
import 'package:student_hub_flutter/models/company_user.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});
  @override
  State<CompanyProfile> createState() => _CompanyProfile();
}

class _CompanyProfile extends State<CompanyProfile> {
  late TextEditingController nameController;
  late TextEditingController websiteController;
  late TextEditingController descController;
  late String noEmployee;

  late CompanyUser user;

  late bool firstCreate;
  @override
  void initState() {
    super.initState();
    // fetch user
    firstCreate = false;
    // if(user.id = -1) firstCreate = true;
    user = CompanyUser();

    nameController = TextEditingController(text: user.name);
    websiteController = TextEditingController(text: user.website);
    descController = TextEditingController(text: user.description);
    noEmployee = user.size.toString();

    setState(() {});
  }

  List<Widget> buildChildren() {
    List<Widget> builder = [];
    if (firstCreate) {
      builder.addAll([
        Text("walcome",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        Text("Tell us", style: Theme.of(context).textTheme.bodyMedium),
      ]);
    }
    builder.addAll([
      Align(
        alignment: Alignment.centerLeft,
        child: Text("How many",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      ListTile(
        title:
            Text("It's just me", style: Theme.of(context).textTheme.bodyMedium),
        leading: Radio<String>(
          value: "It's just me",
          groupValue: noEmployee,
          onChanged: (value) {
            setState(() {
              noEmployee = value!;
            });
          },
        ),
      ),
      ListTile(
        title: Text("2-9 employees",
            style: Theme.of(context).textTheme.bodyMedium),
        leading: Radio<String>(
          value: "2-9 employees",
          groupValue: noEmployee,
          onChanged: (value) {
            setState(() {
              noEmployee = value!;
            });
          },
        ),
      ),
      ListTile(
        title: Text("10-99 employees",
            style: Theme.of(context).textTheme.bodyMedium),
        leading: Radio<String>(
          value: "10-99 employees",
          groupValue: noEmployee,
          onChanged: (value) {
            setState(() {
              noEmployee = value!;
            });
          },
        ),
      ),
      ListTile(
        title: Text("100-1000 employees",
            style: Theme.of(context).textTheme.bodyMedium),
        leading: Radio<String>(
          value: "100-1000 employees",
          groupValue: noEmployee,
          onChanged: (value) {
            setState(() {
              noEmployee = value!;
            });
          },
        ),
      ),
      ListTile(
        title: Text("More than 1000 employees",
            style: Theme.of(context).textTheme.bodyMedium),
        leading: Radio<String>(
          value: "More than 1000 employees",
          groupValue: noEmployee,
          onChanged: (value) {
            setState(() {
              noEmployee = value!;
            });
          },
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text("Company",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
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
      Align(
        alignment: Alignment.centerLeft,
        child: Text("Website",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
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
      Align(
        alignment: Alignment.centerLeft,
        child: Text("Description",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
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
    if (firstCreate) {
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
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  padding: const EdgeInsets.all(15)),
              child: const Text("Edit"),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
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
