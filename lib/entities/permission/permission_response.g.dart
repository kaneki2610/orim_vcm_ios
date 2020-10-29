// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionResponse _$PermissionResponseFromJson(Map<String, dynamic> json) {
  return PermissionResponse(
      /* menuitems: (json['menuitems'] as List)
        ?.map(
            (e) => e == null ? null : Menu.fromJson(e as Map<String, dynamic>))
        ?.toList(),*/
      dataRes: json['menuitems'])
    ..errors = (json['errors'] as List)?.map((e) => e as String)?.toList()
    ..succeed = json['succeed'] as bool
    ..failed = json['failed'] as bool
    ..data = json['data'];
}

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    code: json['code'] as String,
    name: json['name'] as String,
    path: json['path'] as String,
    iconPath: json['iconPath'] as String,
    description: json['description'] as String,
    parent: json['parent'] == null
        ? null
        : Parent.fromJson(json['parent'] as Map<String, dynamic>),
    order: json['order'] as int,
    status: json['status'] as int,
    partition: json['partition'] as String,
    id: json['id'] as String,
    createdOn: json['createdOn'] as String,
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'path': instance.path,
      'iconPath': instance.iconPath,
      'description': instance.description,
      'parent': instance.parent,
      'order': instance.order,
      'status': instance.status,
      'partition': instance.partition,
      'id': instance.id,
      'createdOn': instance.createdOn,
    };

Parent _$ParentFromJson(Map<String, dynamic> json) {
  return Parent(
    partition: json['partition'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'partition': instance.partition,
      'id': instance.id,
    };
