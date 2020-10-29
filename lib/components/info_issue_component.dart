import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/pages/show_full_gallery/show_full_meida.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';
import 'package:orim/utils/widget/widget.dart';
import 'package:photo_manager/photo_manager.dart' as PM;

import '../navigator_service.dart';
import 'attachment_component.dart';
import 'leading_widget_text_item.dart';
import 'title_container.dart';

class InfoIssueComponent extends StatelessWidget {
  const InfoIssueComponent({Key key, IssueModel model}) : _model = model;

  final IssueModel _model;

  @override
  Widget build(BuildContext context) {
    final TextStyle areaDetails = TextStyle(
        color: ColorsResource.areaDetails, fontWeight: FontWeight.normal);
    final TextStyle contentIssue = TextStyle(
        color: ColorsResource.contentIssue, fontWeight: FontWeight.normal);
    final TextStyle timeIssue = TextStyle(
        color: ColorsResource.timeIssue, fontWeight: FontWeight.normal);
    final double sizeIcon = 18.0;
    final int maxLine = 2;
    Widget item = Column(
      children: <Widget>[
        SizedBox(
          height: 5.0,
        ),
        LeadingWidgetTextItem(
            Icon(
              Icons.location_on,
              color: ColorsResource.areaDetails,
              size: sizeIcon,
            ),
            this._model.location,
            areaDetails,
            maxLine),
        LeadingWidgetTextItem(
            Icon(
              Icons.insert_drive_file,
              color: ColorsResource.contentIssue,
              size: sizeIcon,
            ),
            this._model.content,
            contentIssue,
            maxLine),
        LeadingWidgetTextItem(
            Icon(
              Icons.access_time,
              color: ColorsResource.timeIssue,
              size: sizeIcon,
            ),
            this._model.dateText + " " + this._model.timeText,
            timeIssue,
            maxLine),
        LeadingWidgetTextItem(
            Text(
              StringResource.getText(context, 'personal_send_complain'),
              style: TextStyle(
                  color: ColorsResource.timeIssue,
                  fontWeight: FontWeight.normal),
            ),
            this._model.sender.name +
                " - " +
                this._model.sender.phoneNumber,
            timeIssue,
            maxLine),
      ],
    );

    return item;
  }

