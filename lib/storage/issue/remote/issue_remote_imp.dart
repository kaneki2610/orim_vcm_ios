import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GOOGLEMAP;
import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/config/cert.dart';
import 'package:orim/config/enum_packages/enum_filter_issue.dart';
import 'package:orim/entities/assign_execute/assign_execute_request.dart';
import 'package:orim/entities/assign_execute/assign_execute_response.dart';
import 'package:orim/entities/history_issue/history_issue_request.dart';
import 'package:orim/entities/history_issue/history_issue_response.dart';
import 'package:orim/entities/issue_administration/issue_administration_request.dart';
import 'package:orim/entities/issue_administration/issue_administration_response.dart';
import 'package:orim/entities/issue_need_assign/issue_need_assign_request.dart';
import 'package:orim/entities/issue_need_assign/issue_need_assign_response.dart';
import 'package:orim/entities/issue_process/issue_process_request.dart';
import 'package:orim/entities/issue_process/issue_process_response.dart';
import 'package:orim/entities/issues_area/issues_area_reponse.dart';
import 'package:orim/entities/issues_area/issues_area_request.dart';
import 'package:orim/entities/report_spam/report_spam_request.dart';
import 'package:orim/entities/report_spam/report_spam_response.dart';
import 'package:orim/entities/send_approved/send_approved_request.dart';
import 'package:orim/entities/send_approved/send_approved_response.dart';
import 'package:orim/entities/send_execute/send_execute_request.dart';
import 'package:orim/entities/send_execute/send_execute_response.dart';
import 'package:orim/entities/send_info_support/send_info_support_request.dart';
import 'package:orim/entities/send_info_support/send_info_support_response.dart';
import 'package:orim/entities/send_issue/send_issue_request.dart';
import 'package:orim/entities/send_issue/send_issue_response.dart';
import 'package:orim/entities/upload_attachment_issue/upload_attachment_issue_request.dart';
import 'package:orim/entities/upload_attachment_issue/upload_attachment_issue_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/model/process.dart';
import 'package:orim/utils/api_service.dart';

import 'issue_remote.dart';

class IssueRemoteImp implements IssueRemote {
  ApiService apiService;

  final String subURLNeedAssign =
      'kong/api/core/v2/issue/get-by-assignee-condition';
  final String _sendIssueURL = "kong/api/core/v2/issue/create";
  final String _uploadSubURL = 'kong/api/upload/';
  final String _getIssueURL = 'kong/api/core/v1/issue/get-by-listid';
  final String _getIssueOfArea = 'kong/api/detail/v1/get-by-condition';
  final String _reportSpam = 'kong/api/core/v1/issue/update-recycleByLeader';
  final String _assignExecute = 'kong/api/core/v1/issue/assign-execute';
  final String _adminIssue = 'kong/api/core/v2/crm/issue/get-by-condition';
  final String _assignSupport = 'kong/api/core/v1/issue/assign-support';
  final String _getIssueProcess = 'kong/api/core/v1/issue/get-issue-processing';
  final String _update_executed = 'kong/api/core/v1/issue/update-executed';
  final String _support_confirm = 'kong/api/core/v1/issue/update-support';
  final String _approved = 'kong/api/core/v1/issue/update-approved';

