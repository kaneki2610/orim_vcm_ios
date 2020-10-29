import 'dart:convert';

import 'package:orim/entities/permission/permission_response.dart';
import 'package:orim/model/permission/permission.dart';
import 'package:orim/storage/permission/local/permission_local.dart';
import 'package:orim/utils/storage/storage.dart';

class PermissionLocalImp implements PermissionLocal {
  Storage storage;
  final String keyPermission = 'permission';

  @override
  Future<bool> savePermissionLocal({List<PermissionModel> model}) async {
    // TODO: implement savePermissionLocal
    try {
//      var json = model.map((e) => e.toJson()).toList();
      return await storage.writeList(keyPermission, model);
    } catch (err) {
      return false;
    }
  }

  @override
  Future<List<PermissionModel>> getPermissionLocal() async {
    // TODO: implement getPermissionLocal
    List<PermissionModel> list = [];
    try {
      List<dynamic> listDynamic = await storage.readList(keyPermission);
      if (listDynamic != null) {
        print(listDynamic.toString());
        list = listDynamic
            .map((e) => PermissionModel.fromJson(Menu.fromJson(e)))
            .toList();
      }
    } catch (err) {
      return [];
    }
    if (list != null) {
      return list;
    } else {
      return [];
    }
  }

  @override
  Future<bool> deletePermissionLocal() async {
    // TODO: implement deletePermissionLocal
    return await storage.delete(keyPermission);
  }
}
