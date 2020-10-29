import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/create_account/create_account_model.dart';
import 'package:orim/entities/create_account/create_account_response.dart';
import 'package:orim/entities/organization/organization_request.dart';
import 'package:orim/entities/organization/organization_response.dart';
import 'package:orim/entities/profile_phone/profile_phone_request.dart';
import 'package:orim/entities/update_account/update_account_request.dart';
import 'package:orim/entities/update_account/update_account_response.dart';
import 'package:orim/model/organization_permission/organization_permisstion.dart';
import 'package:orim/storage/user_info/remote/user_remote.dart';
import 'package:orim/utils/api_service.dart';

class UserRemoteImp implements UserRemote {
  ApiService apiService;
  final String _urlCreateOrganization =
      'kong/api/permission/v1/organization/bycode';
  final String _urlUpdateAccount = 'kong/api/permission/v1/user/update';
  final String _urlProfile = 'kong/api/permission/v1/user/getbyobject';

  @override
  Future<ResponseObject<OrganizationModel>> createOrganization(
      {String areaCode}) async {
    OrganizationRequest organizationRequest = OrganizationRequest(areaCode);
    Map<String, String> headers = Map.from({"token": null});
    print(organizationRequest.getUrl());
    Response response;
    try {
      response = await apiService.get(
          _urlCreateOrganization + "?" + organizationRequest.getUrl(),
          headers: headers);
      print(json.decode(response.body).toString());
      OrganizationResponse res =
          OrganizationResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }

      return res;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseObject<bool>> updateAccount(
      {String idUser, String fullname, String password}) async {
    UpdateAccountRequest request =
        UpdateAccountRequest(idUser, password, fullname);
    Map<String, String> headers = Map.from({"token": null});
    Response response;
    try {
      response = await apiService.post(_urlUpdateAccount,
          data: request.toJson(), headers: headers);
      print(json.decode(response.body).toString());
      UpdateAccountResponse res =
          UpdateAccountResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }

      return res;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseObject<CreateAccountModel>> getInfoResident(
      {String phone}) async {
    ProfilePhoneRequest profilePhoneRequest = ProfilePhoneRequest(phone);
    Response response;
    try {
      response = await apiService.get(
        _urlProfile + "?" + profilePhoneRequest.getUrl(),
      );
      print(json.decode(response.body).toString());
      CreateAccountResponse res =
          CreateAccountResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }
      return res;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }
}
