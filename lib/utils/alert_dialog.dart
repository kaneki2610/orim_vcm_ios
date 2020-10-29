import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/strings_resource.dart';

class AlertDialogBuilder {
  final BuildContext context;
  final String title;
  final String content;
  final Color titleColor;
  final Color contentColor;
  TextStyle titleStyle;
  TextStyle contentStyle;

  AlertDialogBuilder(
      {this.context,
      this.title,
      this.content,
      this.titleColor,
      this.contentColor});

  static Widget button({String text, TextStyle textStyle, Function onPress}) {
    return FlatButton(
      child: Text(text, style: textStyle),
      onPressed: onPress,
    );
  }

  show({bool cancelable = false, List<Widget> actions}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: cancelable,
        builder: (BuildContext context) {
          return _build(
            actions: actions ??
                <Widget>[
                  button(
                    text: 'OK',
                    onPress: () => Navigator.of(context).pop(),
                  ),
                ],
          );
        });
  }

  showMultiChoice({bool cancelable = false, List<Widget> actions}) {
    titleStyle = TextStyle(
      color: titleColor,
    );
    contentStyle = TextStyle(
      color: contentColor,
    );
    return showDialog(
        context: context,
      barrierDismissible: cancelable,
      builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(title, style: titleStyle),
            children: actions,
          );
      }
    );
  }

  static Future<void> showLoading(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: CircularProgressIndicator(),
        );
      }
    );
  }

  static Future<void> hideLoading(BuildContext context) async {
    Navigator.of(context).pop();
  }

  _build({List<Widget> actions}) {
    titleStyle = TextStyle(
      color: titleColor,
    );
    contentStyle = TextStyle(
      color: contentColor,
    );
    return AlertDialog(
      title: Text(title, style: titleStyle),
      content: Text(content ?? StringResource.getText(context, "try_again_issue"), style: contentStyle),
      actions: actions,
    );
  }
}
