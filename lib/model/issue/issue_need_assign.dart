import 'package:geolocator/geolocator.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';

class IssuesNeedAssignModel extends IssueModel {
  IssuesNeedAssignModel(
      {String id,
      String location,
      Position position,
      String content,
      String dateText,
      String timeText,
      String idSender = "",
      String nameSender = "",
      String phoneNumber = "",
      String email = "",
      int status,
      List<Attachment> videoAttachments,
      List<Attachment> imageAttachments,
      String category,
      String subCategory,
      String processComment,
      String statusName,
      double rating,
      String ratingComment,
      List<Attachment> imageResolveAttachment,
      List<Attachment> videoResolveAttachment})
      : super(
            id: id,
            location: location,
            content: content,
            dateText: dateText,
            timeText: timeText,
            idSender: idSender,
            nameSender: nameSender,
            phoneNumber: phoneNumber,
            email: email,
            status: status,
            videoAttachments: videoAttachments,
            imageAttachments: imageAttachments,
            category: category,
            subCategory: subCategory,
            processComment: processComment,
            statusName: statusName,
            rating: rating,
            ratingComment: ratingComment,
            imageResolveAttachment: imageResolveAttachment,
            videoResolveAttachment: videoResolveAttachment);
}
