

import 'dart:core';

import 'package:orim/model/notification/notification.dart';

abstract class NotificationRepo {
  Future<List<Notification>> getNotificatios();
  Future<bool> saveNotifications(List<Notification> notis);
}