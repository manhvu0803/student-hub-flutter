import 'package:flutter/material.dart';
import 'package:student_hub_flutter/widgets/student_info_list_tile.dart';

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
    required Widget? avatar,
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
      avatar: avatar,
      education: education,
      specialty: specialty,
      evaluation: evaluation,
      proposal: proposal,
    ),
    middle = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        proposal,
        style: const TextStyle(fontSize: 16),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
      )
    );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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