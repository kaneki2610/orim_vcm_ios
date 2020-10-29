
import 'package:orim/model/permission/permission.dart';

abstract class PermissionLocal {
  Future<bool> savePermissionLocal({List<PermissionModel> model});
  Future<List<PermissionModel>> getPermissionLocal();
  Future<bool> deletePermissionLocal();
}