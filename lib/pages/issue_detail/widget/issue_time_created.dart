import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/issue_detail/widget/issue_standard_info.dart';

class IssueTimeCreated extends StatelessWidget {
  const IssueTimeCreated({this.dateText, this.timeText, this.dateResolved, this.timeResolved});

  final String dateText, timeText, dateResolved, timeResolved;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IssueStandardInfo(
              icon: Icons.access_time,
              title: StringResource.getText(context, 'time'),
              content:StringResource.getText(context, 'issue_area_item_time_created') + '$dateText $timeText'
          ),
          dateResolved != "" && timeResolved != "" ? SizedBox(height: 8,) : SizedBox(),
          dateResolved != "" && timeResolved != "" ?
          Text(
            StringResource.getText(context, 'issue_area_item_time_resolved') +
                '$dateResolved $timeResolved',
            style: TextStyle(
                color: Colors.black87, fontSize: 14
            ),
          ) : SizedBox(),
        ],
      )
    );
  }
}
