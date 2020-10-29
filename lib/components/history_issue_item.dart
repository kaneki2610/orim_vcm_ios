import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';

class HistoryIssueItem extends StatelessWidget {
  final IssueModel issueModel;
  final Function(IssueModel) onPressItem;

  HistoryIssueItem({this.issueModel, this.onPressItem});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: ColorsResource.contentIssueHistoryDetail,
    );
    return InkWell(
      onTap: _onPressed,
      child: Container(
        padding: EdgeInsets.all(DimenResource.paddingContent),
        color: ColorsResource.backgroundContainer,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: ColorsResource.contentIssueHistoryDetail,
                ),
                Flexible(
                  child: Text(
                    issueModel.location,
                    style: textStyle,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.insert_drive_file,
                  color: ColorsResource.contentIssueHistoryDetail,
                ),
                Flexible(
                  child: Text(
                    issueModel.content,
                    style: textStyle,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.access_time,
                  color: ColorsResource.contentIssueHistoryDetail,
                ),
                Wrap(
                  children: <Widget>[
                    Text(
                      '${issueModel.dateText} ${issueModel.timeText}',
                      style: textStyle,
                    )
                  ],
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  StringResource.getText(context, 'sender') + ': ',
                  style: textStyle,
                ),
                Wrap(
                  children: <Widget>[
                    Text(
                      '${issueModel.sender.phoneNumber} - ${issueModel.sender.name}',
                      style: textStyle,
                    )
                  ],
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.poll,
                  color: ColorsResource.contentIssueHistoryDetail,
                ),
                Text(
                  IssueStatusEnum.converToString(context, issueModel.status),
                  style: textStyle,
                )
              ],
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                '#${issueModel.id}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPressed() {
    onPressItem(issueModel);
  }
}
