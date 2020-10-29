import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/observer/delete_all_notification.dart';
import 'package:orim/pages/home/tab/notification/notification_view.dart';
import 'package:orim/viewmodel/notification.dart';
import 'package:provider/provider.dart';
import 'package:orim/model/notification/notification.dart' as Model;

class NotificationBloc extends BaseBloc {
  NotificationViewModel _notificationViewModel;
  NotificationView _view;
  List<Model.Notification> notifications = [];
  BehaviorSubject<List<Model.Notification>> _notificationSubject =
      BehaviorSubject();

  Stream<List<Model.Notification>> get notificationStream => this._notificationSubject.stream;

  DeleteAllNotificaitonObserver _deleteAllNotificaitonObserver;

  NotificationBloc({BuildContext context, NotificationView view})
      : _view = view,
        super(context: context);

  @override
  void updateDependencies(BuildContext context) {
    this._notificationViewModel = Provider.of<NotificationViewModel>(context);
    this._deleteAllNotificaitonObserver =
        Provider.of<DeleteAllNotificaitonObserver>(context);
    super.updateDependencies(context);
  }

  void listenDataChange() {
    this._notificationViewModel.listener(onDataChange: (datas) {
      this.notifications = datas;
      this._notificationSubject.value = this.notifications ?? [];
    });
    this._deleteAllNotificaitonObserver.listener(onDataChange: (isDelete) {
      if (isDelete) {
        this._deleteAllNotifications();
      }
    });
  }

  void getNotifications() {
    this._notificationViewModel.getNotifications();
  }

  void _deleteAllNotifications() {
    this._notificationViewModel.removeAllNotification();
  }

  void removeItem(Model.Notification model){
    this._notificationViewModel.removeNotification(model);
  }

  Future<void> onRefresh() async {
    await this.getNotifications();
    return;
  }

  @override
  void dispose() {}
}
