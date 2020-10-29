import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/refresher.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/notification/notification.dart';
import 'package:orim/pages/home/tab/notification/notifiation_item.dart';
import 'package:orim/pages/home/tab/notification/notification_bloc.dart';
import 'package:orim/pages/home/tab/notification/notification_view.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/model/notification/notification.dart' as Model;
import '../../../../navigator_service.dart';
import 'notification_tabbar_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage();

  static const routeName = 'notification_title';

  @override
  State<StatefulWidget> createState() {
    return _NotificationState();
  }
}

class _NotificationState extends BaseState<NotificationBloc, NotificationPage>
    with NotificationView, AutomaticKeepAliveClientMixin<NotificationPage> {
  @override
  void initBloc() {
    bloc = NotificationBloc(context: context, view: this);
  }

  @override
  void onPostFrame() {
    this.bloc.listenDataChange();
    this.bloc.getNotifications();
    super.onPostFrame();
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
    return Container(
      child: StreamBuilder(
        stream: this.bloc.notificationStream,
        builder: (context, AsyncSnapshot<List<Model.Notification>> snapshot) {
          return Refresher(
            onRefresh: this.bloc.onRefresh,
            contentView: this.getBody(snapshot),
            isLoadMore: false,
          );
        },
      ),
    );
  }

  Widget getBody(AsyncSnapshot<List<Model.Notification>> snapshot){
    if (snapshot.hasData) {
      List<Model.Notification> list = snapshot.data;
      if (list.length > 0) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return NotificationItem(
                model: this.bloc.notifications[index],
                deleteItem: this.bloc.removeItem,
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: ColorsResource.lineAdministration,
              height: 0.0,
            ),
            itemCount: this.bloc.notifications.length);
      } else {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              StringResource.getText(context, "notification_empty"),
              style: TextStyle(color: ColorsResource.primaryColor),
            ),
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
  }
}

class NotificationTabbar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  const NotificationTabbar({
    Key key,
    this.height = DimenResource.heightTabbar,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationTabbarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _NotificationTabbarState
    extends BaseState<NotificationTabbarBloc, NotificationTabbar> {
  @override
  void initBloc() {
    this.bloc = NotificationTabbarBloc(context: context);
  }

  @override
  void didChangeDependencies() {
    this.bloc.updateDependencies(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      isLightStatus: true,
      child: AppBar(
        leading: DrawerToggle(),
        title: TitleContainer(
          titleText: StringResource.getText(context, 'notification_title'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: this.showAlertDeleateAll,
          ),
        ],
      ),
    );
  }

  void showAlertDeleateAll() {
    AlertDialogBuilder(
            context: context,
            content: StringResource.getText(
                context, 'notification_delete_all_content'),
            title: StringResource.getText(
                context, 'notification_delete_all_title'))
        .show(cancelable: true, actions: [
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'cancel'),
          onPress: () => NavigatorService.back(context)),
      AlertDialogBuilder.button(
        text: StringResource.getText(context, 'ok'),
        onPress: () {
          if (NavigatorService.back(context)) {
            this.bloc.deleteAllNotification();
          }
        },
      ),
    ]);
  }
}
