import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/storage/issue/remote/issue_remote.dart';

import 'issues_area_repo.dart';

class IssueAreaImp implements IssueAreaRepo {
  IssueRemote issueRemote;

  @override
  Future<ResponseListNew<IssueModel>> getIssueOfArea(
      {String pagination, List<int> issueStatus, String areaCode}) async {
    return await issueRemote.getIssueOfArea(
        pagination: pagination,
        issueStatus: issueStatus,
        areaCode: areaCode);
  }
}
