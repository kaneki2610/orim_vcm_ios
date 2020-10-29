import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/issue/issue.dart';

abstract class IssueAreaRepo {
  Future<ResponseListNew<IssueModel>> getIssueOfArea(
      {String pagination, List<int> issueStatus, String areaCode});
}
