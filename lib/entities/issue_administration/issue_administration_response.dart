import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';
import 'package:orim/entities/object/issue/issue.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/marker.dart';
import 'package:orim/storage/issue/remote/issue_remote.dart';

part 'issue_administration_response.g.dart';

@JsonSerializable(nullable: true)
class IssueAdministrationResponse extends ResponseListNew<IssueModel> {
  IssueAdministrationResponse(
      {int code, String msg, dynamic data, String msgToken})
      : super(code: code, msg: msg, msgToken: msgToken) {
    if (data != null) {
      if (data is List) {
        this.datas = (data)
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
  }

  factory IssueAdministrationResponse.fromJson(Map<String, dynamic> json) =>
      _$IssueAdministrationResponseFromJson(json);

//  Map<String, dynamic> toJson() => _$IssueAdministrationResponseToJson(this);
}
