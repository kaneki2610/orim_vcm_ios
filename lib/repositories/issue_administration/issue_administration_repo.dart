
import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/pagination/pagination_model.dart';

abstract class IssueAdminRepo {
  Future<ResponseListNew<IssueModel>> getIssueRootAdministration(
      {@required List<int> liststatus,
        String token,
        String areaCodeStatic,
        String kindOfTime,
        PaginationModel paginationModel});
}