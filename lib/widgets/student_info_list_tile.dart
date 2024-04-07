import 'package:flutter/material.dart';

class StudentInfoListTile extends StatelessWidget{
  final String studentName;

  final String avatarUrl;

  final String education;

  final String specialty;

  final String evaluation;

  final String proposal;

  const StudentInfoListTile({
    super.key,
    required this.studentName,
    required this.avatarUrl,
    required this.education,
    required this.specialty,
    required this.evaluation,
    required this.proposal
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(avatarUrl),
      title: Text(studentName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(education),
          Text(specialty),
        ],
      ),
      trailing: Text(evaluation),
    );
  }
}