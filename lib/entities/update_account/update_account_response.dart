
import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:orim/base/base_reponse.dart';

part 'update_account_response.g.dart';

@JsonSerializable()
class UpdateAccountResponse extends ResponseObject<bool> {
  UpdateAccountResponse({int code, String msg, Map<String, dynamic> data}) : super(code: code, msg: msg) {
    Map<String, dynamic> json = data;
    int status = 1;
    if(json.containsKey("status")){
      status = json['status'] as int ?? 1;
    }
    this.data = (status == 0);
    this.code = this.data == true ? 1 : 0;
  }

  factory UpdateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateAccountResponseFromJson(json);
}