import 'package:json_annotation/json_annotation.dart';

part 'report_spam_request.g.dart';

@JsonSerializable(nullable: true)
class ReportSpamRequest {
  String issueid;
  Assigner assigner;
  String comment;
  int status;

  ReportSpamRequest(
      {this.issueid,
      String departmentName,
      String fullName,
      String accountId,
      String departmentId,
      this.comment,
      this.status})
      : assigner = Assigner(
            departmentName: departmentName,
            Name: fullName,
            Id: accountId,
            DepartmentId: departmentId);

  factory ReportSpamRequest.fromJson(Map<String, dynamic> json) =>
      _$ReportSpamRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReportSpamRequestToJson(this);
}

@JsonSerializable(nullable: true)
class Assigner {
  String departmentName;
  String Name;
  String Id;
  String ObjectType;
  String DepartmentId;

  Assigner(
      {this.departmentName,
      this.Name,
      this.Id,
      this.ObjectType = 'Officer',
      this.DepartmentId});

  factory Assigner.fromJson(Map<String, dynamic> json) =>
      _$AssignerFromJson(json);

  Map<String, dynamic> toJson() => _$AssignerToJson(this);
}
