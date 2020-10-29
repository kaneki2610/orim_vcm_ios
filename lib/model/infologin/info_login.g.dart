// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoLogin _$InfoLoginFromJson(Map<String, dynamic> json) {
  return InfoLogin(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$InfoLoginToJson(InfoLogin instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
