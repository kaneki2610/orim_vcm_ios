import 'package:flutter/cupertino.dart';

class Separated extends StatelessWidget {

  const Separated({ this.height, this.width });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
    );
  }
}
