// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Marker _$MarkerFromJson(Map<String, dynamic> json) {
  return Marker()
    ..areadetail = json['areadetail'] as String
    ..contact =  Contact.fromJson(json['contact'] as Map<String, dynamic>)
    ..content = json['content'] as String
    ..createdOn = json['createdOn'] as String
    ..location = json['location'] as String
    ..status = json['status'] as num
    ..updatedOn = json['updatedOn'] as String;

}

Map<String, dynamic> _$MarkerToJson(Marker instance) => <String, dynamic>{
      'areadetail': instance.areadetail,
      'contact': instance.contact.toJson(),
      'content': instance.content,
      'createdOn': instance.createdOn,
      'location': instance.location,
      'status': instance.status,
      'updatedOn': instance.updatedOn
    };
