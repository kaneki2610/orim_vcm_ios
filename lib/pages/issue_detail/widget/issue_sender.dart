import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/pages/issue_detail/widget/issue_standard_info.dart';

class IssueSender extends StatelessWidget {
  const IssueSender({this.sender});

  final Sender sender;

  @override
  Widget build(BuildContext context) {
    return IssueStandardInfo(
      icon: Icons.person_outline,
      title: StringResource.getText(context, 'sender'),
      content: '${sender.phoneNumber} - ${sender.name}',
    );
  }
}
