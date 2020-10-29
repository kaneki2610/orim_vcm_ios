import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/permission/permission.dart';
import 'package:orim/repositories/permission/permission_repo.dart';
import 'package:orim/storage/permission/local/permission_local.dart';
import 'package:orim/storage/permission/remote/permission_remote.dart';

class PermissionImp implements PermissionRepo {
  PermissionRemote permissionRemote;
  PermissionLocal permissionLocal;

  @override
  Future<ResponseListNew<PermissionModel>> getPermission(
      {String token, String accountId, String source}) async {
    ResponseListNew<PermissionModel> response;
    response = await permissionRemote.getPermission(
        source: source, token: token, accountId: accountId);
    return response;
  }

  @override
  Future<List<PermissionModel>> getLocalPermission() async {
    // TODO: implement getLocalPermission
    return await permissionLocal.getPermissionLocal();
  }

  @override
  Future<bool> deletePermissionLocal() async {
    // TODO: implement deletePermissionLocal
    return await permissionLocal.deletePermissionLocal();
  }

  @override
  Future<bool> savePermissionLocal(List<PermissionModel> model) async {
    // TODO: implement savePermissionLocal
    return await permissionLocal.savePermissionLocal(model: model);
  }
}
