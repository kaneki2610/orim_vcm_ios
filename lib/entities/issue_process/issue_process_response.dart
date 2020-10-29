import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/response.dart';
import 'package:orim/entities/object/area/area.dart';
import 'package:orim/model/process.dart';

part 'issue_process_response.g.dart';

@JsonSerializable(nullable: true)
class IssueProcessResponse extends ResponseListNew<IssueProcessModel> {
  IssueProcessResponse(
      {int code, String msg, List<Process> data, String msgToken})
      : super(code: code, msg: msg, msgToken: msgToken) {
    if (data == null) {
      data = [];
    }
    List<IssueProcessModel> issueProcessModels;
    if (data is List) {
      issueProcessModels = data.map((e) => IssueProcessModel.fromProcessEntity(e)).toList();
    }
    print("dsdas " + data.length.toString());
    this.datas = issueProcessModels ?? [];
  }

  factory IssueProcessResponse.fromJson(Map<String, dynamic> json) =>
      _$IssueProcessResponseFromJson(json);

//  Map<String, dynamic> toJson() => _$IssueProcessResponseToJson(this);
}

@JsonSerializable(nullable: true)
class Process {
  Assigner assigner;
  List<Assigner> assignees;
  List<dynamic> supports;
  int status;
  String statusName;
  String createDate;
  String resolveDate;
  String updateBy;
  String comment;
  int direction;
  int isMainAssign;
  int assignStatus;
  String assignStatusName;
  String deadline;

  Process(
      {this.assigner,
      this.assignees,
      this.supports,
      this.status,
      this.statusName,
      this.createDate,
      this.resolveDate,
      this.updateBy,
      this.comment,
      this.direction,
      this.isMainAssign,
      this.assignStatus,
      this.assignStatusName,
      this.deadline});

  factory Process.fromJson(Map<String, dynamic> json) =>
      _$ProcessFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessToJson(this);
}

@JsonSerializable(nullable: true)
class Assigner {
  String id;
  String name;
  String code;
  String phoneNumber;
  String email;
  dynamic source;
  String departmentId;
  String parentId;
  String departmentName;
  Area area;
  String objectType;

  Assigner(
      {this.id,
      this.name,
      this.code,
      this.phoneNumber,
      this.email,
      this.source,
      this.departmentId,
      this.parentId,
      this.departmentName,
      this.area,
      this.objectType});

  factory Assigner.fromJson(Map<String, dynamic> json) =>
      _$AssignerFromJson(json);

  Map<String, dynamic> toJson() => _$AssignerToJson(this);
}
