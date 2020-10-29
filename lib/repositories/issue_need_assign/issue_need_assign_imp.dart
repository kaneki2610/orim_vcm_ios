import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/repositories/issue_need_assign/issue_need_assign_repo.dart';
import 'package:orim/storage/issue/remote/issue_remote.dart';

class IssueNeedAssignImp implements IssueNeedAssignRepo {
  IssueRemote issueNeedAssignRemote;

  @override
  Future<ResponseListNew<IssueModel>> getIssuesWithStatus(
      {@required List<int> listAssignStatus,
      @required List<int> liststatus,
        List<int> listStatusReview,
      String accountId,
      String token,
      String departmentId,
      PaginationModel paginationModel}) async {
    ResponseListNew<IssueModel> res =
        await issueNeedAssignRemote.getIssuesWithStatus(
            listAssignStatus: listAssignStatus,
            liststatus: liststatus,
            listStatusReview: listStatusReview,
            token: token,
            accountId: accountId,
            departmentId: departmentId,
            paginationModel: paginationModel);
    return res;
  }

  @override
  Future<ResponseObject<bool>> assignSpecialistExecute(
      {String token,
      String departmentNameAssigner,
      String departmentIdAssigner,
      String nameAssigner,
      String issueId,
      Map<String, dynamic> areaAssigner,
      String accountIdAssigner,
      String contentAssign,
      String supportContentAssign,
      List<OfficerModel> assignee,
      List<DepartmentModel> supporters}) async {
    return await issueNeedAssignRemote.assignSpecialistExecute(
      token: token,
      issueId: issueId,
      departmentNameAssigner: departmentNameAssigner,
      departmentIdAssigner: departmentIdAssigner,
      nameAssigner: nameAssigner,
      areaAssigner: areaAssigner,
      accountIdAssigner: accountIdAssigner,
      contentAssign: contentAssign,
      supportContentAssign: supportContentAssign,
      assignee: assignee,
      supporters: supporters,
    );
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
    return await issueNeedAssignRemote.assignDepartmentExecute(
      token: token,
      issueId: issueId,
      departmentNameAssigner: departmentNameAssigner,
      departmentIdAssigner: departmentIdAssigner,
      nameAssigner: nameAssigner,
      areaAssigner: areaAssigner,
      accountIdAssigner: accountIdAssigner,
      contentAssign: contentAssign,
      assignee: assignee,
    );
  }

  @override
  Future<ResponseObject<bool>> assignSupport(
      {String token,
      String departmentNameAssigner,
      String departmentIdAssigner,
      String nameAssigner,
      String issueId,
      Map<String, dynamic> areaAssigner,
      String accountIdAssigner,
      String contentAssign,
      List<OfficerModel> assignee}) async {
    return await issueNeedAssignRemote.assignSupport(
        token: token,
        departmentNameAssigner: departmentNameAssigner,
        departmentIdAssigner: departmentIdAssigner,
        nameAssigner: nameAssigner,
        issueId: issueId,
        areaAssigner: areaAssigner,
        accountIdAssigner: accountIdAssigner,
        contentAssign: contentAssign,
        assignee: assignee);
  }
}
