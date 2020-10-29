import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/assign_execute/assign_execute_request.dart';

part 'send_execute_request.g.dart';

@JsonSerializable(nullable: true)
class SendExecuteRequest {
  String issueid;
  int status;
  Assigner assigner;
  String comment;

  SendExecuteRequest({
    String issueId,
    int categoryExecute,
    String comment,
    String departmentNameAssigner,
    String departmentIdAssigner,
    String nameAssigner,
    Map<String, dynamic> areaAssigner,
    String accountIdAssigner,
  })  : issueid = issueId,
        status = categoryExecute,
        comment = comment,
        assigner = Assigner(
            departmentName: departmentNameAssigner,
            Name: nameAssigner,
            Area: areaAssigner,
            Id: accountIdAssigner,
            DepartmentId: departmentIdAssigner);

  factory SendExecuteRequest.fromJson(Map<String, dynamic> json) => _$SendExecuteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendExecuteRequestToJson(this);
}
