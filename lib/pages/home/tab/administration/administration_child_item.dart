import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/utils/remove_html_tag.dart';

class AdministrationItem extends StatelessWidget {
  final maxLineTwo = 2;
  final maxLineOne = 1;
  Function() onPressed;
  IssueModel model;

  AdministrationItem(IssueModel model, Function onPressed)
      : this.model = model,
        this.onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 20,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    child: FadeInImage.assetNetwork(
                        placeholder: ImageResource.city_admin,
                        image:
                            this.model.imgUrl != null ? this.model.imgUrl : ""),
                  ),
                )),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              flex: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.model.location,
                    maxLines: maxLineTwo,
                    style: TextStyle(color: ColorsResource.areaDetails, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: DimenResource.heightMarginText,
                  ),
                  Text(
                    this.model.content,
                    maxLines: maxLineTwo,
                    style: TextStyle(color: ColorsResource.contentIssue, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: DimenResource.heightMarginText,
                  ),
                  Text(
                    this.model.dateText + " " + this.model.timeText,
                    maxLines: maxLineOne,
                    style: TextStyle(color: ColorsResource.timeIssue, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: DimenResource.heightMarginText,
                  ),
                  Text(
                    StringResource.getText(
                            context, 'administration_person_send_issue') +
                        " " +
                        this.model.sender.name,
                    maxLines: maxLineOne,
                    style: TextStyle(color: ColorsResource.timeIssue, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: DimenResource.heightMarginText,
                  ),
                  Text(
                    this.model.statusName,
                    maxLines: maxLineOne,
                    style: TextStyle(color: ColorsResource.areaDetails, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: DimenResource.heightMarginText,
                  ),
                  this.model.resolvedComment == null || this.model.resolvedComment == ""
                      ? SizedBox()
                      : Text(
                          this.model.resolvedComment ?? "",
                          maxLines: maxLineTwo,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ColorsResource.contentIssue, fontWeight: FontWeight.normal),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (this.onPressed != null) {
      this.onPressed();
    }
  }
}
