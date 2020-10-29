import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/attachment_component.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/show_full_gallery/show_full_meida.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';

class IssueAttachment extends StatelessWidget {
  const IssueAttachment(
      {this.images,
      this.videos,
      this.titleImageAttachment,
      this.titleVideoAttachment});

  final List<Attachment> images, videos;
  final String titleImageAttachment, titleVideoAttachment;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    if (images.length > 0) {
      list.add(_renderImageAttachment(context));
    }
    if (videos.length > 0) {
      list.add(_renderVideoAttachment(context));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget _renderImageAttachment(BuildContext context) {
    final Color colorTitle = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.attachment,
              color: colorTitle,
            ),
            Container(
              padding: EdgeInsets.only(left: DimenResource.padding5,),
              child: Text(
                titleImageAttachment,
                style: TextStyle(
                    color: colorTitle,
                    fontWeight: FontWeight.bold,
                    fontSize: DimenResource.textTitleSize),
              ),
            ),
          ],
        ),
        SizedBox(height: DimenResource.padding5,),
        _ImageAttachment(
          images: images,
        )
      ],
    );
  }

  Widget _renderVideoAttachment(BuildContext context) {
    final Color colorTitle = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.video_call,
              color: colorTitle,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0,bottom: DimenResource.paddingContent),
              child: Text(
                titleVideoAttachment,
                style: TextStyle(
                    color: colorTitle,
                    fontWeight: FontWeight.bold,
                    fontSize: DimenResource.textTitleSize),
              ),
            ),
          ],
        ),
        _VideoAttachment(
          videos: videos,
        )
      ],
    );
  }
}

class _ImageAttachment extends StatelessWidget {
  const _ImageAttachment({this.images});

  final List<Attachment> images;
  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, height: (MediaQuery
        .of(context)
        .size
        .width - 5) * 0.23,
      child: ListView.separated(itemBuilder: (context, index) {
        return Container(
          height: (MediaQuery
              .of(context)
              .size
              .width - 5) * 0.23,
          width: (MediaQuery
              .of(context)
              .size
              .width - 5) * 0.23,
          child: AttachmentComponent(
            attachment: this.images[0],
            onPress: () => _showFullImage(context, this.images[0]),
          ),
        );
      }, separatorBuilder: (context, index) {
        return SizedBox(width: 5.0,);
      }, itemCount: images.length,
        scrollDirection: Axis.horizontal,),);
  }

  void _showFullImage(BuildContext context, Attachment attachment) {
    final int index = images.indexOf(attachment);
    final ShowFullMediaArguments arguments = ShowFullMediaArguments(
      medias: images,
      positionSelect: index,
    );
    NavigatorService.gotoShowFullGallery(context, arguments: arguments);
  }
}

class _VideoAttachment extends StatelessWidget {
  const _VideoAttachment({this.videos});

  final List<Attachment> videos;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: videos.map((video) {
        return Container(
          height: DimenResource.heightBanner,
          width: double.infinity,
          child: AttachmentComponent(attachment: video, onPress: () => _showFullImage(context, video),),
        );
      }).toList(),
    );
  }

  void _showFullImage(BuildContext context, Attachment attachment) {
    final int index = videos.indexOf(attachment);
    final ShowFullMediaArguments arguments = ShowFullMediaArguments(
      medias: videos,
      positionSelect: index,
    );
    NavigatorService.gotoShowFullGallery(context, arguments: arguments);
  }
}
