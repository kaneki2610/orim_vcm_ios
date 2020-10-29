
import 'package:orim/model/notification/notification.dart';
import 'package:orim/storage/notification/local/notification_local.dart';

import 'Notification_repo.dart';

class NotificationImp implements NotificationRepo{
  NotificationLocal notificationLocal;

  @override
  Future<List<Notification>> getNotificatios() async {
    
    return await notificationLocal.getNotificatios();
  }

  @override
  Future<bool> saveNotifications(List<Notification> notis) async {
    return await notificationLocal.saveNotifications(notis);
  }
  
}