// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'officer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficerEntity _$OfficerEntityFromJson(Map<String, dynamic> json) {
  return OfficerEntity(
    json['fullname'] as String,
    (json['departments'] as List)
        ?.map((e) =>
            e == null ? null : Department.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['id'] as String,
  );
}

Map<String, dynamic> _$OfficerEntityToJson(OfficerEntity instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'departments': instance.departments,
      'id': instance.id,
    };
