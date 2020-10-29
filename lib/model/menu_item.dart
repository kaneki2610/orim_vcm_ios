class MenuItem {
  String code;
  String icon;
  String name;
  bool visible;
  String routeName;

  MenuItem({
    this.code,
    this.icon,
    this.name,
    this.visible,
    this.routeName,
  });

  factory MenuItem.clone(MenuItem menuItem) {
    return MenuItem(
        code: menuItem.code,
        icon: menuItem.icon,
        name: menuItem.name,
        visible: menuItem.visible,
        routeName: menuItem.routeName);
  }
}
