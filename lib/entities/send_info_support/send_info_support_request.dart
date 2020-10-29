import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/assign_execute/assign_execute_request.dart';

part 'send_info_support_request.g.dart';

@JsonSerializable(nullable: true)
class SendInfoSupportRequest {
  String issueid;
  Assigner assigner;
  String comment;

  SendInfoSupportRequest(
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

  factory SendInfoSupportRequest.fromJson(Map<String, dynamic> json) =>
      _$SendInfoSupportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendInfoSupportRequestToJson(this);
}
