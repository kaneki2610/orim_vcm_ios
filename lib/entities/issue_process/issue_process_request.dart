import 'package:json_annotation/json_annotation.dart';

part 'issue_process_request.g.dart';

@JsonSerializable(nullable: true)
class IssueProcessRequest {
  IssueProcessRequest({String issueId}) : issueid = issueId;

  String issueid;

  factory IssueProcessRequest.fromJson(Map<String, dynamic> json) =>
      _$IssueProcessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$IssueProcessRequestToJson(this);
}
