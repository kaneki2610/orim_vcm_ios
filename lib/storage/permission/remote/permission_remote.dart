import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/permission/permission.dart';

abstract class PermissionRemote {
  Future<ResponseListNew<PermissionModel>> getPermission({ String source, String token, String accountId });
}