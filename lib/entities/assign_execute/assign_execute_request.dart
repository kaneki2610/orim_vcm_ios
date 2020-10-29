import 'package:json_annotation/json_annotation.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/officer.dart';

part 'assign_execute_request.g.dart';

class AssignExecuteRequest<T extends Assignee> {
  String issueid;
  Assigner assigner;
  String comment;
  String commentSupport;
  List<T> assignee = [];
  List<SupportAssignee> supportassignee = [];

  AssignExecuteRequest.fromOfficer({
    String issueId,
    String departmentNameAssigner,
    String departmentIdAssigner,
    String nameAssigner,
    Map<String, dynamic> areaAssigner,
    String accountIdAssigner,
    String contentAssign,
    String supportContentAssign,
    List<OfficerModel> assignee,
    List<DepartmentModel> supporters,
  })  : assert(assignee != null),
        this.issueid = issueId,
        this.assigner = Assigner(
            departmentName: departmentNameAssigner,
            Id: accountIdAssigner,
            DepartmentId: departmentIdAssigner,
            Name: nameAssigner,
            Area: areaAssigner),
        this.comment = contentAssign,
        this.commentSupport = supportContentAssign {
    for (final temp in assignee) {
      if (this.assignee is List<AssigneeOfficer>) {
        (this.assignee as List<AssigneeOfficer>).add(AssigneeOfficer(
            Id: temp.id,
            Name: temp.fullname,
            departmentName: temp.departmentName));
      }
    }
    if (supporters != null) {
      for (final tempSupport in supporters) {
        this.supportassignee.add(SupportAssignee(
            Id: tempSupport.id,
            Area: tempSupport.area.toJson(),
            Name: tempSupport.name));
      }
    }
  }

  AssignExecuteRequest.fromDepartment(
      {String issueId,
      String departmentNameAssigner,
      String departmentIdAssigner,
      String nameAssigner,
      Map<String, dynamic> areaAssigner,
      String accountIdAssigner,
      String contentAssign,
      List<DepartmentModel> assignee})
      : assert(assignee != null),
        this.issueid = issueId,
        this.assigner = Assigner(
            departmentName: departmentNameAssigner,
            Id: accountIdAssigner,
            DepartmentId: departmentIdAssigner,
            Name: nameAssigner,
            Area: areaAssigner),
        this.comment = contentAssign {
    for (final temp in assignee) {
      if (this.assignee is List<AssigneeDepartment>) {
        (this.assignee as List<AssigneeDepartment>).add(AssigneeDepartment(
          Id: temp.id,
          Name: temp.name,
          Area: temp.area.toJson(),
        ));
      }
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "issueid": issueid,
      "assigner": assigner != null ? assigner.toJson() : null,
      "comment": comment,
      "commentSupport": commentSupport,
      "assignee": assignee,
      "supportassignee": supportassignee
    };
  }
}

@JsonSerializable(nullable: null)
class SupportAssignee {
  String Id;
  String ObjectType = 'Department';
  Map<String, dynamic> Area;
  String Name;

  SupportAssignee({this.Id, this.ObjectType, this.Area, this.Name});

  factory SupportAssignee.fromJson(Map<String, dynamic> json) =>
      _$SupportAssigneeFromJson(json);

  Map<String, dynamic> toJson() => _$SupportAssigneeToJson(this);
}

abstract class Assignee {
  String Id;
  String Name;
  String ObjectType;

  Assignee({this.Id, this.Name});
}

@JsonSerializable(nullable: null)
class AssigneeOfficer extends Assignee {
  String departmentName;

  AssigneeOfficer({String Id, String Name, this.departmentName})
      : super(Id: Id, Name: Name) {
    ObjectType = "Officer";
  }

  factory AssigneeOfficer.fromJson(Map<String, dynamic> json) =>
      _$AssigneeOfficerFromJson(json);

  Map<String, dynamic> toJson() => _$AssigneeOfficerToJson(this);
}

@JsonSerializable(nullable: null)
class AssigneeDepartment extends Assignee {
  Map<String, dynamic> Area;

  AssigneeDepartment({String Id, String Name, this.Area})
      : super(Id: Id, Name: Name) {
    ObjectType = "Department";
  }

  factory AssigneeDepartment.fromJson(Map<String, dynamic> json) =>
      _$AssigneeDepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssigneeDepartmentToJson(this);
}

@JsonSerializable(nullable: null)
class Assigner {
  String departmentName;
  String Name;
  Map<String, dynamic> Area;
  String Id;
  String DepartmentId;
  String ObjectType = 'Officer';

  Assigner(
      {this.departmentName, this.Name, this.Area, this.Id, this.DepartmentId});

  factory Assigner.fromJson(Map<String, dynamic> json) =>
      _$AssignerFromJson(json);

  Map<String, dynamic> toJson() => _$AssignerToJson(this);
}
