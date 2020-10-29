import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/process.dart';
import 'package:orim/repositories/issue_process/issue_process_repo.dart';
import 'package:orim/storage/issue/remote/issue_remote.dart';

class IssueProcessImp implements IssueProcessRepo {
  IssueRemote issueRemote;

  @override
  Future<ResponseListNew<IssueProcessModel>>getProcesses(
      {String token, String issueId}) async {
    return await issueRemote.getProcess(token: token, issueId: issueId);
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
    return await issueRemote.sendInfoProcess(
        token: token,
        issueId: issueId,
        comment: comment,
        categoryExeId: categoryExeId,
        departmentNameAssigner: departmentNameAssigner,
        assignerName: assignerName,
        departmentIdAssigner: departmentIdAssigner,
        accountIdAssigner: accountIdAssigner,
        areaAssigner: areaAssigner);
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
    return await issueRemote.sendInfoSupport(
        token: token,
        departmentNameAssigner: departmentNameAssigner,
        areaAssigner: areaAssigner,
        nameAssigner: nameAssigner,
        accountIdAssigner: accountIdAssigner,
        departmentIdAssigner: departmentIdAssigner,
        issueId: issueId,
        comment: comment);
  }
}
