import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/home/tab/handle_complain/mobx/handle_complain_mobx.dart';

import 'handle_complain_bloc.dart';

class HandleComplainPage extends StatefulWidget {
  static const String routeName = 'handel_complain_title';
  final ComplainMobx _complainMobx;

  const HandleComplainPage({ComplainMobx mobx}) : _complainMobx = mobx;

  @override
  State<StatefulWidget> createState() {
    return HandleComPlainPageState();
  }
}

class HandleComPlainPageState
    extends BaseState<HandleComPlainPageBloc, HandleComplainPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HandleComplainPage> {
  @override
  void initBloc() {
    this.bloc = HandleComPlainPageBloc(context, this.widget._complainMobx);
  }

  @override
  void onPostFrame() {
    this.bloc.listenDataChange(this);
  }

  @override
  void didChangeDependencies() {
    bloc.updateDependencies(context);
    super.didChangeDependencies();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: this.bloc.streamUpdateView,
        builder: (context, data) {
          if (data.hasData) {
            if (data.data) {
              return Column(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).primaryColor,
                    child: TabBar(
                      controller: this.bloc.tabController,
                      indicatorColor: Colors.white,
                      tabs: this.bloc.tabs,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: this.bloc.tabController,
                      children: this.bloc.tabViews,
                    ),
                  )
                ],
              );
            } else {
              return Container(
                child: Center(
                  child: Text(
                      StringResource.getText(
                          context, "no_permission_view_feature"),
                      style: TextStyle(
                          color: ColorsResource.backgroundColorTabbar)),
                ),
              );
            }
          } else {
            return Center(
              child: Loading(
                circleColor: ColorsResource.primaryColor,
                backgroundColor: Colors.white,
              ),
            );
          }
        },
      ),
    ));
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;
}

class HandleComPlainTab extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final ComplainMobx _complainMobx;

  const HandleComPlainTab({
    Key key,
    this.height = DimenResource.heightTabbar,
    ComplainMobx mobx,
  })  : _complainMobx = mobx,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      isLightStatus: true,
      child: AppBar(
        elevation: 0.0,
        leading: DrawerToggle(),
        title: TitleContainer(
          titleText: StringResource.getText(context, 'handel_complain_title'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _complainMobx.toggleSearch,
          ),
//          IconButton(
//            icon: Icon(Icons.calendar_today),
//            onPressed: _complainMobx.toggleCalendar,
//          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
