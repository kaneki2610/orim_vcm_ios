import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressDialogLoading {
  ProgressDialogLoading({BuildContext context})
      : _context = context,
        pr = ProgressDialog(context) {
    pr.style(
      progressWidget: CircularProgressIndicator(),
      message: StringResource.getText(_context, 'waiting'),
    );
  }

  final BuildContext _context;
  final ProgressDialog pr;

  Future<bool> show() async {
    return await pr.show();
//    AlertDialogBuilder.showLoading(_context);
  }

  updateProgress(int sent, int total) {
    pr.update(
      message: StringResource.getText(_context, 'uploading'),
      progress: sent * 100.0 / total,
      maxProgress: 100.0,
    );
  }

  Future<bool> hide() async {
//    Navigator.of(_context).pop();
    await Future.delayed(Duration(milliseconds: 300));
    return await pr.hide();
  }
}
