import 'package:flutter/material.dart';
import 'package:orim/config/strings_resource.dart';

import 'issue_standard_info.dart';

class IssueComment extends StatelessWidget {
  const IssueComment({this.resolvedComment});
  final String resolvedComment ;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IssueStandardInfo(icon: Icons.comment,
            title: StringResource.getText(context, 'issue_area_item_comment_resolved'),
            content: resolvedComment),
      ],
    );
  }
}
