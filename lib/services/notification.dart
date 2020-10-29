import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/app_config.dart';
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

  //firebase
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  BehaviorSubject<Notification> _notificationSubject = BehaviorSubject();

  Stream<Notification> get notification => _notificationSubject.stream;
  List<StreamSubscription> listeners = [];

  //vnpt cloud message
  VNPTNotifications _vnptNotifications;
  BehaviorSubject<Notification> _notificationVcmSubject = BehaviorSubject();

  Stream<Notification> get notificationVcm => _notificationSubject.stream;
  List<StreamSubscription> listenersVcm = [];

  void configVcm() async {
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
              _notificationVcmSubject.value = Notification(
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
              _notificationVcmSubject.value = Notification(
                  action: action,
                  title: title,
                  content: content,
                  url: url,
                  idIssue: idIssue);
            },
            apiToken:
                "Bearer ${AppConfig.apiKeyVcm}");
        this._vnptNotifications.subcribeVnptCloudMessage(['/topics/orim_vcm_ios']);
      }
    }
  }

  Future<String> get tokenVcm async {
    final String token = await this._vnptNotifications.getNotificationsToken();
    return token;
  }

  void listenNotificationVCM({Function(Notification) onNotification}) {
    this.cancelListenerVCM();
    listenersVcm.add(_notificationVcmSubject.listen(onNotification));
  }

  void cancelListenerVCM() {
    for (final listen in listenersVcm) {
      listen.cancel();
    }
  }

  void removeNotificationVCM() {
    _notificationVcmSubject.value = null;
  }

  //firebase
  Future<bool> requestPermission() async {
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    return await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
  }

  Future<String> get token async {
    final String token = await this._firebaseMessaging.getToken();
    return token;
  }

  void config() async {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      _onBackgroundMessage(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      _onBackgroundMessage(message);
    },
        //      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
        onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      _onBackgroundMessage(message);
    });
  }

  Future<void> _onBackgroundMessage(Map<String, dynamic> message) async {
    print("_onBackgroundMessage: $message");
    String action;
    action = message.containsKey('action') ? message['action'] : '';
    String title = '';
    String content = '';
    String url = message.containsKey('url') ? message['url'] : '';
    String idIssue = message.containsKey('issueid') ? message['issueid'] : '';

    if (Platform.isIOS) {
      if (message.containsKey('notification')) {
        final Map<dynamic, dynamic> notification = message['notification'];
        content = notification.containsKey('body') ? notification['body'] : '';
        title = notification.containsKey('title') ? notification['title'] : '';
        if (notification.containsKey('url')) {
          url = notification.containsKey('url') ? notification['url'] : '';
        }
        if (notification.containsKey('issueid')) {
          idIssue = notification.containsKey('issueid')
              ? notification['issueid']
              : '';
        }
      } else if (message.containsKey('aps')) {
        final Map<dynamic, dynamic> aps = message['aps'];
        if (aps.containsKey('alert')) {
          final Map<dynamic, dynamic> alert = aps['alert'];
          print('alert $alert');
          content = alert.containsKey('body') ? alert['body'] : '';
          title = alert.containsKey('title') ? alert['title'] : '';
          if (alert.containsKey('url')) {
            url = alert.containsKey('url') ? alert['url'] : '';
          }
          if (alert.containsKey('issueid')) {
            idIssue = alert.containsKey('issueid') ? alert['issueid'] : '';
          }
        }
      }
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
    this.cancelListenerVCM();
    _notificationSubject.close();
    _notificationVcmSubject.close();
  }

  void cancelListener() {
    for (final listen in listeners) {
      listen.cancel();
    }
  }

  void requestNotificationPermissions() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, alert: true, provisional: false, badge: true));
  }

  void removeNotification() {
    _notificationSubject.value = null;
  }
}
