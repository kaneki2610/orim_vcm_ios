import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/home/tab/operating/operating_bloc.dart';
import 'package:orim/pages/home/tab/operating/operating_view.dart';

class OperationPage extends StatefulWidget {
  const OperationPage();

  static const routeName = 'operating_title';

  @override
  State<StatefulWidget> createState() {
    return _OperatingState();
  }
}

class _OperatingState extends BaseState<OperatingBloc, OperationPage>
    with OperatingView, AutomaticKeepAliveClientMixin<OperationPage> {
  @override
  void initBloc() {
    bloc = OperatingBloc(context: context, view: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
  }

  @override
  void onPostFrame() {
    bloc.getIssues();
    bloc.getOfficer();
  }

  @override
  void updateKeepAlive() {
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Điều hành'),
      ),
    );
  }
}

class OperatorPageTabbar extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;

  const OperatorPageTabbar({
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
          titleText: StringResource.getText(context, 'operating_title'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
