import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/repositories/issue/issue_repo.dart';
import 'package:orim/storage/issue/local/issue_local.dart';
import 'package:orim/storage/issue/remote/issue_remote.dart';

class IssueImp implements IssueRepo {
  IssueRemote issueRemote;
  IssueLocal issueLocal;

  @override
  Future<ResponseObject<String>> sendIssue(
      {String token,
      String content,
      LatLng location,
      String areaDetail,
      String categoryCode,
      String categoryName,
      String subcategoryCode,
      String subcategoryName,
      String name,
      String phone,
      CurrentProvince currentProvince,
      CurrentDistrict currentDistrict,
      CurrentWard currentWard}) async {
    return await issueRemote.sendIssue(
      token: token,
      content: content,
      position: location,
      areaDetail: areaDetail,
      categoryCode: categoryCode,
      categoryName: categoryName,
      subcategoryCode: subcategoryCode,
      subcategoryName: subcategoryName,
      name: name,
      phone: phone,
      currentProvince: currentProvince,
      currentDistrict: currentDistrict,
      currentWard: currentWard,
    );
  }

  @override
  Future<bool> saveListIssueByIds(List<String> issueIds) async {
    return await issueLocal.saveListIssueByIds(issueIds);
  }

  @override
  Future<List<String>> loadIssueFromLocal() async {
    return await issueLocal.loadIssueFromLocal();
  }

  @override
  Future<ResponseObject<bool>> uploadFile(String token, List<File> files, String idIssue,
      Function(int, int) listener) async {
    return await issueRemote.uploadFile(token, files, idIssue, listener);
  }

  @override
  Future<ResponseListNew<IssueModel>> loadIssuesByIds(List<String> ids) async {
    return await issueRemote.loadIssuesByIds(ids);
  }

  @override
  Future<ResponseObject<bool>> reportSpam(
      {String token,
      String issueid,
      String departmentName,
      String departmentId,
      String name,
      String accountId}) async {
    return await issueRemote.reportSpam(
        token: token,
        issueid: issueid,
        comment: 'Tin báo không đúng sự thật',
        departmentName: departmentName,
        departmentId: departmentId,
        name: name,
        accountId: accountId,
        status: IssueStatusEnum.RecycleIssue);
  }
}
