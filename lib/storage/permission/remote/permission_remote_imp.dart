import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/permission/permission_request.dart';
import 'package:orim/entities/permission/permission_response.dart';
import 'package:orim/model/permission/permission.dart';
import 'package:orim/storage/permission/remote/permission_remote.dart';
import 'package:orim/utils/api_service.dart';

class PermissionRemoteImp implements PermissionRemote {
  ApiService apiService;
  final String _getPermission =
      'kong/api/permission/v1/permission/getlistmenubytoken';

  @override
  Future<ResponseListNew<PermissionModel>> getPermission(
      {String source, String token, String accountId}) async {
    final PermissionRequest request =
        PermissionRequest(token: token, accountId: accountId);
    if (source != null) {
      request.source = source;
    }
    final String subURL =
        '$_getPermission?source=${request.source}&token=${request.token}&accountId=${request.accountId}';
    Response response;
    try {
      response = await apiService.get(subURL);
      PermissionResponse permissionResponse =
          PermissionResponse.fromJson(json.decode(response.body));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        permissionResponse.code = 1;
      }
      return permissionResponse;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }
}
