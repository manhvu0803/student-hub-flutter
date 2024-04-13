import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/extensions/iterable_extension.dart';
import 'package:student_hub_flutter/models/company_user.dart';
import 'package:student_hub_flutter/widgets/page_screen.dart';
import 'package:student_hub_flutter/widgets/title_text.dart';
import 'package:student_hub_flutter/client/client.dart' as client;
import 'package:student_hub_flutter/client/company_client.dart' as client;

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});
  @override
  State<CompanyProfile> createState() => _CompanyProfile();
}

class _CompanyProfile extends State<CompanyProfile> {
  late CompanyUser _company;
  late TextEditingController _nameTextController;
  late TextEditingController _websiteTextController;
  late TextEditingController _descriptionTextController;

  @override
  void initState() {
    super.initState();
    _company = client.user?.company ?? CompanyUser();
    _nameTextController = TextEditingController()..text = _company.name;
    _websiteTextController = TextEditingController()..text = _company.website;
    _descriptionTextController = TextEditingController()..text = _company.description;
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _websiteTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScreen(
      title: "Company profile",
      actions: [
        TextButton(
          onPressed: () => _saveChanges(context),
          child: const Text("Save changes")
        )
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            const TitleText("Name"),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Your company name',
              ),
              controller: _nameTextController,
            ),
            const SizedBox(height: 30),

            const TitleText("Size"),
            ..._getCompanySizeRadioButtons(),
            const SizedBox(height: 30),

            const TitleText("Website"),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Your company landing page',
              ),
              controller: _websiteTextController,
            ),
            const SizedBox(height: 30),

            const TitleText("Description"),
            TextField(
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Describe your company',
              ),
              controller: _descriptionTextController,
            ),
            const SizedBox(height: 40),
          ],
        ),
      )
    );
  }

  List<Widget> _getCompanySizeRadioButtons() {
    return CompanySize.values.mapToList((size) => Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: ListTile(
        leading: Radio(
          value: size,
          groupValue: _company.size,
          onChanged: (value) => setState(() => _company.size = value ?? CompanySize.one),
        ),
        title: Text(size.description),
      ),
    ));
  }

  Future<void> _saveChanges(BuildContext context) async {
    _company.name = _nameTextController.text;
    _company.website = _websiteTextController.text;
    _company.description = _descriptionTextController.text;
    context.showLoadingDialog();

    try {
      await client.updateProfile(_company);
    }
    catch (e) {
      if (context.mounted) {
        context.showTextSnackBar(e.toString());
      }
    }

    if (context.mounted) {
      Navigator.pop(context);
      context.showTextSnackBar(
        "Profile saved",
        duration: const Duration(seconds: 2)
      );
    }
  }
}
