import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/utils/widget/widget.dart';

class IssueBanner extends StatelessWidget {
  const IssueBanner({this.background});

  final String background;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ImageView.network(
        background,
        fit: BoxFit.cover,
        height: DimenResource.heightBanner,
      ),
    );
  }
}
