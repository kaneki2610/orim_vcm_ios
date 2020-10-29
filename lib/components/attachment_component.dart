import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';
import 'package:orim/utils/widget/widget.dart';
import 'package:video_player/video_player.dart';

class AttachmentComponent extends StatefulWidget {
  final Attachment attachment;
  Function onPress;
  final Widget overlay;
  final Widget icon;

  AttachmentComponent({this.attachment, this.onPress, this.overlay, this.icon});

  @override
  State<StatefulWidget> createState() {
    return AttachmentState();
  }
}

class AttachmentState extends State<AttachmentComponent> {
  VideoPlayerController _controller;

  Future<bool> loadThumbnail() async {
    try {
      if (this._controller == null) {
        this.initVideoController();
      }
      await _controller.initialize();
      return true;
    } catch (err) {
      print('load video: $err');
      throw err;
    }
  }

  @override
  void initState() {
    if (widget.attachment.isVideo()) {
      this.initVideoController();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onPress,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Center(
          child: Stack(
            children: <Widget>[
              _renderAttach(),
//              widget.attachment.isVideo()
//                  ? Center(
//                      child:
//                          Icon(Icons.play_circle_filled, color: Colors.white),
//                    )
//                  : Container(),
              widget.overlay ?? Container(),
              widget.icon ?? Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAttach() {
    if (widget.attachment.thumbnailData != null) {
      if (widget.attachment.isImage()) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child:   ImageView.memory(
            widget.attachment.thumbnailData,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
          ),
        );
      } else {
        return Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ImageView.memory(
                widget.attachment.thumbnailData,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),
            Center(
              child: Icon(Icons.play_circle_filled, color: Colors.white),
            )
          ],
        );
      }
    } else if (widget.attachment.file != null) {
      if (widget.attachment.isImage()) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: ImageView.file(
            widget.attachment.file,
            fit: BoxFit.cover,
          ),
        );
      } else {
        return _videoItem();
      }
    } else if (widget.attachment.url != null) {
      if (widget.attachment.isImage()) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: ImageView.network(widget.attachment.url, fit: BoxFit.cover),
        );
      } else {
        return _videoItem();
      }
    } else {
      throw 'attachment is not valid';
    }
  }

  Widget _videoItem() {
    return FutureBuilder(
      future: loadThumbnail(),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: <Widget>[
              VideoPlayer(_controller),
              Center(
                child: Icon(Icons.play_circle_filled, color: Colors.white),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Container(
            color: ColorsResource.backgroundColorOverlaySelected,
            child: Center(
              child: Icon(
                Icons.not_interested,
                color: Colors.white,
                size: 60,
              ),
            ),
          );
        } else {
          return Container(
            child: Center(
              child: Loading(),
            ),
          );
        }
      },
    );
  }

  void _onPress() {
    if (widget.onPress != null) {
      widget.onPress();
    }
  }

  void initVideoController() {
    if (widget.attachment.url != null && widget.attachment.url.isNotEmpty) {
      _controller = VideoPlayerController.network(widget.attachment.url);
//        _controller = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    } else if (widget.attachment.file != null) {
      _controller = VideoPlayerController.file(widget.attachment.file);
    }
  }
}
