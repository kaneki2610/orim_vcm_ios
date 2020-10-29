import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/dashboardarea/dashboard_object.dart';
import 'package:orim/repositories/dashboard/dashboard_repo.dart';
import 'package:orim/storage/dashboard/remote/dashboard_remote_imp.dart';

class DashBoardImp implements DashBoardRepo {

  DashBoardRemoteImp dashBoardRemoteImp;


  @override
  Future<ResponseObject<DashBoardObjectModel>> getTotalDetailDashBoard(
      {String areaCodeStatic, String kindOfTimes, String token}) async {
    ResponseObject<DashBoardObjectModel> totalDashBoard =
    await dashBoardRemoteImp.getTotalDashBoard(
        token: token, codeArea: areaCodeStatic, kindOfTime: kindOfTimes);
    return totalDashBoard;
  }

}