import 'package:flutter/cupertino.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/dashboardarea/dashboard_object.dart';

abstract class DashBoardRepo {

  Future<ResponseObject<DashBoardObjectModel>> getTotalDetailDashBoard({
    @required String areaCodeStatic,
    @required String kindOfTimes,
    String token
  });
}