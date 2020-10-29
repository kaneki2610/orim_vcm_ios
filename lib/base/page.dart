import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/progress_dialog_loading.dart';

abstract class BaseState<B extends BaseBloc, Page extends StatefulWidget>
    extends State<Page> {
  ProgressDialogLoading _progressDialogLoading;
  B bloc;
  bool isInitBloc = false;
  bool isRunAfterFirstFrame = false;
  Timer _timer;
  ProgressDialogLoading get
  progressDialogLoading {
    if(_progressDialogLoading == null){
      _progressDialogLoading = ProgressDialogLoading(context: context);
    }
   return _progressDialogLoading;
  }

  @override
  void initState() {
    super.initState();
    if (!isInitBloc) {
      initBloc();
      isInitBloc = true;
    }
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      _changeColorStatus();
      if (!isRunAfterFirstFrame) {
        onPostFrame();
        isRunAfterFirstFrame = true;
      }
    });
  }

  void initBloc();

  void onPostFrame() {
    _progressDialogLoading = ProgressDialogLoading(context: context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);

  }

  get isLightStatus => true;

  void _changeColorStatus() {
    if (Platform.isIOS) {
      _timer?.cancel();
      _timer = Timer(Duration(milliseconds: 200), () async {
        try {
          FlutterStatusbarTextColor.setTextColor(isLightStatus
              ? FlutterStatusbarTextColor.light
              : FlutterStatusbarTextColor.dark);
        } catch (err) {
          print(err);
        }
      });
    } else {
      // nothing with android
    }
  }

  Future<void> toastMessage({String msg}) {
    return Fluttertoast.showToast(msg: msg);
  }

  Future<void> toastMessageExpired() {
    return toastMessage(msg: StringResource.getText(context, 'expired'));
  }

  Future<void> toastMessagePermissionDeny() {
    return toastMessage(msg: StringResource.getText(context, 'no_permission'));
  }

  Future<void> toastMessageTimeout() {
    return toastMessage(msg: StringResource.getText(context, 'time_out'));
  }

  Future<void> showPopupWithAction(String message, {String title, @required List<Widget> actions, bool isCancel = false}) {
    if(title == null || title == ""){
      title = StringResource.getText(context, "information");
    }
    AlertDialogBuilder(
        context: context,
        content: message,
        title: title)
        .show(cancelable: isCancel, actions: actions);
  }
}