  @override
  Future<ResponseListNew<IssueModel>> getIssuesWithStatus(
      {@required List<int> listAssignStatus,
      @required List<int> liststatus,
      List<int> listStatusReview,
      String token,
      String accountId,
      String departmentId,
      PaginationModel paginationModel}) async {
    Map<String, String> headers = Map.from({
      "token": token,
    });
    IssueNeedAssignRequest request = IssueNeedAssignRequest(
        listAssignStatus: listAssignStatus,
        assignee: [accountId, departmentId],
        liststatus: liststatus,
        listStatusReview: listStatusReview,
        take: paginationModel.limit,
        skip: paginationModel.offset);
    Response response;
    String jsonValue = jsonEncode(request);
    try {
      response = await apiService.get('$subURLNeedAssign?condition=$jsonValue',
          headers: headers);
      print(json.decode(response.body).toString());
      IssueNeedAssignResponse res =
          IssueNeedAssignResponse.fromJson(json.decode(response.body));
      return res;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }

  @override
  Future<ResponseObject<String>> sendIssue(
      {String token,
      String content,
      GOOGLEMAP.LatLng position,
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
    SendIssueRequest sendIssueRequest = SendIssueRequest(
        Content: content,
        location: position,
        Areadetail: areaDetail,
        categoryCode: categoryCode,
        categoryName: categoryName,
        subcategoryCode: subcategoryCode,
        subcategoryName: subcategoryName,
        name: name,
        phone: phone,
        currentProvince: currentProvince,
        currentDistrict: currentDistrict,
        currentWard: currentWard,
        token: token);
    Response response;
    try {
      response =
          await apiService.post(_sendIssueURL, data: sendIssueRequest.toJson());
      print(_sendIssueURL + " " + json.decode(response.body).toString());

      SendIssueResponse sendIssueResponse =
          SendIssueResponse.fromJson(json.decode(response.body));
      print(_sendIssueURL + " " + sendIssueResponse.isSuccess().toString());
      print(_sendIssueURL + " " + sendIssueResponse.data.toString());

      return sendIssueResponse;
    } catch (err) {
      print(_sendIssueURL + " " + err.toString());
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseObject<bool>> uploadFile(String token, List<File> files,
      String idIssue, Function(int, int) listener) async {
    List<bool> reses = List(files.length);
    for (final File file in files) {
      UploadAttachmentIssueRequest uploadAttachmentIssueRequest =
          UploadAttachmentIssueRequest(id: idIssue, token: token ?? "");
      Map<String, String> mapData =
          Map<String, String>.from(uploadAttachmentIssueRequest.toJson());
      try {
        final Response response =
            await apiService.uploadFile(_uploadSubURL, file, mapData, listener);
        print(_uploadSubURL + " " + json.decode(response.body).toString());

        if (response.statusCode >= 200 && response.statusCode < 300) {
          UploadAttachmentIssueResponse res =
              UploadAttachmentIssueResponse.fromJson(
                  json.decode(response.body));
          if (res.isSuccess()) {
            reses[files.indexOf(file)] = true;
          } else {
            res.data = false;
            return res;
          }
        } else {
          return ResponseObject.initDefault();
        }
        int index = reses.indexWhere((res) => res == false);
        ResponseObject<bool> res = ResponseObject.initDefault();
        res.data = (index < 0);
        res.code = 1;
        return res;
      } catch (err) {
        return ResponseObject.initDefault();
      }
    }
  }

  @override
  Future<ResponseListNew<IssueModel>> loadIssuesByIds(List<String> ids) async {
    try {
      HistoryIssueRequest request = HistoryIssueRequest(listid: ids);
      final Response response =
          await apiService.post(_getIssueURL, data: request.toJson());
      HistoryIssueResponse res =
          HistoryIssueResponse.fromJson(json.decode(response.body));
      return res;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }

  @override
  Future<ResponseListNew<IssueModel>> getIssueOfArea(
      {String pagination, List<int> issueStatus, String areaCode}) async {
    String listStatusString = "";
    for (int status in issueStatus) {
      listStatusString = listStatusString + '$status' + ',';
    }
    IssuesAreaRequest request = IssuesAreaRequest(
        q: EnumFilterIssue.ISSUE,
        listStatus: listStatusString,
        pagination: pagination,
        areaCode: areaCode);
    Response response;
    try {
      response = await apiService.get(
          '$_getIssueOfArea?q=${request.q}&${request.pagination}&listStatus=${request.listStatus}&areaCode=${request.areaCode}',
          headers: request.getHeaders(Cert.superToken));
      IssuesAreaResponse issuesAreaResponse =
          IssuesAreaResponse.fromJson(json.decode(response.body));
      return issuesAreaResponse;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }

  @override
  Future<ResponseObject<bool>> reportSpam(
      {String token,
      String issueid,
      String comment,
      String departmentName,
      String departmentId,
      String name,
      String accountId,
      int status}) async {
    ReportSpamRequest request = ReportSpamRequest(
      issueid: issueid,
      departmentName: departmentName,
      departmentId: departmentId,
      comment: comment,
      status: status,
      fullName: name,
      accountId: accountId,
    );
    Map<String, String> headers = Map.from({'token': token});
    Response response;
    try {
      response = await apiService.post(_reportSpam,
          headers: headers, data: request.toJson());
      ReportSpamResponse reportSpamResponse =
          ReportSpamResponse.fromJson(json.decode(response.body));
      return reportSpamResponse;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
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
  }) async {
    AssignExecuteRequest<AssigneeOfficer> request =
        AssignExecuteRequest.fromOfficer(
            issueId: issueId,
            departmentNameAssigner: departmentNameAssigner,
            departmentIdAssigner: departmentIdAssigner,
            nameAssigner: nameAssigner,
            areaAssigner: areaAssigner,
            accountIdAssigner: accountIdAssigner,
            contentAssign: contentAssign,
            supportContentAssign: supportContentAssign,
            assignee: assignee,
            supporters: supporters);
    Map<String, String> headers = Map.from({
      'token': token,
    });
    Response response;
    try {
      response = await apiService.post('$_assignExecute',
          data: request.toJson(), headers: headers);
      AssignResponse assignExecuteResponse =
          AssignResponse.fromJson(json.decode(response.body));
      return assignExecuteResponse;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseObject<bool>> assignDepartmentExecute(
      {String token,
      String issueId,
      String departmentNameAssigner,
      String departmentIdAssigner,
      String nameAssigner,
      Map<String, dynamic> areaAssigner,
      String accountIdAssigner,
      String contentAssign,
      List<DepartmentModel> assignee}) async {
    AssignExecuteRequest<AssigneeDepartment> request =
        AssignExecuteRequest.fromDepartment(
            issueId: issueId,
            departmentNameAssigner: departmentNameAssigner,
            departmentIdAssigner: departmentIdAssigner,
            nameAssigner: nameAssigner,
            areaAssigner: areaAssigner,
            accountIdAssigner: accountIdAssigner,
            contentAssign: contentAssign,
            assignee: assignee);
    Map<String, String> headers = Map.from({
      'token': token,
    });

    Response response;
    try {
      response = await apiService.post('$_assignExecute',
          data: request.toJson(), headers: headers);
      AssignResponse assignExecuteResponse =
          AssignResponse.fromJson(json.decode(response.body));
      return assignExecuteResponse;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseObject<bool>> assignSupport(
      {String token,
      String issueId,
      String departmentNameAssigner,
      String departmentIdAssigner,
      String nameAssigner,
      Map<String, dynamic> areaAssigner,
      String accountIdAssigner,
      String contentAssign,
      List<OfficerModel> assignee}) async {
    AssignExecuteRequest<AssigneeOfficer> request =
        AssignExecuteRequest.fromOfficer(
            issueId: issueId,
            departmentNameAssigner: departmentNameAssigner,
            departmentIdAssigner: departmentIdAssigner,
            nameAssigner: nameAssigner,
            areaAssigner: areaAssigner,
            accountIdAssigner: accountIdAssigner,
            contentAssign: contentAssign,
            supportContentAssign: null,
            assignee: assignee,
            supporters: null);
    Map<String, String> headers = Map.from({
      'token': token,
    });
    print('headers ${json.encode(headers)}');
    print('data ${json.encode(request.toJson())}');
    Response response;
    try {
      response = await apiService.post('$_assignSupport',
          data: request.toJson(), headers: headers);
      print(json.decode(response.body).toString());
      AssignResponse res = AssignResponse.fromJson(json.decode(response.body));
      return res;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseListNew<IssueProcessModel>> getProcess(
      {String token, String issueId}) async {
    Map<String, String> headers = Map.from({
      'token': token,
    });
    IssueProcessRequest request = IssueProcessRequest(issueId: issueId);
    Response response;
    try {
      response = await apiService.post(_getIssueProcess,
          data: request.toJson(), headers: headers);
      print(json.decode(response.body).toString());
      IssueProcessResponse issueProcessResponse =
          IssueProcessResponse.fromJson(json.decode(response.body));
      return issueProcessResponse;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }

  @override
  Future<ResponseObject<bool>> sendInfoProcess(
      {String token,
      String issueId,
      String comment,
      int categoryExeId,
      String departmentNameAssigner,
      String assignerName,
      String accountIdAssigner,
      String departmentIdAssigner,
      Map<String, dynamic> areaAssigner}) async {
    Map<String, String> headers = Map.from({"token": token});
    SendExecuteRequest sendExecuteRequest = SendExecuteRequest(
        issueId: issueId,
        categoryExecute: categoryExeId,
        comment: comment,
        departmentNameAssigner: departmentNameAssigner,
        departmentIdAssigner: departmentIdAssigner,
        nameAssigner: assignerName,
        areaAssigner: areaAssigner,
        accountIdAssigner: accountIdAssigner);
    Response response;
    try {
      response = await apiService.post('$_update_executed',
          data: sendExecuteRequest.toJson(), headers: headers);
      print(json.decode(response.body).toString());
      SendExecuteResponse sendExecuteResponse =
          SendExecuteResponse.fromJson(json.decode(response.body));

      return sendExecuteResponse;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseObject<bool>> sendInfoSupport(
      {String token,
      String departmentNameAssigner,
      Map<String, dynamic> areaAssigner,
      String nameAssigner,
      String accountIdAssigner,
      String departmentIdAssigner,
      String issueId,
      String comment}) async {
    Map<String, String> headers = Map.from({"token": token});
    SendInfoSupportRequest request = SendInfoSupportRequest(
        issueId: issueId,
        departmentNameAssigner: departmentIdAssigner,
        areaAssigner: areaAssigner,
        nameAssigner: nameAssigner,
        accountIdAssigner: accountIdAssigner,
        departmentIdAssigner: departmentIdAssigner,
        comment: comment);
    Response response;
    try {
      response = await apiService.post('$_support_confirm',
          data: request.toJson(), headers: headers);
      print(json.decode(response.body).toString());

      SendInfoSupportResponse sendInfoSupportResponse =
          SendInfoSupportResponse.fromJson(json.decode(response.body));
      return sendInfoSupportResponse;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseObject<bool>> sendInfoApproved(
      {String token,
      String departmentNameAssigner,
      Map<String, dynamic> areaAssigner,
      String nameAssigner,
      String accountIdAssigner,
      String departmentIdAssigner,
      String issueId,
      String comment}) async {
    Map<String, String> headers = Map.from({
      'token': token,
    });
    SendApprovedRequest request = SendApprovedRequest(
        issueId: issueId,
        departmentNameAssigner: departmentNameAssigner,
        areaAssigner: areaAssigner,
        nameAssigner: nameAssigner,
        accountIdAssigner: accountIdAssigner,
        departmentIdAssigner: departmentIdAssigner,
        comment: comment);
    Response response;
    try {
      response = await apiService.post('$_approved',
          data: request.toJson(), headers: headers);
      print(json.decode(response.body).toString());

      SendApprovedResponse sendApprovedResponse =
          SendApprovedResponse.fromJson(json.decode(response.body));
      return sendApprovedResponse;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }

  @override
  Future<ResponseListNew<IssueModel>> getIssueRootAdministration(
      {List<int> liststatus,
      String token,
      String areaCodeStatic,
      String kindOfTime,
      PaginationModel paginationModel}) async {
    Map<String, String> headers = Map.from({
      "token": token,
    });
    IssueAdministrationRequest request = IssueAdministrationRequest(
        areaCodeStatic: areaCodeStatic,
        liststatus: liststatus,
        kindOfTime: kindOfTime,
        take: paginationModel.limit,
        skip: paginationModel.offset);
    Response response;
    String jsonValue = jsonEncode(request);
    try {
      response = await apiService.get('$_adminIssue?condition=$jsonValue',
          headers: headers);
      print(json.decode(response.body).toString());
      IssueAdministrationResponse res =
          IssueAdministrationResponse.fromJson(json.decode(response.body));
      return res;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }
}
