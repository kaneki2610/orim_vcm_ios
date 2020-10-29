import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final double size;
  final Color circleColor;
  final Color backgroundColor;

  const Loading({this.size = 50.0, this.circleColor, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          backgroundColor: backgroundColor,
          valueColor: circleColor != null
              ? AlwaysStoppedAnimation<Color>(circleColor)
              : null,
        ));
  }
}
