import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/object/issue/issue.dart';
import 'package:orim/model/issue/issue.dart';

part 'issues_area_reponse.g.dart';

@JsonSerializable(nullable: true)
class IssuesAreaResponse extends ResponseListNew<IssueModel> {
  int total;

  IssuesAreaResponse({int code, dynamic json, total}) {
    this.code = 1;
    this.total = total is String ? int.parse(total) : total;
    this.datas = [];
    if (json != null) {
      if (json is List) {
        List<Map<String, dynamic>> listMap = List.from(json);
        this.datas = listMap
            .map((item) => IssueModel.from(Issue.fromJson(item)))
            .toList();
      }
    }
  }

  factory IssuesAreaResponse.fromJson(Map<String, dynamic> json) =>
      _$IssuesAreaResponseFromJson(json);

//  Map<String, dynamic> toJson() => _$IssuesAreaResponseToJson(this);
}
