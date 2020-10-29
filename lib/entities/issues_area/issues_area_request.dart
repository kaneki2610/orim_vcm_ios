import 'package:json_annotation/json_annotation.dart';

part 'issues_area_request.g.dart';

@JsonSerializable(nullable: true)
class IssuesAreaRequest {
  String q;
  String pagination;
  String listStatus;
  String areaCode;

  IssuesAreaRequest({this.q, this.pagination, this.listStatus, this.areaCode}) {
    assert(pagination is String);
    this.pagination = pagination;
  }

  factory IssuesAreaRequest.fromJson(Map<String, dynamic> json) => _$IssuesAreaRequestFromJson(json);
  Map<String, dynamic> toJson() => _$IssuesAreaRequestToJson(this);

  Map<String, String> getHeaders(String token) {
    return Map.from({
      'Content-Type': 'application/json',
      'token': token
    });
  }
}
