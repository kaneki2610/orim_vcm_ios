import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';

part 'upload_attachment_issue_response.g.dart';

@JsonSerializable()
class UploadAttachmentIssueResponse extends ResponseObject<bool>{
  UploadAttachmentIssueResponse({status, String message})  : super(code: status = status is String ? int.parse(status) : status as int, msg: message){
   this.data = this.isSuccess();
  }

  factory UploadAttachmentIssueResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadAttachmentIssueResponseFromJson(json);

//  Map<String, dynamic> toJson() => _$UploadAttachmentIssueResponseToJson(this);
}
