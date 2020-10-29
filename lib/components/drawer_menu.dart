import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/dimens_resource.dart';

class DrawerMenu extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Function onTap;

  const DrawerMenu({this.leading, this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: leading,
            title: title,
            onTap: onTap,
          ),
          Container(
            margin: EdgeInsets.only(
                left: DimenResource.paddingContent,
                right: DimenResource.paddingContent),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[400],
            ),
          )
        ],
      ),
    );
  }
}