  Widget _renderCategory({String category, String subCategory}) {
    return Padding(
      padding: EdgeInsets.only(top: DimenResource.paddingSubContent),
      child: Text(
        '$category - $subCategory'.toUpperCase(),
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _renderContent({IconData icon, String text}) {
    return Padding(
      padding: EdgeInsets.only(top: DimenResource.paddingSubContent),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: DimenResource.paddingContent),
              child: Text('$text'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderResolvedComment({BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(top: DimenResource.paddingContent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${StringResource.getText(context, "issue_need_assign_select_content_assign")}:",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          Container(
            margin: EdgeInsets.only(top: DimenResource.paddingSubContent, left: DimenResource.marginContent),
            child: Text(this._model.resolvedComment ?? "")
          ),
        ],
      ),
    );
  }

  Widget _renderState({String statusName, int status}) {
    return Container(
      padding: EdgeInsets.only(top: DimenResource.paddingSubContent),
      child: Text(
        '$statusName',
        style: TextStyle(
            color: IssueStatusEnum.getColorByStatus(status),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ImageAttachmentComponent extends StatelessWidget {
  const ImageAttachmentComponent({Key key, IssueModel model}) : _model = model;

  final IssueModel _model;

  @override
  Widget build(BuildContext context) {
    IssueModel model = _model;
    if (model.imageAttachments != null && model.videoAttachments != null) {
      if (model.imageAttachments.length > 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: DimenResource.paddingContent,
            ),
            TitleContainer(
              titleText:
              StringResource.getText(context, 'issue_photo_attachment')
                  .toUpperCase(),
              titleColor: Theme
                  .of(context)
                  .primaryColor,
              fontSize: DimenResource.textTitleSize,
            ),
            SizedBox(height: 6,),
            Container(
              width: double.infinity,
              height: (MediaQuery.of(context).size.width-5)*0.23,
              child: ListView.separated(itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showImageView(context, index);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width-5)*0.23,
                    height: (MediaQuery.of(context).size.width-5)*0.23,
                    child: ImageView.network(
                      model.imageAttachments[index].url,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }, separatorBuilder: (context, index) {
                return Container(
                  width: 5.0,
                );
              }, itemCount: model.imageAttachments.length,
              scrollDirection: Axis.horizontal,),
            )
          ],
        );
      }
    }
    return Container();
  }

  void showImageView(BuildContext context, int index) {
    IssueModel model = _model;
    if (model.imageAttachments != null && model.imageAttachments.length > 0) {
      ShowFullMediaArguments arguments = ShowFullMediaArguments(
          medias: model.imageAttachments, positionSelect: index);
      NavigatorService.gotoShowFullGallery(context, arguments: arguments);
    }
  }
}

class ImageAttachmentResolvedComponent extends StatelessWidget {
  const ImageAttachmentResolvedComponent({Key key, IssueModel model}) : _model = model;

  final IssueModel _model;

  @override
  Widget build(BuildContext context) {
    IssueModel model = _model;
    if (model.imageResolveAttachment != null && model.imageResolveAttachment != null) {
      if (model.imageResolveAttachment.length > 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: DimenResource.paddingContent,
            ),
            TitleContainer(
              titleText:
              StringResource.getText(context, 'issue_approve_image_resolved')
                .toUpperCase(),
              titleColor: Theme.of(context).primaryColor,
              fontSize: DimenResource.textTitleSize,
            ),
            SizedBox(height: 6,),
            Container(width: double.infinity, height: (MediaQuery
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
                  child: InkWell(
                    onTap: () {
                      showImageView(context, index);
                    },
                    child: ImageView.network(
                      model.imageResolveAttachment[index].url,
                      fit: BoxFit.fill,
                    ),
                  )
                );
              }, separatorBuilder: (context, index) {
                return SizedBox(width: 5.0,);
              }, itemCount: model.imageResolveAttachment.length,
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
        );
      }
    }
    return Container();
  }

  void showImageView(BuildContext context, int index) {
    IssueModel model = _model;
    if (model.imageResolveAttachment != null && model.imageResolveAttachment.length > 0) {
      ShowFullMediaArguments arguments = ShowFullMediaArguments(
        medias: model.imageResolveAttachment, positionSelect: index);
      NavigatorService.gotoShowFullGallery(context, arguments: arguments);
    }
  }
}

class VideoAttachmentComponent extends StatelessWidget {
  const VideoAttachmentComponent({Key key, IssueModel model}) : _model = model;

  final IssueModel _model;

  @override
  Widget build(BuildContext context) {
    IssueModel model = _model;
    if (model.videoAttachments != null && model.videoAttachments != null) {
      if (model.videoAttachments.length > 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: DimenResource.paddingContent,
            ),
            TitleContainer(
              titleText:
              StringResource.getText(context, 'issue_video_attachment')
                .toUpperCase(),
              titleColor: Theme.of(context).primaryColor,
              fontSize: DimenResource.textTitleSize,
            ),
            SizedBox(height: 6,),
            Wrap(
              children: model.videoAttachments
                .map((item) => Container(
                height: DimenResource.heightThumbnailVideo,
                child: AttachmentComponent(
                  attachment: Attachment(
                    url: item.url, type: PM.AssetType.video),
                  onPress: () {
                    print('url ${item.url}');
                    final index = model.videoAttachments.indexOf(item);
                    showVideoView(context, index);
                  },
                ),
              ))
                .toList(),
            )
          ],
        );
      }
    }
    return Container();
  }

  void showVideoView(BuildContext context, int index) {
    IssueModel model = _model;
    if (model.videoAttachments != null && model.videoAttachments.length > 0) {
      ShowFullMediaArguments arguments = ShowFullMediaArguments(
        medias: model.videoAttachments, positionSelect: index);
      NavigatorService.gotoShowFullGallery(context, arguments: arguments);
    }
  }
}

class VideoAttachmentResolvedComponent extends StatelessWidget {
  const VideoAttachmentResolvedComponent({Key key, IssueModel model}) : _model = model;

  final IssueModel _model;

  @override
  Widget build(BuildContext context) {
    IssueModel model = _model;
    if (model.videoResolveAttachment != null && model.videoResolveAttachment != null) {
      if (model.videoResolveAttachment.length > 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: DimenResource.paddingContent,
            ),
            TitleContainer(
              titleText:
              StringResource.getText(context, 'issue_approve_video_resolved')
                .toUpperCase(),
              titleColor: Theme.of(context).primaryColor,
              fontSize: DimenResource.textTitleSize,
            ),
            Wrap(
              children: model.videoResolveAttachment
                .map((item) => Container(
                height: DimenResource.heightThumbnailVideo,
                child: AttachmentComponent(
                  attachment: Attachment(
                    url: item.url, type: PM.AssetType.video),
                  onPress: () {
                    print('url ${item.url}');
                    final index = model.videoResolveAttachment.indexOf(item);
                    showVideoView(context, index);
                  },
                ),
              ))
                .toList(),
            )
          ],
        );
      }
    }
    return Container();
  }

  void showVideoView(BuildContext context, int index) {
    IssueModel model = _model;
    if (model.videoResolveAttachment != null && model.videoResolveAttachment.length > 0) {
      ShowFullMediaArguments arguments = ShowFullMediaArguments(
        medias: model.videoResolveAttachment, positionSelect: index);
      NavigatorService.gotoShowFullGallery(context, arguments: arguments);
    }
  }
}
