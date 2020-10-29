import 'package:orim/base/base_reponse.dart';
import 'package:orim/repositories/issue_approve/issue_approve_repo.dart';
import 'package:orim/storage/issue/remote/issue_remote.dart';

class IssueApproveImp implements IssueApproveRepo {

  IssueRemote issueRemote;

  @override
  Future<ResponseObject<bool>> approve({String token,
    String departmentNameAssigner,
    Map<String, dynamic> areaAssigner,
    String nameAssigner,
    String accountIdAssigner,
    String departmentIdAssigner,
    String issueId,
    String comment}) async {
    return await issueRemote.sendInfoApproved(token: token,
      departmentNameAssigner: departmentNameAssigner,
      areaAssigner: areaAssigner,
      nameAssigner: nameAssigner,
      accountIdAssigner: accountIdAssigner,
      departmentIdAssigner: departmentIdAssigner,
      issueId: issueId,
      comment: comment);
  }
}
