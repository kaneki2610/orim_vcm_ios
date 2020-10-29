import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/assign_execute/assign_execute_request.dart';

part 'send_approved_request.g.dart';

@JsonSerializable(nullable: true)
class SendApprovedRequest {
  String issueid;
  Assigner assigner;
  String comment;

  SendApprovedRequest(
    {String issueId,
      String departmentNameAssigner,
      Map<String, dynamic> areaAssigner,
      String nameAssigner,
      String accountIdAssigner,
      String departmentIdAssigner,
      this.comment})
    : issueid = issueId,
      assigner = Assigner(
        departmentName: departmentNameAssigner,
        Name: nameAssigner,
        Area: areaAssigner,
        Id: accountIdAssigner,
        DepartmentId: departmentIdAssigner,
      );

  factory SendApprovedRequest.fromJson(Map<String, dynamic> json) =>
    _$SendApprovedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendApprovedRequestToJson(this);
}