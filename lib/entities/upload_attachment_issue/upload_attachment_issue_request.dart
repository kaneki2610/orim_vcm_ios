import 'package:json_annotation/json_annotation.dart';

part 'upload_attachment_issue_request.g.dart';

@JsonSerializable()
class UploadAttachmentIssueRequest {
  String id;
  String token;

  UploadAttachmentIssueRequest({this.id, this.token});

  factory UploadAttachmentIssueRequest.fromJson(Map<String, dynamic> json) => _$UploadAttachmentIssueRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UploadAttachmentIssueRequestToJson(this);
}
