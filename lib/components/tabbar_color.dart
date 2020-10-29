import 'package:flutter/material.dart';

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.color, this.tabBar, this.view);

  final Color color;
  final TabBar tabBar;
  final Widget view;

  @override
  Size get preferredSize => this.tabBar != null ? tabBar.preferredSize : Size(0.0,0.0);

  @override
  Widget build(BuildContext context) => Container(
    color: color,
    child: tabBar != null? tabBar : this.view,
  );
}