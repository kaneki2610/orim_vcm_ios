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
import 'package:orim/pages/home/tab/administration/administration_bloc.dart';
import 'package:orim/pages/home/tab/administration/administration_view.dart';

class AdministrationPage extends StatefulWidget {
  const AdministrationPage();

  static const routeName = 'admin_title';

  @override
  State<StatefulWidget> createState() {
    return _AdministrationState();
  }
}

class _AdministrationState
    extends BaseState<AdministrationBloc, AdministrationPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<AdministrationPage>
    implements
        AdministrationView{
  @override
  void initBloc() {
    bloc = AdministrationBloc(context: context, view: this, ticker: this);
  }

  @override
  void onPostFrame() {
    this.bloc.listenDataChange();
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
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
                      width: double.infinity,
                      color: Colors.white, //Theme.of(context).primaryColor,
                      child: TabBar(
                        isScrollable: true,
                        controller: this.bloc.tabController,
                        indicatorColor: ColorsResource.primaryColor,
                        labelColor: ColorsResource.primaryColor,
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
                    child: Text(StringResource.getText(
                        context, "administration_no_permission")),
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
      ),
    );
  }
}

class AdministationTabbar extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;

  const AdministationTabbar({
    Key key,
    this.height = DimenResource.heightTabbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      isLightStatus: true,
      child: AppBar(
        leading: DrawerToggle(),
        title: TitleContainer(
          titleText: StringResource.getText(context, 'admin_title'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
