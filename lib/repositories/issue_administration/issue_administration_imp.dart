import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/pagination/pagination_model.dart';
import 'package:orim/storage/issue/remote/issue_remote.dart';

import 'issue_administration_repo.dart';

class IssueAdminImp implements IssueAdminRepo {
  IssueRemote issueNeedAssignRemote;

  @override
  Future<ResponseListNew<IssueModel>> getIssueRootAdministration(
      {List<int> liststatus,
      String token,
      String areaCodeStatic,
      String kindOfTime,
      PaginationModel paginationModel}) async {
    ResponseListNew<IssueModel> reponse =
        await issueNeedAssignRemote.getIssueRootAdministration(
            liststatus: liststatus,
            areaCodeStatic: areaCodeStatic,
            kindOfTime: kindOfTime,
            paginationModel: paginationModel,
            token: token);
    return reponse;
  }
}
