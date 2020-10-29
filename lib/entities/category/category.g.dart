// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) {
  return CategoryData(
    areaCode: json['areaCode'] as String,
    code: json['code'] as String,
    desc: json['desc'] as String,
    flag: json['flag'] as int,
    icon: json['icon'] as String,
    id: json['id'] as String,
    name: json['name'] as String,
    orders: json['orders'] as int,
    parentCode: json['parentCode'] as String,
    status: json['status'] as int,
    type: json['type'] as String,
    subCategories: json['subCategories'],
  );
}

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'areaCode': instance.areaCode,
      'code': instance.code,
      'desc': instance.desc,
      'flag': instance.flag,
      'icon': instance.icon,
      'id': instance.id,
      'name': instance.name,
      'orders': instance.orders,
      'parentCode': instance.parentCode,
      'status': instance.status,
      'type': instance.type,
      'subCategories': instance.subCategories,
    };
