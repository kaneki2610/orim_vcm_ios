import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';

part 'send_issue_response.g.dart';

@JsonSerializable(nullable: true)
class SendIssueResponse extends ResponseObject<String> {
  SendIssueResponse(
      {int code, String msg, String data, String msgToken})
      : super(code: code, msg: msg, msgToken: msgToken, data: data);

  factory SendIssueResponse.fromJson(Map<String, dynamic> json) =>
      _$SendIssueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendIssueResponseToJson(this);
}

@JsonSerializable(nullable: true)
class SendIssueDataResponse {
  String id;
  int status;

  SendIssueDataResponse({this.id, this.status});

  factory SendIssueDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SendIssueDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendIssueDataResponseToJson(this);
}
