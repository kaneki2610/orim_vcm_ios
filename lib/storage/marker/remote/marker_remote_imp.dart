import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/marker_real_time/marker_real_time_request.dart';
import 'package:orim/entities/marker_real_time/marker_real_time_response.dart';
import 'package:orim/model/marker.dart';
import 'package:orim/utils/api_service.dart';

import 'marker_remote.dart';

class MarkerRemoteImp implements MarkerRemote {
  ApiService apiService;
  final String subURLMarker = 'kong/api/detail/v1/getIssueByAreacodeUnfinish';

  @override
  Future<ResponseListNew<MarkerModel>> getListMarker(
      {String token, String areaCode, String fromDate, String toDate}) async {
    Map<String, String> headers = Map.from({"token": token});
    MarkerRealTimeRequest request = MarkerRealTimeRequest(
        areaCode: areaCode, fromDate: fromDate, toDate: toDate);

    print(subURLMarker + request.getUrl);

    Response response;
    try {
      response = await apiService.get(
        subURLMarker + request.getUrl,
        headers: headers,
      );
      print(json.decode(response.body).toString());
      MarkerRealTimeResponse res =
          MarkerRealTimeResponse.fromJson(json.decode(response.body));
      return res;
    } catch (err) {
      return ResponseListNew.initDefault();
    }
  }
}
