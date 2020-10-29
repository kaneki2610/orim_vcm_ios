//import 'package:permission/permission_request.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
/*  static Future<Map<PermissionGroup, PermissionStatus>> getPermissionsStatus(
      List<PermissionGroup> permissionNameList) async {
    Map<PermissionGroup, PermissionStatus> result = Map();
    for (final permission in permissionNameList) {
      result[permission] = await PermissionHandler().checkPermissionStatus(permission);
    }
    return result;
  }*/

  static Future<Map<Permission, PermissionStatus>> requestPermissions(
      List<Permission> permissionNameList) async {
    return await permissionNameList.request();
  }

/*  static Future<PermissionStatus> getPermissionStatus(
      PermissionGroup permissionName) async {
    PermissionStatus permissions =
        await PermissionHandler().checkPermissionStatus(permissionName);
    return permissions;
  }*/

 /* static Future<PermissionStatus> requestPermission(
      PermissionGroup permissionName) async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([permissionName]);
    return permissions[permissionName];
  }*/

  static Future<bool> checkPermissionIsNotShowAgain(
      Permission permission) async {
    bool value = false;
    PermissionStatus permissionStatus = await permission.status;
    if(permissionStatus == PermissionStatus.permanentlyDenied || permissionStatus == PermissionStatus.restricted) {
      value = true;
    } else {
      value = false;
    }
    return value;
  }

  static openSetting() async {
    //await PermissionHandler().openAppSettings();
  }
}