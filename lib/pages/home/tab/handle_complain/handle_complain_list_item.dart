import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/leading_widget_text_item.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';

import '../../../../model/issue/issue.dart';

class ComplainItem extends StatelessWidget {
  Function() onPressed;
  IssueModel model;
  EdgeInsets padding;
  bool isShowResolvedComment = false;

  ComplainItem({IssueModel model, Function onPressed, EdgeInsets padding, bool isShowResolvedComment = false})
      : this.model = model,
        this.onPressed = onPressed,
        this.padding = padding {
    if (this.padding == null) {
      this.padding = EdgeInsets.symmetric(vertical: 10.0);
    }
    this.isShowResolvedComment = isShowResolvedComment;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final TextStyle style = TextStyle(
        color: ColorsResource.textHandleComplain,
        fontWeight: FontWeight.normal);
    final TextStyle areaDetails = TextStyle(
        color: ColorsResource.areaDetails, fontWeight: FontWeight.normal);
    final TextStyle contentIssue = TextStyle(
        color: ColorsResource.contentIssue, fontWeight: FontWeight.normal);
    final TextStyle timeIssue = TextStyle(
        color: ColorsResource.textHandleComplain, fontWeight: FontWeight.normal);
    final double sizeIcon = 18.0;
    final maxLine = 1;
    final maxLineAddress = 1;

    return MaterialButton(
      onPressed: this.onPressItem,
      child: Container(
        padding: this.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            LeadingWidgetTextItem(
                Icon(
                  Icons.location_on,
                  color: ColorsResource.areaDetails,
                  size: sizeIcon,
                ),
                this.model.location,
                areaDetails,
                maxLineAddress),
            LeadingWidgetTextItem(
                Icon(
                  Icons.insert_drive_file,
                  color: ColorsResource.contentIssue,
                  size: sizeIcon,
                ),
                this.model.content,
                contentIssue,
                maxLine),
            LeadingWidgetTextItem(
                Icon(
                  Icons.access_time,
                  color: ColorsResource.textHandleComplain,
                  size: sizeIcon,
                ),
                this.model.dateText + " " + this.model.timeText,
                timeIssue,
                maxLine),
            LeadingWidgetTextItem(
                Text(
                  StringResource.getText(context, 'personal_send_complain'),
                  style: TextStyle(
                      color: ColorsResource.timeIssue,
                      fontWeight: FontWeight.normal),
                ),
                this.model.sender.name + " - " + this.model.sender.phoneNumber,
                timeIssue,
                maxLine),
            LeadingWidgetTextItem(
                Icon(
                  Icons.equalizer,
                  color: ColorsResource.areaDetails,
                  size: sizeIcon,
                ),
                this.model.statusName,
                areaDetails,
                maxLine),
            (this.model.resolvedComment == null || this.isShowResolvedComment == false || this.model.resolvedComment == "")
                ? SizedBox()
                : Text(
             "  " +  (this.model.resolvedComment ?? ""),
              maxLines: 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: contentIssue,
            ),
          ],
        ),
      ),
    );
  }

  onPressItem() {
    if (this.onPressed != null) {
      this.onPressed();
    }
  }
}
