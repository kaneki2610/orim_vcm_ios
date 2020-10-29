import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';

const paddingButtonDefault = EdgeInsets.only(top: DimenResource.paddingContent);

class RaisedButtonCustom extends StatelessWidget {
  final double width;
  final EdgeInsetsGeometry paddingButton;
  final Function onPressed;
  final Color textColor;
  final Color backgroundColor;
  final String text;

  const RaisedButtonCustom(
      {width,
      paddingButton,
      @required this.onPressed,
      this.textColor,
      this.backgroundColor,
      this.text})
      : this.paddingButton = paddingButton ?? paddingButtonDefault,
        this.width = width ?? double.infinity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: paddingButton,
      width: width,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        disabledTextColor: ColorsResource.textColorButton,
        onPressed: onPressed,
        color: backgroundColor ?? Theme.of(context).primaryColor,
        textColor: textColor ?? ColorsResource.textColorButton,
        padding: EdgeInsets.all(DimenResource.paddingInput),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
