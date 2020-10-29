import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';
import 'package:orim/entities/object/issue/issue.dart';
import 'package:orim/model/issue/issue.dart';

part 'history_issue_response.g.dart';

@JsonSerializable(nullable: true)
class HistoryIssueResponse extends ResponseListNew<IssueModel> {
  HistoryIssueResponse(
      {int code, String msg, List<Issue> data, String msgToken})
      : super(code: code, msg: msg, msgToken: msgToken){
      this.datas = data
        .map((historyIssue) => IssueModel.from(historyIssue))
        .toList();
  }

  factory HistoryIssueResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryIssueResponseFromJson(json);

//  Map<String, dynamic> toJson() => _$HistoryIssueResponseToJson(this);
}
