import 'package:flutter/material.dart';
import 'package:student_hub_flutter/extensions/context_dialog_extension.dart';
import 'package:student_hub_flutter/models.dart';
import 'package:student_hub_flutter/screens/profile/student_profile_page.dart';
import 'package:student_hub_flutter/widgets/student_info_list_tile.dart';

class ProposalCard extends StatelessWidget {
  final Widget? top;
  final Widget? middle;
  final Widget? bottom;
  final double topPadding;
  final double topMiddlePadding;
  final double middleBottomPadding;
  final double bottomPadding;
  final Proposal proposal;

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
    required this.proposal,
  });

  ProposalCard.studentProposal(this.proposal, {
    super.key,
    Widget? avatar,
    required String evaluation,
    this.bottom,
    this.topPadding = 0,
    this.topMiddlePadding = 4,
    this.middleBottomPadding = 16,
    this.bottomPadding = 10,
    this.onTap,
  }) :
    top = StudentInfoListTile(
      studentName: proposal.student?.name ?? "Unknow",
      avatar: avatar,
      education: proposal.student?.educationString ?? "No education",
      specialty: proposal.student?.techStack?.name ?? "",
      evaluation: evaluation,
      proposal: proposal.content,
    ),
    middle = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        proposal.content,
        style: const TextStyle(fontSize: 16),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
      )
    );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () => context.pushRoute((context) => StudentProfilePage(proposal.student!)),
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