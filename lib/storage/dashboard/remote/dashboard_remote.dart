import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/dashboardarea/dashboard_object.dart';
abstract class DashBoardRemote {
  Future<ResponseObject<DashBoardObjectModel>> getTotalDashBoard({ String token, String codeArea, String kindOfTime });
}