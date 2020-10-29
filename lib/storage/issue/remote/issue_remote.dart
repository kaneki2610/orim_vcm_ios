import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/model/process.dart';

abstract class IssueRemote {
  Future<ResponseObject<String>> sendIssue(
      {String token,
      String content,
      LatLng position,
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

  Future<ResponseListNew<IssueModel>> loadIssuesByIds(List<String> ids);

  Future<ResponseListNew<IssueModel>> getIssueOfArea(
      {String pagination, List<int> issueStatus, String areaCode});
  Future<ResponseObject<bool>> reportSpam(
      {String token,
      String issueid,
      String comment,
      String departmentName,
      String departmentId,
      String name,
      String accountId,
      int status});

  Future<ResponseListNew<IssueModel>> getIssuesWithStatus(
      {@required List<int> listAssignStatus,
      @required List<int> liststatus,
      List<int> listStatusReview,
      String token,
      String accountId,
      String departmentId,
      PaginationModel paginationModel});

  Future<ResponseObject<bool>> assignSpecialistExecute({
    String token,
    String issueId,
    String departmentNameAssigner,
    String departmentIdAssigner,
    String nameAssigner,
    Map<String, dynamic> areaAssigner,
    String accountIdAssigner,
    String contentAssign,
    String supportContentAssign,
    List<OfficerModel> assignee,
    List<DepartmentModel> supporters,
  });

  Future<ResponseObject<bool>> assignDepartmentExecute({
    String token,
    String issueId,
    String departmentNameAssigner,
    String departmentIdAssigner,
    String nameAssigner,
    Map<String, dynamic> areaAssigner,
    String accountIdAssigner,
    String contentAssign,
    List<DepartmentModel> assignee,
  });

  Future<ResponseListNew<IssueModel>> getIssueRootAdministration(
      {@required List<int> liststatus,
      String token,
      String areaCodeStatic,
      String kindOfTime,
      PaginationModel paginationModel});

  Future<ResponseObject<bool>> assignSupport({
    String token,
    String issueId,
    String departmentNameAssigner,
    String departmentIdAssigner,
    String nameAssigner,
    Map<String, dynamic> areaAssigner,
    String accountIdAssigner,
    String contentAssign,
    List<OfficerModel> assignee,
  });

  Future<ResponseListNew<IssueProcessModel>> getProcess({String token, String issueId});

  Future<ResponseObject<bool>> sendInfoProcess(
      {String token,
      String issueId,
      String comment,
      int categoryExeId,
      String departmentNameAssigner,
      String assignerName,
      String accountIdAssigner,
      String departmentIdAssigner,
      Map<String, dynamic> areaAssigner});

  Future<ResponseObject<bool>> sendInfoSupport({
    String token,
    String departmentNameAssigner,
    Map<String, dynamic> areaAssigner,
    String nameAssigner,
    String accountIdAssigner,
    String departmentIdAssigner,
    String issueId,
    String comment,
  });

  Future<ResponseObject<bool>> sendInfoApproved({
    String token,
    String departmentNameAssigner,
    Map<String, dynamic> areaAssigner,
    String nameAssigner,
    String accountIdAssigner,
    String departmentIdAssigner,
    String issueId,
    String comment,
  });
}
