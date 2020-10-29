import 'package:orim/model/notification/notification.dart';
import 'package:orim/utils/storage/storage.dart';

import 'notification_local.dart';

class NotificationLocalImp implements NotificationLocal {
  Storage storage;
  final String keyNotifications = 'notifications';

  @override
  Future<List<Notification>> getNotificatios() async {
    List<Notification> notis = [];
    try {
      List res = await storage.readList(keyNotifications);
      if (res != null) {
        notis = res.map((e) => Notification.fromJson(e)).toList();
      }
      return notis;
    } catch (err) {
      return notis;
    }
  }

  @override
  Future<bool> saveNotifications(List<Notification> notis) async {
    if(notis == null){
      notis = [];
    }
    var lists = [];
    for (Notification noti in notis) {
      lists.add(noti.toJson());
    }
    try {
      return await storage.writeList(keyNotifications, lists);
    } catch (err) {
      return false;
    }
  }
}
