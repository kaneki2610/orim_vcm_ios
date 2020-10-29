import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/colors_resource.dart';

class TitleContainer extends StatelessWidget {
  final String titleText;
  final Color titleColor;
  final FontWeight fontWeight;
  final AlignmentGeometry alignmentText;
  final double fontSize;
  final double padding;

  const TitleContainer(
      {this.titleColor = ColorsResource.textColorTitle,
      @required this.titleText,
      this.fontWeight = FontWeight.bold,
      this.alignmentText = Alignment.centerLeft,
      this.fontSize,
      this.padding = 5.0});

  @override
  Widget build(BuildContext context) {
    String title = this.titleText.toLowerCase();
    if(title.length > 0){
      String first = title.substring(0, 1);
      title = title.replaceFirst(RegExp(first), first.toUpperCase());
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: this.padding),
      alignment: alignmentText,
      child: Text(
        title,
        style: TextStyle(color: titleColor, fontWeight: fontWeight, fontSize: fontSize),
      ),
    );
  }
}
