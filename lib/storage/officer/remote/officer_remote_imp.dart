import 'dart:convert';
import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/get_officer/get_officer_request.dart';
import 'package:orim/entities/get_officer/officer_response.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/storage/officer/remote/officer_remote.dart';
import 'package:orim/utils/api_service.dart';

class OfficerRemoteImp implements OfficerRemote {
  final String _urlGetOfficer =
      'kong/api/permission/v1/account/getuserbydepartmentid';
  ApiService apiService;

  @override
  Future<ResponseListNew<OfficerModel>> getOfficers(
      {String departmentId}) async {
    GetOfficerRequest request = GetOfficerRequest(departmentId: departmentId);
    Response response;
    try {
      response = await apiService
          .get('$_urlGetOfficer?departmentId=${request.departmentId}');
      OfficerResponse res =
          OfficerResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }
      return res;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }
}
