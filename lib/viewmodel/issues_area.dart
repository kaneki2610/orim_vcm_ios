import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/repositories/issues_area/issues_area_repo.dart';

class IssuesAreaViewModel extends BaseViewModel<List<IssueModel>> {

  IssueAreaRepo issueAreaRepo;

  Future<ResponseListNew<IssueModel>> getIssueArea(String areaCode, String pagination) async {
    List<int> statuses = [
      IssueStatusEnum.ApprovedComplete,
      IssueStatusEnum.RecycleIssue,
      IssueStatusEnum.OutOfBound
    ];

    ResponseListNew<IssueModel> response = await issueAreaRepo.getIssueOfArea(pagination: pagination,
        issueStatus: statuses, areaCode: areaCode);
    data = response.datas ?? [];

    return response;
  }
}
