import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/object/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';
import 'package:orim/utils/remove_html_tag.dart';
import 'package:orim/utils/time_util.dart';
import 'package:photo_manager/photo_manager.dart';

class IssueModel {
  String id;
  String location;
  Position position;
  String content;
  String dateText;
  String timeText;
  String dateResolved;
  String timeResolved;
  Sender sender;
  int status;
  String imgUrl;
  List<Attachment> videoAttachments = [];
  List<Attachment> imageAttachments = [];
  double rating;
  String ratingComment;

  final String category;
  final String subCategory;
  final String processComment;
  final String statusName;
  final String resolvedComment;
  String background =
      'https://image.bizlive.vn/uploaded/tuanviet_tt/2019_01_22/ket-xe-1_r_680x0_qcao.jpg';
  List<Attachment> imageResolveAttachment = [];
  List<Attachment> videoResolveAttachment = [];

  List<OfficerModel> officerAssigned;

  List<Supporter> supporters;

  IssueModel(
      {this.id,
      this.location,
      this.position,
      this.content,
      this.dateText,
      this.timeText,
      this.dateResolved,
      this.timeResolved,
      String idSender = "",
      String nameSender = "",
      String phoneNumber = "",
      String email = "",
      this.status,
      List<Attachment> videoAttachments,
      List<Attachment> imageAttachments,
      this.category,
      this.subCategory,
      this.processComment,
      this.resolvedComment,
      this.statusName,
      rating,
      this.ratingComment,
      this.imgUrl,
      List<Attachment> imageResolveAttachment,
      List<Attachment> videoResolveAttachment,
      List<OfficerModel> officerAssigned,
      List<Supporter> supporter}) {
    this.sender = Sender(
        id: idSender, name: nameSender, phoneNumber: phoneNumber, email: email);
    if (imageAttachments != null && imageAttachments.length > 0) {
      background = StringResource.getLinkResource(imageAttachments[0].url);
    }
    if (rating != null) {
      this.rating = rating is String ? double.parse(rating) : rating;
    }
    this.videoAttachments = videoAttachments != null ? videoAttachments : [];
    this.imageAttachments = imageAttachments != null ? imageAttachments : [];
    this.imageResolveAttachment =
        imageResolveAttachment != null ? imageResolveAttachment : [];
    this.videoResolveAttachment =
        videoResolveAttachment != null ? videoResolveAttachment : [];
    this.officerAssigned = officerAssigned != null ? officerAssigned : [];
    this.imgUrl = imgUrl;
  }

  static IssueModel from(Issue issue) {
    List<OfficerModel> officerAssigned = [];
    List<Supporter> supporters = [];
    if (issue.olderAssignees != null && issue.olderAssignees.length > 0) {
      issue.olderAssignees.map((item) {
        if (item.objectType == 'Officer') {
          officerAssigned.add(OfficerModel(
            id: item.id,
            departmentId: item.departmentId,
            fullname: item.name,
            departmentName: item.departmentName,
          ));
        } else {
          print('not defined type for this assignees');
        }
      });
    }
    if (issue.currentSupports != null && issue.currentSupports.length > 0) {
      issue.currentSupports.map((e) {
        supporters.add(Supporter(name: e.name));
      });
    }
    return IssueModel(
      id: issue.id,
      location: issue.areadetail,
      position: issue.position,
      content: issue.content,
      dateText: TimeUtil.convertStringToTextDate(issue.createdOn),
      timeText: TimeUtil.convertStringToTextTime(issue.createdOn),
      dateResolved: (issue.status) == 14 || (issue.status) == 34
          ? TimeUtil.convertStringToTextDate(issue.resolvedDate)
          : "",
      timeResolved: (issue.status) == 14 || (issue.status) == 34
          ? TimeUtil.convertStringToTextTime(issue.resolvedDate)
          : "",
      idSender: issue.contact.accountId.toString(),
      nameSender: issue.contact.name,
      phoneNumber: issue.contact.phoneNumber,
      email: issue.contact?.email ?? "",
      status: issue.status,
      resolvedComment:
          GetStringFromHtml.resolveCommentValue(issue.resolvedComment),
      imageAttachments: issue.attachment
          ?.map((e) => Attachment(
              url: StringResource.getLinkResource(e.filePath),
              type: AssetType.image))
          ?.toList(),
      videoAttachments: issue.videoAttachment
          ?.map((e) => Attachment(
              url: StringResource.getLinkResource(e.filePath),
              type: AssetType.video))
          ?.toList(),
      category: issue.category?.name ?? "",
      subCategory: issue.subcategory?.name ?? "",
      processComment: issue.processComment ?? "",
      statusName: issue.statusName ?? "",
      rating: issue.rating ?? null,
      ratingComment: issue.ratingComment ?? null,
      imageResolveAttachment: issue.resolveAttachment?.map((e) {
        return Attachment(
          url: StringResource.getLinkResource(e.filePath),
          type: AssetType.image,
        );
      })?.toList(),
      videoResolveAttachment: issue.videoResolveAttachment?.map((e) {
        return Attachment(
          url: StringResource.getLinkResource(e.filePath),
          type: AssetType.video,
        );
      })?.toList(),
      officerAssigned: officerAssigned,
      imgUrl: issue.imageurl,
      supporter: supporters,
    );
  }
}

class Supporter {
  String name;

  Supporter({this.name});
}

class Sender {
  String id;
  String name;
  String phoneNumber;
  String email;

  Sender({this.id, this.name, this.phoneNumber, this.email});
}
