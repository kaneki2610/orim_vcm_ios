// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_process_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueProcessResponse _$IssueProcessResponseFromJson(Map<String, dynamic> json) {
  return IssueProcessResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Process.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    msgToken: json['msgToken'] as String,
  );
}

//Map<String, dynamic> _$IssueProcessResponseToJson(
//        IssueProcessResponse instance) =>
//    <String, dynamic>{
//      'code': instance.code,
//      'msg': instance.msg,
//      'data': instance.data,
//      'msgToken': instance.msgToken,
//    };

Process _$ProcessFromJson(Map<String, dynamic> json) {
  return Process(
    assigner: json['assigner'] == null
        ? null
        : Assigner.fromJson(json['assigner'] as Map<String, dynamic>),
    assignees: (json['assignees'] as List)
        ?.map((e) =>
            e == null ? null : Assigner.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    supports: json['supports'] as List,
    status: json['status'] as int,
    statusName: json['statusName'] as String,
    createDate: json['createDate'] as String,
    resolveDate: json['resolveDate'] as String,
    updateBy: json['updateBy'] as String,
    comment: json['comment'] as String,
    direction: json['direction'] as int,
    isMainAssign: json['isMainAssign'] as int,
    assignStatus: json['assignStatus'] as int,
    assignStatusName: json['assignStatusName'] as String,
    deadline: json['deadline'] as String,
  );
}

Map<String, dynamic> _$ProcessToJson(Process instance) => <String, dynamic>{
      'assigner': instance.assigner,
      'assignees': instance.assignees,
      'supports': instance.supports,
      'status': instance.status,
      'statusName': instance.statusName,
      'createDate': instance.createDate,
      'resolveDate': instance.resolveDate,
      'updateBy': instance.updateBy,
      'comment': instance.comment,
      'direction': instance.direction,
      'isMainAssign': instance.isMainAssign,
      'assignStatus': instance.assignStatus,
      'assignStatusName': instance.assignStatusName,
      'deadline': instance.deadline,
    };

Assigner _$AssignerFromJson(Map<String, dynamic> json) {
  return Assigner(
    id: json['id'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    phoneNumber: json['phoneNumber'] as String,
    email: json['email'] as String,
    source: json['source'],
    departmentId: json['departmentId'] as String,
    parentId: json['parentId'] as String,
    departmentName: json['departmentName'] as String,
    area: json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>),
    objectType: json['objectType'] as String,
  );
}

Map<String, dynamic> _$AssignerToJson(Assigner instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'source': instance.source,
      'departmentId': instance.departmentId,
      'parentId': instance.parentId,
      'departmentName': instance.departmentName,
      'area': instance.area,
      'objectType': instance.objectType,
    };
