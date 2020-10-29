import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/process.dart';

abstract class IssueProcessRepo {
    Future<ResponseListNew<IssueProcessModel>> getProcesses({String token, String issueId});

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

  Future<ResponseObject<bool>> sendInfoSupport(
      {String token,
      String departmentNameAssigner,
      Map<String, dynamic> areaAssigner,
      String nameAssigner,
      String accountIdAssigner,
      String departmentIdAssigner,
      String issueId,
      String comment});
}
