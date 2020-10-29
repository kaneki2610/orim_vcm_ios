import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/utils/widget/widget.dart';

class DrawerToggle extends StatelessWidget {
  final Color iconColor;

  const DrawerToggle({ this.iconColor = Colors.white });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 0),
        child: ImageView.asset(
          ImageResource.drawer_toggle_icon,
          color: iconColor,
        ),
      ),
    );
  }
}
