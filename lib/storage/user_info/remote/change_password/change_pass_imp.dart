import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/change_password/change_pass_model.dart';
import 'package:orim/entities/change_password/change_pass_request.dart';
import 'package:orim/entities/change_password/change_pass_response.dart';
import 'package:orim/storage/user_info/remote/change_password/change_pass_remote.dart';
import 'package:orim/utils/api_service.dart';

class ChangePassRemoteImp implements ChangePasswordRemote {
  ApiService apiService;
  final String _urlChangePassword =
      'kong/api/permission/v1/user/updatepassword';

  @override
  Future<ResponseObject<ChangePassModel>> changePassword(
      {String password, String token}) async {
    final ChangePassRequest changePassRequest =
        ChangePassRequest(password: password);
    Map<String, String> header = {"token": "$token"};
    Response response;
    try {
      response = await apiService.post(_urlChangePassword,
          headers: header, data: changePassRequest.toJson());
      ChangePassResponse res =
          ChangePassResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }
      return res;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }
}
