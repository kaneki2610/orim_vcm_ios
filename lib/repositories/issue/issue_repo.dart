import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/model/issue/issue.dart';

abstract class IssueRepo {
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
      CurrentWard currentWard});

  Future<ResponseObject<bool>> uploadFile(String token, List<File> files, String idIssue,
      Function(int, int) listener);

  Future<bool> saveListIssueByIds(List<String> issueIds);

  Future<List<String>> loadIssueFromLocal();

  Future<ResponseListNew<IssueModel>> loadIssuesByIds(List<String> ids);

  Future<ResponseObject<bool>> reportSpam(
      {String token,
      String issueid,
      String departmentName,
      String departmentId,
      String name,
      String accountId});
}
