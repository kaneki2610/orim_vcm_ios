import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/bottom_bar_fab/anchored_overlay.dart';
import 'package:orim/components/bottom_bar_fab/fab_bottom_app_bar.dart';

const itemsDefault = [
  FABBottomAppBarItem(iconData: null, text: 'HỖ TRỢ'),
  FABBottomAppBarItem(iconData: null, text: 'LIÊN HỆ'),
];

class BottomBarHelp extends StatelessWidget {
  final Widget body;
  final Widget appBar;
  final Function selectTab;
  final List<FABBottomAppBarItem> items;
  final Widget iconCenter;

  const BottomBarHelp(
      {this.body,
      this.appBar,
      this.selectTab,
      this.items = itemsDefault,
      this.iconCenter});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(context),
        bottomNavigationBar: FABBottomAppBar(
          backgroundColor: Color(0xFF4B6EB9),
          color: Colors.grey,
          selectedColor: Colors.white,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: items,
        ),
        appBar: this.appBar,
        body: this.body,
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
//    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: false,
//      overlayBuilder: (context, offset) {
//        return CenterAbout(
//          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
//          child: FabWithIcons(
//            icons: icons,
//            onIconTapped: _selectedFab,
//          ),
//        );
//      },
      child: FloatingActionButton(
        backgroundColor:
            this.iconCenter != null ? Colors.transparent : Colors.red,
        onPressed: _onPressCenter,
//        tooltip: 'Increment',
        child: this.iconCenter != null
            ? this.iconCenter
            : Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 30,
              ),
        elevation: 2.0,
      ),
    );
  }

  void _selectedTab(int index) {
    if (this.selectTab != null) {
      this.selectTab(index, items[index].text);
    }
  }

  void _onPressCenter() {
    print('float');
  }
}
