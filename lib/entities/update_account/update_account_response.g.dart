// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAccountResponse _$UpdateAccountResponseFromJson(
    Map<String, dynamic> json) {
  return UpdateAccountResponse(code: json['code'] as int ?? 0, msg: json['msg'] as String ?? "", data: json);
}

Map<String, dynamic> _$UpdateAccountResponseToJson(
        UpdateAccountResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'msgToken': instance.msgToken,
      'data': instance.data
    };
