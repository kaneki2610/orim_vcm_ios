part of 'permission.dart';

PermissionModel _$PermissionModelFromJson(Menu menu) {
  return PermissionModel(
    code: menu.code,
    name: menu.name,
    id: menu.id
  );
}

Map<String, dynamic> _$PermissionModelToJson(PermissionModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'id': instance.id,
    };