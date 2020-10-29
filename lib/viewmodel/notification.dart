
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/notification/notification.dart';
import 'package:orim/repositories/notification/Notification_repo.dart';

class NotificationViewModel extends BaseViewModel<List<Notification>> {

  NotificationRepo notificationRepo;

  Future<List<Notification>> getNotifications() async {
    List<Notification> list = await notificationRepo.getNotificatios();
    if(list == null){
      list = [];
    }
    this.data = list;
    return this.data;
  }

  Future<bool> saveNotifications(List<Notification> notis) async {
    this.data = notis ?? [];
    return await notificationRepo.saveNotifications(notis ?? []);
  }

  Future<bool> saveNotification(Notification noti) async {
    if(this.data == null){
      this.data = await notificationRepo.getNotificatios();
    }
    if(this.data == null){
      this.data = [];
    }
    this.data.add(noti);
    return await notificationRepo.saveNotifications(this.data);
  }

  Future<bool> removeNotification(Notification notis) async {
    if(this.data == null){
      this.data = await notificationRepo.getNotificatios();
    }
    this.data.remove(notis);
    this.data = this.data;
    return await notificationRepo.saveNotifications(this.data);
  }

  Future<bool> removeAllNotification() async {
    this.data = [];
    return await notificationRepo.saveNotifications(this.data);
  }

}