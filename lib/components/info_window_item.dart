
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoWindowItem extends StatelessWidget {
  String lead;
  String right;
  int maxLine;
  InfoWindowItem(this.lead, this.right, this.maxLine);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(lead, style: TextStyle(fontWeight: FontWeight.w700),),
        Expanded(
          child: Text(right, maxLines: maxLine, overflow: TextOverflow.ellipsis,),
        )
      ],
    );
  }
}