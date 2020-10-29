import 'package:flutter/cupertino.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/observer/delete_all_notification.dart';
import 'package:provider/provider.dart';


class NotificationTabbarBloc extends BaseBloc {
  DeleteAllNotificaitonObserver _deleteAllNotificaitonObserver;
  NotificationTabbarBloc({BuildContext context})
        : super(context: context);

  @override
  void updateDependencies(BuildContext context) {
    this._deleteAllNotificaitonObserver = Provider.of<DeleteAllNotificaitonObserver>(context);
    super.updateDependencies(context);
  }

  void deleteAllNotification(){
    this._deleteAllNotificaitonObserver.data = true;
  }

  @override
  void dispose() {

  }
}