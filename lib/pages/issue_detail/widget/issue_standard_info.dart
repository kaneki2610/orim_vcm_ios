import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/dimens_resource.dart';

class IssueStandardInfo extends StatelessWidget {
  const IssueStandardInfo(
      {this.icon, this.title, this.content, this.colorTextTitle});

  final IconData icon;
  final String title, content;
  final Color colorTextTitle;

  @override
  Widget build(BuildContext context) {
    final Color colorTitle = colorTextTitle ?? Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              icon,
              color: colorTitle,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0, ),
              child: Text(
                title,
                style: TextStyle(
                    color: colorTitle,
                    fontWeight: FontWeight.bold,
                    fontSize: DimenResource.textTitleSize),
              ),
            ),
          ],
        ),
        (content != null && content != '')
            ? Container(
                height: 5.0,
              )
            : Container(),
        (content != null && content != '')
            ? Text(
                content,
                style: TextStyle(color: Colors.black87, fontSize: 14),
              )
            : Container()
      ],
    );
  }
}
