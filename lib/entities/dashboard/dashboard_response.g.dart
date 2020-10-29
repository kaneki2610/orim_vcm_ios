part of 'dashboard_response.dart';

DashBoardResponse _$DashBoardResponseFromJson(Map<String, dynamic> json) {
  return DashBoardResponse(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: DashBoardObjectModel.fromJson(json['data']),
    msgToken: json['msgToken'] as  String,
  );
}

Map<String, dynamic> _$DashBoardResponseToJson (DashBoardResponse instance) =>
    <String, dynamic> {
      'code': instance.code,
      'msg' : instance.msg,
      'data': instance.data,
      'msgToken': instance.msgToken,
    };