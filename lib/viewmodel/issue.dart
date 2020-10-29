import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/issue/issue_repo.dart';
import 'package:orim/services/notification.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';
import 'package:orim/utils/time_util.dart';

class IssueViewModel {
  IssueRepo issueRepo;
  AuthRepo authRepo;
  List<String> _issueIds; // init when getIssueIds
  List<IssueModel> _issues;
  NotificationService notificationService = NotificationService.getInstance();

  Future<List<String>> getIssueIds() async {
    if (_issueIds == null) {
      await _loadIssueFromLocal();
    }
    return _issueIds;
  }

  Future<ResponseObject<String>> sendIssue(
      {String content,
      LatLng position,
      String areaDetail,
      CategoryData categoryData,
      String name,
      String phone,
      CurrentProvince currentProvince,
      CurrentDistrict currentDistrict,
      CurrentWard currentWard}) async {
    ResponseObject<String> responseObject = await issueRepo.sendIssue(
      token: await notificationService.token,
      content: content,
      location: position,
      areaDetail: areaDetail,
      categoryCode: categoryData.code,
      categoryName: categoryData.name,
      subcategoryCode: categoryData.subCategories[0].code,
      subcategoryName: categoryData.subCategories[0].name,
      name: name,
      phone: phone,
      currentProvince: currentProvince,
      currentDistrict: currentDistrict,
      currentWard: currentWard,
    );
    return responseObject;
  }

  Future<bool> addIssueToLocal(String id) async {
    bool res = false;
    if (_issueIds == null) {
      await _loadIssueFromLocal();
    }
    _issueIds.add(id);
    try {
      res = await issueRepo.saveListIssueByIds(_issueIds);
    } catch (err) {
      print(err);
    }
    if (res) {
      return true;
    } else {
      _issueIds.remove(id);
      return false;
    }
  }

  Future<bool> removeIssueToLocal(String id) async {
    bool res = false;
    if (_issueIds == null) {
      await _loadIssueFromLocal();
    }
    _issueIds.remove(id);
    try {
      res = await issueRepo.saveListIssueByIds(_issueIds);
    } catch (err) {
      print(err);
    }
    if (res) {
      return true;
    } else {
      _issueIds.add(id);
      return false;
    }
  }

  Future<ResponseObject<bool>> uploadAttachments(List<Attachment> attachments, String idIssue,
      Function(int, int) listener) async {
    AuthModel auth;
    try {
      auth = await authRepo.getAuth();
    } catch (err) {
      print(err);
    }
    print('upload');
    List<File> files =
        attachments.map((attachment) => attachment.file).toList();
    final res =
        await issueRepo.uploadFile(auth?.token, files, idIssue, listener);
    return res;
  }

  Future<void> _loadIssueFromLocal() async {
    try {
      _issueIds = await issueRepo.loadIssueFromLocal();
//      print(_issueIds);
    } catch (err) {
      _issueIds = [];
      print('_loadIssueFromLocal ${err}');
    }
  }

  Future<ResponseListNew<IssueModel>> getIssueByIds(List<String> ids) async {
    ResponseListNew<IssueModel> res = await issueRepo.loadIssuesByIds(ids);
    _issues = res.datas ?? [];
    return res;
  }

  Future<List<IssueModel>> searchByDate(
      List<IssueModel> models, String dateStart) async {
    var endDate = DateTime.now();
    var startDate = DateTime.parse(
        TimeUtil.convertDdmmyyyToYyyyMMdd(dateStart) + ' 00:00:00.000');
    final List<IssueModel> searchModels = models.where((model) {
      DateTime currentDate = DateTime.parse(
          TimeUtil.convertDdmmyyyToYyyyMMdd(model.dateText) + ' 00:00:01.000');
      return currentDate.isBefore(endDate) && currentDate.isAfter(startDate);
    }).toList();
    return searchModels;
  }
}
