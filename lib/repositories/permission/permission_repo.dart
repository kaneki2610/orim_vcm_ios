import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/permission/permission.dart';

abstract class PermissionRepo {
  Future<ResponseListNew<PermissionModel>> getPermission(
      {String token, String accountId, String source});

  Future<List<PermissionModel>> getLocalPermission();

  Future<bool> savePermissionLocal(List<PermissionModel> model);

  Future<bool> deletePermissionLocal();
}
