import 'package:json_annotation/json_annotation.dart';

part 'issue_need_assign_request.g.dart';

@JsonSerializable(nullable: true)
class IssueNeedAssignRequest {
  List<int> listAssignStatus;
  List<String> assignee;
  List<int> liststatus;
  List<int> listStatusReview;

  int take = 10;
  int skip = 1;

  IssueNeedAssignRequest(
      {this.listAssignStatus,
      this.assignee,
      this.liststatus,
        this.listStatusReview,
      this.take,
      this.skip});

  factory IssueNeedAssignRequest.fromJson(Map<String, dynamic> json) =>
      _$IssueNeedAssignRequestFromJson(json);

  Map<String, dynamic> toJson() {
    
    if (take != null && skip != null && this.listStatusReview != null && this.liststatus != null) {
      return _$IssueNeedAssignRequestToJson(this);
    }
    var json = <String, dynamic>{
      'listAssignStatus': listAssignStatus,
      'assignee': assignee,
    };
    if (take != null && skip != null) {
      json['take'] = take;
      json['skip'] = skip;
    }
    if (this.listStatusReview != null) {
      json['listStatusReview'] = listStatusReview;
    }
    if (this.liststatus != null) {
     json['liststatus'] = liststatus;
    }
    return json;
  }
}
