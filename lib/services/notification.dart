import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/model/notification/notification.dart';
import 'package:vnpt_notifications_package/vnpt_notifications_package.dart';

class NotificationService {
  static NotificationService _instance;

  static NotificationService getInstance() {
    if (_instance == null) {
      _instance = NotificationService();
    }
    return _instance;
  }

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  BehaviorSubject<Notification> _notificationSubject = BehaviorSubject();

  Stream<Notification> get notification => _notificationSubject.stream;

  List<StreamSubscription> listeners = [];

  VNPTNotifications _vnptNotifications;

  void config() async {
    if (Platform.isIOS) {
      if (this._vnptNotifications == null) {
        this._vnptNotifications = VNPTNotifications(
            onPush: (Map<String, dynamic> message) {
              print("onPush: $message");
              String action = message['action'];
              String content = message['body'];
              String title = message['title'];
              String url = message['url'];
              String idIssue = message['issueid'];
              _notificationSubject.value = Notification(
                  action: action,
                  title: title,
                  content: content,
                  url: url,
                  idIssue: idIssue);
            },
            onBackgroundPush: (Map<String, dynamic> message) {
              String action = message['action'];
              String content = message['body'];
              String title = message['title'];
              String url = message['url'];
              String idIssue = message['issueid'];
              _notificationSubject.value = Notification(
                  action: action,
                  title: title,
                  content: content,
                  url: url,
                  idIssue: idIssue);
            },
            apiToken:
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBfaWQiOiJjb20uYmluaHBodW9jdG9kYXkuaW9zLmRlbW8iLCJhcHBfdHlwZSI6ImlvcyIsImV4cCI6MTYzMDEyNDU4MywidXNlcl9pZCI6Imh1bmdfdGVzdCJ9._xZXrF0YBxsNL-er66z9S2FtkoIVhWenqx5T1YWvoV8");
        this._vnptNotifications.subcribeVnptCloudMessage(['/topics/default']);
      }
    }
  }

  // Future<bool> requestPermission() async {
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  //   return await _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(
  //         sound: true, badge: true, alert: true, provisional: false),
  //   );
  // }

  Future<String> get token async {
    final String token = "c87628f1d34b0fcdfppwj1r3b214ttv8617y";
    return token;
  }

//   void config() async {
//     _firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//       print("onMessage: $message");
//       _onBackgroundMessage(message);
//     }, onLaunch: (Map<String, dynamic> message) async {
//       print("onLaunch: $message");
//       _onBackgroundMessage(message);
//     },
// //      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
//         onResume: (Map<String, dynamic> message) async {
//       print("onResume: $message");
//       _onBackgroundMessage(message);
//     });
//   }

  Future<void> _onBackgroundMessage(Map<String, dynamic> message) async {
    print("_onBackgroundMessage: $message");
    String action = '';
    String title = '';
    String content = '';
    String url = '';
    String idIssue = '';

    if (Platform.isIOS) {
      print("iossssss");
      // if (message.containsKey('notification')) {
      //   final Map<dynamic, dynamic> notification = message['notification'];
      //   content = notification.containsKey('body') ? notification['body'] : '';
      //   title = notification.containsKey('title') ? notification['title'] : '';
      // } else if (message.containsKey('result')) {
      //   print("cccccccc");
      //   //print("${message.containsKey('result')}");
      //   final Map<String, dynamic> alert = message['result'];
      //   action = alert.containsKey('action') ? alert['action'] : '';
      //   content = alert.containsKey('body') ? alert['body'] : '';
      //     title = alert.containsKey('title') ? alert['title'] : '';
      //     url = alert.containsKey('url') ? alert['url'] : '';
      //     idIssue = alert.containsKey('issueid') ? alert['issueid'] : '';
      //   // if (aps.containsKey('result')) {
      //   //   final Map<dynamic, dynamic> alert = aps['alert'];
      //   //   print('alert $alert');
      //   //   content = alert.containsKey('body') ? alert['body'] : '';
      //   //   title = alert.containsKey('title') ? alert['title'] : '';
      //   //   url = alert.containsKey('url') ? alert['url'] : '';
      //   //   idIssue = alert.containsKey('issueid') ? alert['issueid'] : '';
      //   // }
      // }
    } else if (Platform.isAndroid) {
      if (message.containsKey('data')) {
        final Map<dynamic, dynamic> data = message['data'];
        action = data.containsKey('action') ? data['action'] : '';
        content = data.containsKey('body') ? data['body'] : '';
        title = data.containsKey('title') ? data['title'] : '';
        url = data.containsKey('url') ? data['url'] : '';
        idIssue = data.containsKey('issueid') ? data['issueid'] : '';
      }
    }
    _notificationSubject.value = Notification(
        action: action,
        title: title,
        content: content,
        url: url,
        idIssue: idIssue);
  }

  void listenNotification({Function(Notification) onNotification}) {
    this.cancelListener();
    listeners.add(_notificationSubject.listen(onNotification));
  }

  void dispose() {
    this.cancelListener();
    _notificationSubject.close();
  }

  void cancelListener() {
     for (final listen in listeners) {
      listen.cancel();
    }
  }

  // void requestNotificationPermissions() {
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(
  //           sound: true, alert: true, provisional: false, badge: true));
  // }

  void removeNotification() {
    _notificationSubject.value = null;
  }

  // dont need use
//  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//    print('myBackgroundMessageHandler');
//    if (message.containsKey('data')) {
//      final dynamic data = message['data'];
//      print('data $data');
//    }
//
//    if (message.containsKey('notification')) {
//      final dynamic notification = message['notification'];
//      print('data $notification');
//    }
//  }
}
