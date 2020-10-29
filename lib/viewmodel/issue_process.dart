import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/process.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/issue_process/issue_process_repo.dart';

class IssueProcessViewModel extends BaseViewModel<List<IssueProcessModel>> {
  AuthRepo authRepo;
  IssueProcessRepo issueProcessRepo;

  Future<ResponseListNew<IssueProcessModel>> getProcesses({String issueId}) async {
    print('issueId $issueId');
    AuthModel auth = await authRepo.getAuth();
    ResponseListNew<IssueProcessModel>res = await issueProcessRepo.getProcesses(
        token: auth.token, issueId: issueId);
    if(res.isSuccess()){
      this.data = res.datas;
    }else{
      this.data = [];
    }
    return res;
  }
}
