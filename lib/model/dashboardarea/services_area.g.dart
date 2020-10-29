part of 'services_area.dart';
ServicesAreaModel _$ServicesAreaModelFromJson(Map<String, dynamic> json) {
  return ServicesAreaModel(
    name: json['name'] as String,
    code: json['code'] as String,
    percent: json['percent'] as int,
    number: json['number'] as int,
  );
}

Map<String, dynamic> _$ServicesAreaModelToJson(ServicesAreaModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'percent': instance.percent,
      'number': instance.number,
    };
