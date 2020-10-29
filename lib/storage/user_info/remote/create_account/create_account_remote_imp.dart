import 'dart:convert';
import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/create_account/create_account_model.dart';
import 'package:orim/entities/create_account/create_account_request.dart';
import 'package:orim/entities/create_account/create_account_response.dart';
import 'package:orim/storage/user_info/remote/create_account/create_account_remote.dart';
import 'package:orim/utils/api_service.dart';

class CreateAccountRemoteImp implements CreateAccountRemote {
  ApiService apiService;
  final String _urlCreateAccount = 'kong/api/permission/v1/user/create';

  @override
  Future<ResponseObject<CreateAccountModel>> createAccount({String phone, String name, String organizationId}) async {
    CreateAccountRequest createAccountRequest =
        CreateAccountRequest(phoneNumber: phone, source: "mobile", fullname: name, organizationId: organizationId);
    Response response;
    try {
      response = await apiService.post(_urlCreateAccount,
          data: createAccountRequest.toJson());
    } catch(err) {
      return ResponseObject.initDefault();
    }
    print(json.decode(response.body).toString());
    CreateAccountResponse res = CreateAccountResponse.fromJson(json.decode(response.body));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      res.code = 1;
    }
    return res;
  }
}
