import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';
import 'package:orim/entities/object/issue/issue.dart';
import 'package:orim/model/issue/issue.dart';

part 'issue_need_assign_response.g.dart';

@JsonSerializable(nullable: true)
class IssueNeedAssignResponse extends ResponseListNew<IssueModel> {
  IssueNeedAssignResponse({int code, String msg, dynamic data, String msgToken})
      : super(code: code, msg: msg, msgToken: msgToken) {
    if (data is List) {
      this.datas = (data as List)
          .map((issue) => IssueModel.from(Issue.fromJson(issue)))
          .toList();
    } else if (data is Map<String, dynamic>) {
      Map<String, dynamic> map = data;
      this.datas = (map["data"] as List)
          .map((issue) => IssueModel.from(Issue.fromJson(issue)))
          .toList();
      this.total = map["total"];
    }
  }

  factory IssueNeedAssignResponse.fromJson(Map<String, dynamic> json) =>
      _$IssueNeedAssignResponseFromJson(json);

//  Map<String, dynamic> toJson() => _$IssueNeedAssignResponseToJson(this);
}
