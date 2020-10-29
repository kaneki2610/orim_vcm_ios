import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:orim/components/attachment_component.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/attachments_picker/attachments_picker_bloc.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';

class AttachmentsPickerPage extends StatefulWidget {
  static const String routeName = 'AttachmentsPickerPage';
  static const String title = 'title_attachment_page'; // key

  final AttachmentPickerArguments arguments;

  AttachmentsPickerPage({@required this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _AttachmentsPickerState();
  }
}

class _AttachmentsPickerState extends State<AttachmentsPickerPage> {
  AttachmentsPickerBloc _attachmentsPickerBloc;

//  Future<List<Attachment>> listFile;

  @override
  void initState() {
    super.initState();
    _attachmentsPickerBloc = AttachmentsPickerBloc(
        context: context, listImageSelected: widget.arguments.listImage);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (await loadImageAndVideo()) {
        await _attachmentsPickerBloc.loadLibraryIfNeed();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachmentsPickerBloc.updateDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleContainer(
          titleText:
              StringResource.getText(context, AttachmentsPickerPage.title),
          titleColor: ColorsResource.textColorTitle,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: DimenResource.paddingContent,
                  right: DimenResource.paddingContent,
                  top: DimenResource.paddingContent),
              child: StreamBuilder(
                  stream: _attachmentsPickerBloc.countNumImageObserver,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return _statusCount(
                        content: StringResource.getText(
                            context, 'count_images_selected'),
                        max: _attachmentsPickerBloc.maxNumImageSelected,
                        min: snapshot.hasData ? snapshot.data : 0);
                  }),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: DimenResource.paddingContent,
                  right: DimenResource.paddingContent,
                  top: DimenResource.paddingContent,
                  bottom: DimenResource.paddingContent),
              child: StreamBuilder(
                  stream: _attachmentsPickerBloc.countNumVideoObserver,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return _statusCount(
                        content: StringResource.getText(
                            context, 'count_images_selected'),
                        max: _attachmentsPickerBloc.maxNumVideoSelected,
                        min: snapshot.hasData ? snapshot.data : 0);
                  }),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _attachmentsPickerBloc.dataObserver,
                builder: _buildGridTiles,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:  RaisedButtonCustom(
                onPressed: next,
                text: StringResource.getText(context, 'next'),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildGridTiles(
      BuildContext context, AsyncSnapshot<List<Attachment>> snapshot) {
    return GridView.extent(
      maxCrossAxisExtent: 120.0,
      children: _listAttachments(snapshot.data),
    );
  }

  List<Widget> _listAttachments(List<Attachment> data) {
    List<Widget> widgets = [];
//    widgets.add(InkWell(
//      onTap: () async {
//        if (await loadImageAndVideo()) {
//          _attachmentsPickerBloc.loadLibraryIfNeed();
//          if (_attachmentsPickerBloc.canRecordVideo) {
//            _attachmentsPickerBloc.openVideoView();
//          } else {
//            _showErrorWhenAttachmentFilled();
//          }
//        }
//      },
//      child: Container(
//        decoration: BoxDecoration(
//            border: Border.all(color: Colors.black),
//            color: ColorsResource.backgroundColorOverlaySelected),
//        child: Center(
//          child: Icon(
//            Icons.videocam,
//            color: Colors.white,
//          ),
//        ),
//      ),
//    ));
//    widgets.add(InkWell(
//      onTap: () async {
//        if (await loadImageAndVideo()) {
//          _attachmentsPickerBloc.loadLibraryIfNeed();
//          if (_attachmentsPickerBloc.canOpenCamera) {
//            _attachmentsPickerBloc.openCameraView();
//          } else {
//            _showErrorWhenAttachmentFilled();
//          }
//        }
//      },
//      child: Container(
//        decoration: BoxDecoration(
//            border: Border.all(color: Colors.black),
//            color: ColorsResource.backgroundColorOverlaySelected),
//        child: Center(
//          child: Icon(Icons.photo_camera, color: Colors.white),
//        ),
//      ),
//    ));
    if (data != null) {
      widgets.addAll(data.map((attachment) {
        return AttachmentComponent(
          attachment: attachment,
          onPress: () {
            if (!_attachmentsPickerBloc.selectItem(attachment)) {
              _showErrorWhenAttachmentFilled();
            }
          },
          overlay: Container(
            color: attachment.selected
                ? ColorsResource.backgroundColorOverlaySelected
                : Colors.transparent,
          ),
          icon: Container(
            alignment: Alignment.topRight,
            child: Icon(
              attachment.selected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: Colors.white,
            ),
          ),
        );
      }).toList());
    }
    return widgets;
  }

  void next() {
    if (_attachmentsPickerBloc.back()) {
      widget.arguments.callback(_attachmentsPickerBloc.itemSelected);
    }
  }

  @override
  void dispose() {
    _attachmentsPickerBloc.dispose();
    super.dispose();
  }

  Future<bool> loadImageAndVideo() async {
    if (await _attachmentsPickerBloc.requestPermission()) {
      return true;
    } else {
      AlertDialogBuilder(
        context: context,
        title: StringResource.getText(context, 'permission_deny_title'),
        content: StringResource.getText(context, 'permission_content_request'),
      ).show(
        actions: [
          AlertDialogBuilder.button(
            text: StringResource.getText(context, 'no'),
            onPress: _attachmentsPickerBloc.back,
          ),
          AlertDialogBuilder.button(
            text: StringResource.getText(context, 'yes'),
            onPress: () {
              if (_attachmentsPickerBloc.back()) {
                _attachmentsPickerBloc.openSetting();
              }
            },
          )
        ],
      );
      return false;
    }
  }

  _showErrorWhenAttachmentFilled() {
    AlertDialogBuilder(
      context: context,
      title: StringResource.getText(context, 'warning_select_attachment'),
      content:
          StringResource.getText(context, 'warning_content_select_attachment'),
      titleColor: Colors.red,
    ).show(cancelable: true);
  }

  Widget _statusCount({String content, int max, int min}) {
    final TextStyle style = TextStyle(
      color: Theme.of(context).primaryColor,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          content,
          style: style,
        ),
        Text(
          '$min/$max',
          style: style,
        )
      ],
    );
  }
}

class AttachmentPickerArguments {
  List<Attachment> listImage;
  Function(List<Attachment>) callback;

  AttachmentPickerArguments({this.listImage, this.callback});
}
