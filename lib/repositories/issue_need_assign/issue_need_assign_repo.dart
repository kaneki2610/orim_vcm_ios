import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/model/pagination/pagination_model.dart';

abstract class IssueNeedAssignRepo {
  Future<ResponseListNew<IssueModel>> getIssuesWithStatus(
      {@required List<int> listAssignStatus,
      @required List<int> liststatus,
        List<int> listStatusReview,
      String accountId,
      String token,
      String departmentId,
      PaginationModel paginationModel});

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
      List<DepartmentModel> supporters});

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

  Future<ResponseObject<bool>> assignSupport(
      {String token,
      String departmentNameAssigner,
      String departmentIdAssigner,
      String nameAssigner,
      String issueId,
      Map<String, dynamic> areaAssigner,
      String accountIdAssigner,
      String contentAssign,
      List<OfficerModel> assignee});
}
