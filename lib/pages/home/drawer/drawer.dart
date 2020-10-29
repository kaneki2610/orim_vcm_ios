import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/drawer_menu.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/menu_item.dart';
import 'package:orim/model/personal_info/personal_info.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/home/drawer/drawer_bloc.dart';
import 'package:orim/utils/widget/widget.dart';

class DrawerContent extends StatefulWidget {
  final Function({String routeName, String code}) onClickItemMenu;

  DrawerContent({this.onClickItemMenu});

  @override
  _DrawerState createState() {
    return _DrawerState();
  }
}

class _DrawerState extends BaseState<DrawerBloc, DrawerContent> {

  @override
  void onPostFrame() {
    bloc.listenDataChange();
  }

  @override
  void initBloc() {
    bloc = DrawerBloc(context: context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc?.updateDependencies(context);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SafeArea(
          child: renderHeaderDrawer(),
        ),
        Expanded(
          child: StreamBuilder(
            stream: bloc.menuObserver,
            builder: (context, AsyncSnapshot<List<MenuItem>> snapshot) {
              List<MenuItem> list = snapshot.hasData
                  ? snapshot.data.where((e) => e.visible).toList()
                  : [];
              return ListView(
                padding: EdgeInsets.only(top: 0),
                children: list
                    .map((item) => DrawerMenu(
                          leading: ImageView.asset(item.icon,
                              width: 40,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover),
                          title:
                              Text(StringResource.getText(context, item.name)),
                          onTap: () {
                            this._onTapMenu(item.routeName ?? "", item.code ??"");
                            },
                        ))
                    .toList(),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: DimenResource.paddingContent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageView.asset(
                ImageResource.logo,
                scale: 1.5,
                color: Theme.of(context).primaryColor,
              ),
              Container(
                padding: EdgeInsets.all(DimenResource.paddingContent),
                child: Text(
                  StringResource.getText(context, 'dev_unit') + ': VNPT - IT',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _gotoLogin() {
    if (NavigatorService.back(context)) {
      NavigatorService.gotoSignIn(context);
    }
  }

  void _onTapMenu(String routeName, String code) {
    if (widget.onClickItemMenu != null) {
      if (NavigatorService.back(context)) {
        widget.onClickItemMenu(routeName: routeName, code: code);
      }
    }
  }

  Widget renderHeaderDrawer() {
    return StreamBuilder(
        stream: bloc.personalInfoObserver,
        builder: (context, AsyncSnapshot<PersonalInfoModel> snapshot) {
          print('snapshot ${snapshot.hasData}');
          if (snapshot.hasData) {
            return _renderUserHeader(snapshot.data);
          } else {
            return _renderHeaderLogin();
          }
        });
  }

  Widget _renderHeaderLogin() {
    return InkWell(
      onTap: _gotoLogin,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ImageView.asset(ImageResource.avatar, width: 90, height: 90),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      StringResource.getText(context, 'you_not_login')
                          .toUpperCase(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      StringResource.getText(context, 'login'),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderUserHeader(PersonalInfoModel data) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageView.asset(ImageResource.avatar, width: 90, height: 90),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width*0.45,
                    child: Text(
                      data.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
                Container(
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        data.phoneNumber,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 12),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//class MenuItem {
//  String icon;
//  String title; // String resource
//  String routeName;
//  String tabName;
//  bool visible;
//
//  MenuItem({this.icon, this.title, this.routeName, this.visible});
//}
