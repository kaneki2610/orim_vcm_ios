import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';

// ignore: must_be_immutable
class ContainerAppbar extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final bool isLightStatus;
  final double height;

  Timer _timer;

  ContainerAppbar(
      {this.child,
      this.backgroundColor,
      this.isLightStatus = false,
      this.height}) {
    if (Platform.isIOS) {
      _timer?.cancel();
      _timer = Timer(Duration(milliseconds: 200), () async {
        try {
          FlutterStatusbarTextColor.setTextColor(this.isLightStatus
              ? FlutterStatusbarTextColor.light
              : FlutterStatusbarTextColor.dark);
        } catch (err) {
          print(err);
        }
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
//        var minHeight = constraints.minHeight;
//        var maxHeight = constraints.maxHeight;
//        print('height $minHeight $maxHeight');
        var heightContainer;
        if (this.height != null) {
          heightContainer = this.height;
        } else {
          heightContainer = Platform.isIOS ? constraints.maxHeight : constraints.maxHeight / 1.1;
        }
        return Container(
          height: heightContainer,
          color: backgroundColor,
          child: SafeArea(
            child: this.child,
          ),
        );
      },
    );
  }
}
