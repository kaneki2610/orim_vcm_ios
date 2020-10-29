import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/config/strings_resource.dart';

class IssueStatus extends StatelessWidget {
  const IssueStatus({this.statusName, this.status});

  final int status;
  final String statusName;

  String getNameStatus(int status) {
    String str = StringResource.getTextResource(
        'issue_area_item_handling_state');
    if (status == IssueStatusEnum.ApprovedComplete) {
      str = StringResource.getTextResource('issue_area_item_completed_state');
    } else if (status == IssueStatusEnum.RecycleIssue) {
      str = StringResource.getTextResource('issue_area_item_spam_state');
    } else if (status == IssueStatusEnum.NewIssue) {
      str = StringResource.getTextResource('issue_area_item_new_state');
    }
    return str;
  }
  @override
  Widget build(BuildContext context) {
    Color color = IssueStatusEnum.getColorByStatus(status);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(
          MdiIcons.stateMachine,
          color: color,
        ),
        Text(
          getNameStatus(status).toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: DimenResource.textTitleSize),
        )
      ],
    );
  }

}