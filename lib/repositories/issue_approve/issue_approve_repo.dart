import 'package:orim/base/base_reponse.dart';

abstract class IssueApproveRepo {
  Future<ResponseObject<bool>> approve(
      {String token,
      String departmentNameAssigner,
      Map<String, dynamic> areaAssigner,
      String nameAssigner,
      String accountIdAssigner,
      String departmentIdAssigner,
      String issueId,
      String comment});
}
