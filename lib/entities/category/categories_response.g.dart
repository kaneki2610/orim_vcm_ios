// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) {
  return CategoriesResponse(
    msg: json['msg'] as String,
    error: json['error'] as int,
    list: (json['list'] as List)
        ?.map((e) =>
            e == null ? null : CategoryData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'error': instance.error,
      'list': instance.list,
    };
