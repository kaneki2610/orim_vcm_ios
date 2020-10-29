import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CircleContainer(
      {this.backgroundColor = Colors.white,
      @required this.child,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration:
            BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: child,
      ),
    );
  }
}
