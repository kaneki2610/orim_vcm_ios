import 'dart:async';

import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/permission/permission.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/permission/permission_repo.dart';

class PermissionViewModel extends BaseViewModel<List<PermissionModel>> {
  PermissionRepo permissionRepo;
  AuthRepo authRepo;

  Future<void> getPermission() async {
    AuthModel authModel = await authRepo.getAuth();
    ResponseListNew<PermissionModel> response;
    response = await permissionRepo
        .getPermission(token: authModel.token, accountId: authModel.accountId);
    if(response.isSuccess()) {
      data = response.datas;
      bool isSaved = await permissionRepo.savePermissionLocal(data);
      print("Is saved: " + isSaved.toString());
      print("Token user: " + authModel.token);
    }
    else {
    }
  }

  Future<void> getPermissionLocal() async {
    final List<PermissionModel> permissionLocal =
        await permissionRepo.getLocalPermission();
    if (permissionLocal != null) {
      data = permissionLocal;
    }
  }

  void resetMenu() {
    data = null;
  }

  // delete permission local when log out
  Future<bool> deletePermissionLocal() async {
    return await permissionRepo.deletePermissionLocal();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
