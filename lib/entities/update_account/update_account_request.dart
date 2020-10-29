import 'package:json_annotation/json_annotation.dart';
import 'package:orim/utils/encrypt_utils.dart';

part 'update_account_request.g.dart';

@JsonSerializable()
class UpdateAccountRequest {
  String id;
  String oldpassword;
  String fullname;
  UpdateAccountRequest(this.id, this.oldpassword, this.fullname){
   this.oldpassword = EncryptUtils.encryptPassword(this.oldpassword);
  }

  Map<String, dynamic> toJson() => _$UpdateAccountRequestToJson(this);
}