import 'package:flutter/material.dart';
import 'package:orim/config/dimens_resource.dart';

class LeadingWidgetTextItem extends StatelessWidget {
  final Widget leading;
  final String content;
  final TextStyle style;
  final int maxLine;
  LeadingWidgetTextItem(this.leading, this.content, this.style, this.maxLine);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: DimenResource.padding5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          leading,
          Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: DimenResource.padding5),
                child: Text(
                  content,
                  maxLines: maxLine,
                  overflow: TextOverflow.ellipsis,
                  style: this.style,
                ),
              )),
        ],
      ),
    );
  }
}