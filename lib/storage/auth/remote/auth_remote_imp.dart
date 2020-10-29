import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/logout/logout_request.dart';
import 'package:orim/entities/logout/logout_response.dart';
import 'package:orim/entities/signin/sign_in_request.dart';
import 'package:orim/entities/signin/sign_in_response.dart';
import 'package:orim/storage/auth/remote/auth_remote.dart';
import 'package:orim/utils/api_service.dart';

class AuthRemoteImp implements AuthRemote {
  ApiService apiService;
  final String _urlLogin = 'kong/api/permission/v1/account/login';
  final String _urlLogout = 'kong/api/permission/v1/account/logout';

  @override
  Future<ResponseObject<SignInModel>> login({SignInRequest request}) async {
    Response response;
    try {
      response = await apiService.post(_urlLogin, data: request.toJson());
      SignInResponse res = SignInResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }
      return res;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<LogoutResponse> logout({LogoutRequest request, String token}) async {
    Map<String, String> header = {"token": "$token"};
    try {
      final Response response = await apiService.post(_urlLogout,
          data: request.toJson(), headers: header);
    } catch (err) {
      return LogoutResponse(
        succeed: true,
        failed: false,
      );
    }
    return LogoutResponse(
      succeed: true,
      failed: false,
    );
  }
}
