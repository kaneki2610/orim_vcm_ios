import 'package:json_annotation/json_annotation.dart';

part 'history_issue_request.g.dart';

@JsonSerializable()
class HistoryIssueRequest {
  String listid;

  HistoryIssueRequest({List<String> listid}) {
    String temp = "";
    for (final id in listid) {
      if (temp != "") {
        temp+= ',' + '\'$id\'';
      } else {
        temp+='\'$id\'';
      }
    }
    this.listid = temp;
  }

  factory HistoryIssueRequest.fromJson(Map<String, dynamic> json) => _$HistoryIssueRequestFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryIssueRequestToJson(this);
}
