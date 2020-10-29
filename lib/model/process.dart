import 'package:orim/entities/issue_process/issue_process_response.dart';
import 'package:orim/utils/time_util.dart';

class IssueProcessModel {
  String nameAssigner;
  String departmentName;
  String content;
  String time;
  List<Assigner> assignees;
  int status;

  IssueProcessModel(
      {String nameAssigner,
      String departmentName,
      String content,
      String time,
      List<Assigner> assignees,
      int status}) {
    this.nameAssigner = nameAssigner ?? "";
    this.departmentName = departmentName ?? "";
    this.content = content ?? "";
    this.time = time ?? "";
    this.assignees = assignees;
    this.status = status ?? -1;
  }

  factory IssueProcessModel.fromProcessEntity(Process process) {
    return IssueProcessModel(
      nameAssigner: process.assigner?.name,
      departmentName: process.assigner?.departmentName,
      content: process.comment ?? "",
      time: process.createDate,
      assignees: process.assignees,
      status: process.status,
    );
  }
}
