import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:student_hub_flutter/screens/company/student_info_list_tile.dart';

class ProposalCard extends StatelessWidget {
  final Widget? top;

  final Widget? middle;

  final Widget? bottom;

  final double topPadding;

  final double topMiddlePadding;

  final double middleBottomPadding;

  final double bottomPadding;

  final void Function()? onTap;

  const ProposalCard({
    super.key,
    this.top,
    this.middle,
    this.bottom,
    this.topPadding = 0,
    this.topMiddlePadding = 4,
    this.middleBottomPadding = 16,
    this.bottomPadding = 10,
    this.onTap,
  });

  ProposalCard.studentProposal({
    super.key,
    required String studentName,
    required String avatarUrl,
    required String education,
    required String specialty,
    required String evaluation,
    required String proposal,
    this.bottom,
    this.topPadding = 0,
    this.topMiddlePadding = 4,
    this.middleBottomPadding = 16,
    this.bottomPadding = 10,
    this.onTap,
  }) :
    top = StudentInfoListTile(
      studentName: studentName,
      avatarUrl: avatarUrl,
      education: education,
      specialty: specialty,
      evaluation: evaluation,
      proposal: proposal,
    ),
    middle = Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        proposal,
        maxLines: 2,
        overflow: TextOverflow.ellipsis
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: _getColumnChildren()
        ),
      ),
    );
  }

  List<Widget> _getColumnChildren() {
    var columnWidgets = <Widget>[];

    if (top != null) {
      columnWidgets.add(SizedBox(height: topPadding));
      columnWidgets.add(top!);
    }

    if (middle != null) {
      columnWidgets.add(SizedBox(height: topMiddlePadding));
      columnWidgets.add(middle!);
    }

    if (bottom != null) {
      columnWidgets.add(SizedBox(height: middleBottomPadding));
      columnWidgets.add(bottom!);
      columnWidgets.add(SizedBox(height: bottomPadding));
    }

    return columnWidgets;
  }
}