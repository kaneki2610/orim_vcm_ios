import 'package:flutter/material.dart';
import 'package:orim/components/district_component.dart';
import 'package:orim/components/ward_component.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/utils/alert_dialog.dart';

class DialogUtil {
  /// Dismiss dialog
  static void popDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void showDistrictDialog(
    BuildContext context, {
    String name,
    List<CurrentDistrict> districts,
    Function(CurrentDistrict item) callback,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              contentPadding: EdgeInsets.only(
                  left: DimenResource.paddingButton, right: DimenResource.paddingButton, top: DimenResource.paddingContent, bottom: DimenResource.paddingLarg),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;
                  return Container(
                    height: height - 300,
                    width: width - 360,
                    child: DistrictComponent(districts, name,
                        callback: (CurrentDistrict item) {
                      callback(item);
                      popDialog(context);
                    }),
                  );
                },
              ));
        });
  }

  void showWardDialog(
    BuildContext context, {
    List<CurrentWard> wards,
    String code,
    Function(CurrentWard item) callback,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              contentPadding: EdgeInsets.only(
                  left: DimenResource.paddingButton, right: DimenResource.paddingButton, top: DimenResource.paddingContent, bottom: DimenResource.paddingLarg),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;
                  return Container(
                    height: height - 300,
                    width: width - 360,
                    child: WardComponent(wards, code, callback: (CurrentWard item) {
                      callback(item);
                      popDialog(context);
                    }),
                  );
                },
              ));
        });
  }

  void showModalAttachmentOptions(BuildContext context, {
    Function openGalleryCallback,
    Function openCameraCallback,
    Function openVideoViewCallBack,
    Function openVideoCallback
  }) {
    AlertDialogBuilder(
        context: context,
        title: StringResource.getText(context, 'select_attachment_title'))
        .showMultiChoice(cancelable: true, actions: <Widget>[
      Container(
        height: DimenResource.paddingContent,
      ),
      SimpleDialogOption(
        onPressed: openCameraCallback,
        child: Text(StringResource.getText(context, 'take_photo')),
      ),
      Container(
        height: DimenResource.paddingContent,
      ),
      SimpleDialogOption(
        onPressed: openVideoViewCallBack,
        child: Text(StringResource.getText(context, 'record_video')),
      ),
      Container(
        height: DimenResource.paddingContent,
      ),
      SimpleDialogOption(
        onPressed: openGalleryCallback,
        child: Text(StringResource.getText(context, 'from_gallery')),
      ),
      Container(
        height: DimenResource.paddingContent,
      ),
      SimpleDialogOption(
        onPressed: openVideoCallback,
        child: Text(StringResource.getText(context, 'video_gallery')),
      )
    ]);
  }
}
