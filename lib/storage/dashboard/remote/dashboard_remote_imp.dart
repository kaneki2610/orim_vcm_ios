import 'dart:convert';
import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/dashboard/dashboard_response.dart';
import 'package:orim/entities/dashboard/dashboard_resquest.dart';
import 'package:orim/model/dashboardarea/dashboard_object.dart';
import 'package:orim/storage/dashboard/remote/dashboard_remote.dart';
import 'package:orim/utils/api_service.dart';

class DashBoardRemoteImp implements DashBoardRemote {
  ApiService apiService;
  final String _urlGetDashBoard = 'kong/api/core/v1/dashboard/all';

  @override
  Future<ResponseObject<DashBoardObjectModel>> getTotalDashBoard(
      {String token, String codeArea, String kindOfTime}) async {
    DashboardRequest request =
        DashboardRequest(areaCodeStatic: codeArea, kindOfTime: kindOfTime);
    print(request.toJson().toString());
    Map<String, String> headers = request.getHeaders(token);
    Response response;
    try {
      response = await apiService.post(_urlGetDashBoard,
          headers: headers, data: request.toJson());
      DashBoardResponse res =
          DashBoardResponse.fromJson(json.decode(response.body));
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }
}
