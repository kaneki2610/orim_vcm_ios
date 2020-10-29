import 'package:flutter/material.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/main_view.dart';
import 'package:orim/services/notification.dart';

class MainBloc extends BaseBloc {
  MainBloc({BuildContext context, MainView view})
      : super(context: context) {
        this._view = view;
      }

  NotificationService _notificationService = NotificationService.getInstance();
  MainView _view;

  void notificationConfig() {
    _notificationService.config();
  }


  @override
  void dispose() {
    _notificationService.dispose();
  }
}
