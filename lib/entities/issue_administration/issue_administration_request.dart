import 'package:json_annotation/json_annotation.dart';

part 'issue_administration_request.g.dart';

@JsonSerializable(nullable: true)
class IssueAdministrationRequest {
  String areaCodeStatic;
  List<int> liststatus;
  String kindOfTime;
  int take = 10;
  int skip = 1;

  IssueAdministrationRequest(
      {this.liststatus, this.areaCodeStatic, this.kindOfTime, this.take, this.skip});

  factory IssueAdministrationRequest.fromJson(Map<String, dynamic> json) =>
      _$IssueAdministrationRequestFromJson(json);

  Map<String, dynamic> toJson() {
    if (take == null || skip == null || kindOfTime == null) {
      var map = <String, dynamic>{
        'liststatus': liststatus,
        'areaCodeStatic': areaCodeStatic,
        'liststatus': liststatus,
      };

      if(take != null && skip != null){
        map["take"] = take;
        map["skip"] = skip;
      }

      if(this.kindOfTime != null){
        map["kindOfTime"] =  kindOfTime;
      }

      return map;
    }
    return _$IssueAdministrationRequestToJson(this);
  }
}
